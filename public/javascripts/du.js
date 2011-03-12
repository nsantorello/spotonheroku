


 
 $(function(){
	
		
	$('#ready').animate({left:'640px'},500, function(){
		$('#ready').show();								 	
		$('#ready').animate({left:'210px'}, 250, function(){
			$('#ready').animate({opacity:0}, 1000, function(){
				$('#set').show();								 	
				$('#set').animate({left:'260px'}, 250, function(){
					$('#set').animate({opacity:0}, 1000, function(){
						$('#go').show();								 	
						$('#go').animate({left:'260px'}, 250, function(){
							$('#go').animate({opacity:0}, 500, function(){
																			 
									startRound();
							});								 
						});										 
					});								 
				});														
			});								 
		});
	});

 
		   
	/*$('#question_text').animate({width:0, height:0, top:'210px'}, 10, function(){
		$('#question_text').animate({opacity:1, width:'540px', height:'210px', top:0}, 500);
	});*/

});
 
function startRound() {
	
	$('#question_text').animate({width:0, height:0, top:'210px'}, 10, function(){
		$('#question_text').animate({opacity:1, width:'540px', height:'210px', top:0}, 400);
		$('#answers').fadeIn(600);
	});
 }