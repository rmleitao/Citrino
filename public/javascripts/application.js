// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
});

// function remove_fields(link) {
//   $(link).previous("input[type=hidden]").value = "1";
//   $(link).up(".inputs").hide();
// }
// 
function remove_fields(link){
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  $(link).parent().before(content.replace(regexp, new_id));
}

function magic_rotator(){
	$(".paging").show();
  $(".paging a:first").addClass("active");
  	var imageWidth = $(".window").width();
  	var imageSum = $(".image_reel div").size();
  	var imageReelWidth = imageWidth * imageSum;
		var play = 0;
		
  	//Adjust the image reel to its new size
  	$(".image_reel").css({'width' : imageReelWidth});

  	//Paging + Slider Function
  	rotate = function(){	
			//console.log("rotate-" + play);
  		var triggerID = $active.attr("rel") - 1; //Get number of times to slide
  		var image_reelPosition = triggerID * imageWidth; //Determines the distance the image reel needs to slide
  		$(".paging a").removeClass('active'); //Remove all active class
  		$active.addClass('active'); //Add active class (the $active is declared in the rotateSwitch function)
  		//Slider Animation
  		$(".image_reel").animate({ 
  			left: -image_reelPosition
  		}, 700 );
  	}; 
		
		function change_slider(){ //Set timer - this will repeat itself every 3 seconds
			$active = $('.paging a.active').next();
			if ( $active.length === 0) { //If paging reaches the end...
				$active = $('.paging a:first'); //go back to first
			}
			rotate(); //Trigger the paging and slider function
		}
		
  	//Rotation + Timing Event
  	rotateSwitch = function(){	
			//console.log("rotateSwitch");
  		if(play < 3){
				play = setInterval(change_slider,5000); //Timer speed in milliseconds (3 seconds)
			}else{
				clearInterval(play);
			}
  	};

		//console.log("rotatesw-" + play);
  	rotateSwitch(); //Run function on launch

  	//On Hover
  	$("div.header_center").hover(function() {
		//	console.log("clearinterval");
			clearInterval(play); //Stop the rotation
		//	console.log("cleared interval: " + play);
  	});
		//, function() {
  		// rotateSwitch(); //Resume rotation
  	//});	

  	//On Click
  	$(".paging a").click(function() {	
  		$active = $(this); //Activate the clicked paging
  		//Reset Timer
  		clearInterval(play); //Stop the rotation
  		rotate(); //Trigger rotation immediately
  		rotateSwitch(); // Resume rotation
  		return false; //Prevent browser jump to link anchor
  	});
}

function magic_menu(){
    var $el, leftPos, newWidth, $mainNav2 = $("#menu");
           
    $mainNav2.append("<li id='magic-line'></li>");
    var $magicLineTwo = $("#magic-line");
    
    $magicLineTwo
        .width($(".current_page_item_two").width())
        .height($mainNav2.height())
        .css("left", $(".current_page_item_two a").position().left)
        .data("origLeft", $(".current_page_item_two a").position().left)
        .data("origWidth", $magicLineTwo.width())
        .data("origColor", $(".current_page_item_two a").attr("rel"));
                
    $("#menu li").find("a").hover(function() {
        $el = $(this);
        leftPos = $el.position().left;
        newWidth = $el.parent().width();
        $magicLineTwo.stop().animate({
            left: leftPos,
            width: newWidth,
            backgroundColor: $el.attr("rel")
        });
    }, function() {
        $magicLineTwo.stop().animate({
            left: $magicLineTwo.data("origLeft"),
            width: $magicLineTwo.data("origWidth"),
            backgroundColor: $magicLineTwo.data("origColor")
        });    
    });
};

function load_flickr_photos(flickrid){
	$("#flikr_images").html("<ul></ul>");
	
	$.getJSON("http://api.flickr.com/services/feeds/photos_public.gne?id="+flickrid+"&format=json&jsoncallback=?", function(data){
    
    $.each(data.items, function(i,item){
			if(i<14){
	      $("<img width='52px' height='52px'/>").attr("src", item.media.m).appendTo("#flikr_images ul").wrap("<li><a href='" + item.link + "'></a></li>");
			}      
    });
  });
}