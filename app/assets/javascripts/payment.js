$(document).ready(function() {
	$("#add-money-submit, #withdraw-money-submit").click(function() {
	  $(this).html('<span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span> Loading...');
	});
});