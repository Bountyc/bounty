$( document ).ready(function() {
  $("#work_on_bounty").click(function() {
    $(this).remove();
  });
  	$(".load-more").click(function() {
  		$(this).html('loading...')
	});

});