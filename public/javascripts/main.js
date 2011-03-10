spoton = {};
spoton.baseurl = 'http://spoton.heroku.com/api/';
spoton.player_id = null;
spoton.venue_id = null;
spoton.venue_name = null;
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
	$('#location').append('Looking for nearby venues.');

	//real-geo
	 spoton.get_geo(return_results);
	
	//fake-geo
	//return_results({lat:30.25,lon:-97.75,player_id:spoton.player_id});

}

spoton.show_venues = function(venues){
	$('#venues > ul').empty();
	jQuery.each(venues, function(index,value){
		// console.warn(JSON.stringify(value));
		var v = document.createElement('li');
		console.warn('value',value);
		var dist = ' <span class=\'distance\'>' + String(value.distance) + 'm</span>';
		$(v).append(value.name + dist)
		.attr('venue_id',value.id)
		.bind('click', function() {
			spoton.venue_id = value.id;
			spoton.venue_name = value.name;
			spoton.request_session(spoton.venue_id);
		});
		$('#venues_view > ul').append(v);
	})
}

spoton.request_session = function(venue_id){
	var url = spoton.baseurl + 'play/request';
	var data = {venue_id:venue_id};
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

spoton.show_question = function(){
	if(spoton.questions != null){
		if(spoton.questions_prog < spoton.questions.length){
			$('#location').text = spoton.venue_name;
			$('#answers > ol').empty();
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

			jQuery.each(value.responses, function(i,v){
				var a = document.createElement('li');
				$(a).attr('answer_id', v.id)
					.text(v.text);
				$(a).bind('click', function() {
					spoton.answers.push(v.id);
					if(v.id == $('#question_text').attr('answer_id')){
						// alert('Correct! User clicked on "' + v.id + '"');
						$(a).css('background-color','#0F0');
						spoton.questions_prog = spoton.questions_prog + 1;
						spoton.number_correct = spoton.number_correct + 1;
						spoton.number_played = spoton.number_played + 1;
						
						setTimeout('spoton.show_question();',2000);
					} else {
						// alert('Incorrect! User clicked on "' + v.id + '"');
						$(a).css('background-color','#F00');
						spoton.questions_prog = spoton.questions_prog + 1;
						spoton.number_played = spoton.number_played + 1;
						setTimeout('spoton.show_question();',2000);
					}
				});
				$('#answers > div > ol').append(a);
			});
		} else {
			$('#progress-indicator').css('width','100%');
			spoton.submit_answers(spoton.player_id,spoton.session_id,spoton.answers,spoton.log);
			spoton.answers = [];
			alert('Answers Submitted!' + String(spoton.number_correct/spoton.number_played*100) + '% Correct!');
		}
	} else {
		alert('no questions')
	}
}
spoton.submit_answers = function(player_id,session_id,answers,callback){
	var url = spoton.baseurl + 'play/submit';
	answers = answers.join(',');
	var data = {player_id:player_id,session_id:session_id,answers:answers,}
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


spoton.login = function(){
	$('#home').addClass('hidden');
	$('#login').removeClass('hidden');
	// function populateDB(tx) {
	//      // tx.executeSql('DROP TABLE `spoton`');
	//      tx.executeSql('CREATE TABLE IF NOT EXISTS `spoton` (id unique, data)');
	//      tx.executeSql('INSERT INTO spoton (id, data) VALUES (1, "First row")');
	//      tx.executeSql('INSERT INTO spoton (id, data) VALUES (2, "Second row")');
	// }
	// 
	// function errorCB(err) {
	// 	console.warn(err);
	// 	// alert("Error processing SQL: "+err.code);
	// }
	// 
	// function successCB() {
	// 	alert("success!");
	// }
	// 
	// var db = window.openDatabase("spoton", "1.0", "Spot On Trivia", 1000000);
	// db.transaction(populateDB, errorCB, successCB);

}

spoton.venues = function(){
	$('#login').addClass('hidden');
	$('#venues').removeClass('hidden');
	spoton.get_venues();
}

// spoton.answer = function(ans){
// 	var self = this;
// 	var a = document.createElement('li');
// 	a.className = 'answer';
// 	a.id = 'answer_' + ans.answer_id;
// 	a.addEventListener('click',function(e){alert('Clicked on ' + a.id)});
// 	$('ul').appendChild(a);
// }

// spoton.user_check = function()
// {
//     db.transaction(function(tx) {
//         tx.executeSql("SELECT id, data FROM `spoton`", [], function(tx, result) {
//             for (var i = 0; i < result.rows.length; ++i) {
//                 var row = result.rows.item(i);
//                 var note = new Note();
//                 note.id = row['id'];
//                 note.text = row['note'];
//                 note.timestamp = row['timestamp'];
//                 note.left = row['left'];
//                 note.top = row['top'];
//                 note.zIndex = row['zindex'];
// 
//                 if (row['id'] > highestId)
//                     highestId = row['id'];
//                 if (row['zindex'] > highestZ)
//                     highestZ = row['zindex'];
//             }
// 
//             if (!result.rows.length)
//                 newNote();
//         }, function(tx, error) {
//             alert('Failed to retrieve notes from database - ' + error.message);
//             return;
//         });
//     });
// }
