$(document).ready(function(){
				
				$('.menu').each(function(){
		 			var childobj = $(".i-"+this.id);
					$(this).click(function(){
						if($(childobj).length > 0) {
							if($(childobj).is(':visible')) {
										$(childobj).slideUp(100);
										$(this).removeClass('active');
							} else {
								$('.nav-list').each(function(){
										$(this).slideUp(100);
										$('.menu').removeClass('active');
								});
										$(childobj).slideDown(100);
										$(this).addClass('active');
							}
							return false;	
						}
					});
				});

			});
			
	