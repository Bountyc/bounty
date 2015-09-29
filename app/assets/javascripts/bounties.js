$( document ).ready(function() {
  $("#work_on_bounty").click(function() {
    $(this).remove();
  });
  	$(".load-more").click(function() {
	  $(this).html('<span class="glyphicon glyphicon-refresh glyphicon-refresh-animate" style="font-size:25px;"></span>');
	});

});