$( document ).ready(function() {
  $("#work_on_bounty").click(function() {
    $(this).remove();
  });
  	$(".load-more").click(function() {
  		$(this).html('<span class="loading">loading...</span>')
  		$.ajax({url: "demo_test.txt", success: function(result){
        	$("#div1").html(result);
    	}});
	});
});