spoton = {};
spoton.baseurl = 'http://spoton.heroku.com/api/';
spoton.player_id = null;
spoton.venue_id = null;
spoton.venue_name = null;
spoton.venue_type = null;
spoton.questions = null;
spoton.session_id = null;
spoton.answers = [];
spoton.questions_prog = 0;
spoton.number_correct = 0;
spoton.number_played = 0;

spoton.log = function(x){
	console.log(x);
}

spoton.get_geo = function(callback){
	// $('#location').empty();
	var fail = function(error){
		$('#location').append('Failed to get GPS location');
	}
	if(navigator.geolocation){
		var geo = function(p){
			$('#location').empty();
			$('#location').append("Lat:"+p.coords.latitude + ", Lon:" + p.coords.longitude);
			// alert("Latitude:"+p.coords.latitude + " " + p.coords.longitude);
			// console.warn(p);
			var data = {lat: p.coords.latitude, lon: p.coords.longitude, player_id:spoton.player_id};
			callback(data);
		}
		// $('#location').append('Getting geolocation.');
		navigator.geolocation.getCurrentPosition(geo,fail);
	} else {
		fail();
	}
}

spoton.get_venues = function(){
	$('#location').empty();
	var return_results = function(data){
		$('#location').empty();
		var url = spoton.baseurl + 'venues/get';
		var venue_query = {
			url:url,
			data:data,
			dataType:'json',
			success:function(result){
				console.warn('venues',result)
				spoton.show_venues(result);
			}
		}
		jQuery.ajax(venue_query);
	}
	$('#venues_header').css('color','#000').empty().append('Loading Venues');
	$('#venues').css('background','url(/images/loading.gif)').css('background-position','top center').css('background-repeat','no-repeat').css('height', '100%');
	// $('#location').append('Looking for nearby venues.');

	//real-geo
	 spoton.get_geo(return_results);
	
	//fake-geo
	//return_results({lat:30.25,lon:-97.75,player_id:spoton.player_id});

}

spoton.show_venues = function(venues){
	$('#venues').css('background','');
	$('#venues_header').css('color','#DBDBDB').empty().append('Venues Nearby');
	$('#venues > ul').empty();
	jQuery.each(venues, function(index,value){
		// console.warn(JSON.stringify(value));
		var v = document.createElement('li');
		if(value.name.length > 30){
			$(v).css('font-size','30px');
			if(value.name.length > 45){
				$(v).css('font-size','24px');
			}
		}
		
		console.warn('value',value);
		var dist = ' <span class=\'distance\'>' + String(value.distance) + 'm</span>';
		$(v).append(value.name + dist)
		.attr('venue_id',value.id)
		.bind('click', function() {
			spoton.venue_id = value.id;
			spoton.venue_name = value.name;
			spoton.venue_type = value.description;
			spoton.request_session(spoton.venue_id,spoton.player_id);
		});
		$('#venues_view > ul').append(v);
	})
}

spoton.request_session = function(venue_id,player_id){
	var url = spoton.baseurl + 'play/request';
	var data = {venue_id:venue_id,player_id:player_id};
	var session_query = {
		url:url,
		data:data,
		dataType:'json',
		success:function(result){
			spoton.session_id = result.id;
			spoton.get_questions(result.id);
		}
	}
	spoton.log('Getting a session.');
	jQuery.ajax(session_query);
	
}

spoton.get_questions = function(session_id){
	$('#question').removeClass('hidden');
	var url = spoton.baseurl + 'play/questions';
	var data = {session_id:session_id};
	var question_query = {
		url:url,
		data:data,
		dataType:'json',
		success:function(result){
			spoton.questions = result;
			spoton.show_question();

		}
	}
	spoton.log('Getting questions.');
	jQuery.ajax(question_query);
}

spoton.update_stats = function(){
	$('#curr_points').empty();
	$('#curr_points').append(String(spoton.number_correct) + '/' + String(spoton.number_played));
	// spoton.number_played
	// spoton.number_correct
}

