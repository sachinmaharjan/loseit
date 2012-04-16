$(function() {
				var $thumbnailSlider= $('#thumbnailSlider'),
					$slider			= $('#slider'),
					$pg_photos		= $('#pg_photos'),
					$pg_container	= $('#pg_container'),
					$pg_scrollWrapper	= $('#pg_scrollWrapper'),
					$pg_photos_elem	= $pg_photos.children(),
					$pg_photos_img	= $pg_photos_elem.find('img'),
					is_safari = navigator.userAgent.toLowerCase().indexOf('safari') > -1 
								&& 
									  navigator.userAgent.toLowerCase().indexOf('chrome') == -1,
					pg_photos_width	= 0;				  
				
				//preload the images				
				$pg_photos_img.preload({
					onComplete	: function(){
						init();
						//force the hashchange event
						//so that it slides to the image passed in the url
						$(window).hashchange();
					}
				});
				function init(){
					initThumbnailSlider();
					configGallery();
					initSlider();
					initEvents();
				}
				//init the thumbs slider plugin
				function initThumbnailSlider(){
					$thumbnailSlider.thumbnailSlider({
							thumb_width	: 75,
						thumb_height: 75
						});
				}
				function configGallery(){
					$('BODY').css('overflow-x','hidden');
					//we need to set the width of the $pg_photos,
					//which is the sum of its childrens width
						$pg_photos.children().each(function(){
							pg_photos_width += $(this).outerWidth(true);
						});
						$pg_photos.css('width',pg_photos_width+'px');
				}
				function initSlider(){
					$pg_scrollWrapper.show();
						//innitialize the slider
					var old_value 	= 0, //last value of the slider
						dir			= 1; //direction 	
						$slider.slider('destroy').slider({
							orientation	: 'horizontal',
							max			: pg_photos_width - $pg_photos.children(':last').outerWidth(true),
							min			: 0,
							value		: 0,
							slide		: function(event, ui) {
								$pg_photos.css('left',-ui.value+'px');						
							//the 3d effect
								if(is_safari){
								//the dir will define the value for the rotationY (negative or positive)
								dir 		= (old_value < ui.value) ? 1 : -1;
								old_value 	= ui.value;	
									if(dir == 1 && !$pg_container.hasClass('turnLeft'))	
									$pg_container.addClass('turnLeft')
												 .removeClass('turnRight flat');
									else if(dir == -1 && !$pg_container.hasClass('turnRight'))	
									$pg_container.addClass('turnRight')
												 .removeClass('turnLeft flat');
								}	
							},
							stop: function(event, ui) {
								if(is_safari){
									$pg_container.addClass('flat')
											 .removeClass('turnLeft turnRight');
								}			 
							}
						});
				}
				function initEvents(){
					//if we mouse over a photo, show the description sored in the alt attr
					$pg_photos_elem.bind('mouseenter',function(e){
						var $e		= $(this);
							$img	= $e.find('img'),
							descr	= $img.attr('alt');
						
						$('<span>'+ descr +'</span>').hide().insertAfter($img).fadeIn();
					}).bind('mouseleave',function(e){
						var $e		= $(this);
							$descr	= $e.find('span');
						
						$descr.fadeOut();
				});
				
					//slide as we scroll with the mouse
						$pg_container.mousewheel(function(e, delta) {
						var speed	= 450,
							inc 	= -delta*speed,
								min	= $slider.slider('option','min'),
								max = $slider.slider('option','max');
							
							var val = $slider.slider('value') + inc;
							if(val < min)
								val = min;
							else if(val > max)
								val = max;
							
							$slider.slider('value', val);
						$pg_photos.stop().animate({
								left	: -(val) + 'px'
						},800,'easeOutExpo',function(){
							if(is_safari){
								$pg_container.addClass('flat')
											 .removeClass('turnLeft turnRight');
							}	
						});
						if(is_safari){
							if(delta < 0 && !$pg_container.hasClass('turnLeft'))	
								$pg_container.addClass('turnLeft')
											 .removeClass('turnRight flat');
							else if(delta > 0 && !$pg_container.hasClass('turnRight'))	
								$pg_container.addClass('turnRight')
											 .removeClass('turnLeft flat');
						}
							return false;
						});
						
						$(window).hashchange( function(){
						//the index in the url hash
							var idx 			= location.hash.split('#')[1];
						if(!idx){
							//we assume the current is the first one,
							//so set the first thumb nav elem as selected
							$thumbnailSlider.thumbnailSlider('update',0);
							return;
						}
						//set the thumb nav elem as selected
						$thumbnailSlider.thumbnailSlider('update',idx-1);
						//based on the current left value for the pg_photos, 
						//and the left of the element, we know how much to slide
							var	current_left 	= parseFloat($pg_photos.css('left'),10),
							elem_left		= $pg_photos_elem.eq(idx-1).offset().left;
						//update the ui slider 
							$slider.slider('value',Math.abs(parseInt(current_left - elem_left,10)));
						//slide to element
							$pg_photos.stop().animate({
								left	: current_left - elem_left + 'px'
							},800,'easeInOutExpo');
						});
					}
			});