spoton.show_question = function(){
	if(spoton.questions != null){
		spoton.update_stats();
		$('#stats').removeClass('hidden');
		if(spoton.questions_prog < spoton.questions.length){
			$('#question_venue').text = spoton.venue_name;
			$('#question_category').empty();
			$('#question_category').append(spoton.venue_type);
			$('ol').empty();
			$('#venues').addClass('hidden');
			$('#questions').removeClass('hidden');
			
			value = spoton.questions[spoton.questions_prog];
			var percent = String(spoton.questions_prog/spoton.questions.length*100) + '%';
			// alert(percent);
			$('#progress-indicator').css('width',percent);
			console.warn(value);
			
			$('#question_text').text(value.text)
				.attr('question_id',value.id)
				.attr('answer_id', value.answer_id)
			
			$('#question_venue').text(spoton.venue_name);

			var shuffle = function shuffle(array) {
				var tmp, current, top = array.length;
				if(top) while(--top) {
					current = Math.floor(Math.random() * (top + 1));
					tmp = array[current];
					array[current] = array[top];
					array[top] = tmp;
				}
				return array;
			}

			shuffle(value.responses);

			jQuery.each(value.responses, function(i,v){
				var a = document.createElement('li');
				$(a).attr('answer_id', v.id)
					.text(v.text);
					
				if(v.text.length > 20){
					$(a).css('font-size','16px');
				}
				
				$(a).bind('click', function() {
					spoton.answers.push(v.id);
					if(v.id == $('#question_text').attr('answer_id')){
						// alert('Correct! User clicked on "' + v.id + '"');
						$(a).css('background-image','none').css('background','#65BE59');
						spoton.questions_prog = spoton.questions_prog + 1;
						spoton.number_correct = spoton.number_correct + 1;
						spoton.number_played = spoton.number_played + 1;
						
						setTimeout('spoton.show_question();',2000);
					} else {
						// alert('Incorrect! User clicked on "' + v.id + '"');
						$(a).css('background-image','none').css('background','#444');
						$('#answers ol li[answer_id=' + value.answer_id +']').css('background','#65BE59');
						spoton.questions_prog = spoton.questions_prog + 1;
						spoton.number_played = spoton.number_played + 1;
						// navigator.notification.vibrate(500);
						setTimeout('spoton.show_question();',2000);
					}
				});
				$('ol').append(a);
				
				$('#question_text').animate({width:0, height:0, top:'210px'}, 10, function(){
					$('#question_text').animate({opacity:1, width:'540px', height:'210px', top:0}, 400);
					$('#answers').fadeIn(600);
				});

			});
		} else {
			$('#progress-indicator').css('width','100%').css('background','url(/images/bar_bg_end.gif)');
			spoton.submit_answers(spoton.player_id,spoton.session_id,spoton.answers,spoton.show_stats);
			spoton.answers = [];
			// alert('Answers Submitted!' + String(spoton.number_correct/spoton.number_played*100) + '% Correct!');
		}
	} else {
		alert('no questions')
	}
}
spoton.submit_answers = function(player_id,session_id,answers,callback){
	var url = spoton.baseurl + 'play/submit';
	answers = answers.join(',');
	var data = {player_id:player_id,session_id:session_id,answers:answers}
	var submit_answers_query = {
		url:url,
		data:data,
		dataType:'json',
		success:function(result){
			callback(result);
		}
	}
	spoton.log('Submitting answers.');
	jQuery.ajax(submit_answers_query);
	
}

spoton.show_stats = function(stats){
	//show #stats
	spoton.log(stats);
	$('#q').addClass('hidden');
	$('#result').removeClass('hidden');
	if(stats.treat_earned){
		$(".treat_earned").removeClass('hidden');
	} else {
		$(".treat_not_earned").removeClass('hidden');
	}
	
	$('#stats').animate({top:'450px'}, 500);
	
}


spoton.login = function(){
	$('#home').addClass('hidden');
	$('#login').removeClass('hidden');
}

spoton.venues = function(){
	$('#login').addClass('hidden');
	$('#venues').removeClass('hidden');
	spoton.get_venues();
}

spoton.reset = function(){
	$('#result > div').addClass('hidden');
	$('#q').removeClass('hidden');
	$('#result').addClass('hidden');
	spoton.request_session(spoton.venue_id,spoton.player_id);
}