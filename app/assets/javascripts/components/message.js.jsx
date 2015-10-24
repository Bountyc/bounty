var Message = React.createClass({
	distance_of_time_in_words: function(to, from) {
	    var distance_in_seconds = ((to - from) / 1000);
	    var distance_in_minutes = Math.floor(distance_in_seconds / 60);
	    var tense = distance_in_seconds < 0 ? " from now" : " ago";
	    distance_in_minutes = Math.abs(distance_in_minutes);
	    if (distance_in_minutes == 0) { return 'less than a minute'+tense; }
	    if (distance_in_minutes == 1) { return 'a minute'+tense; }
	    if (distance_in_minutes < 45) { return distance_in_minutes + ' minutes'+tense; }
	    if (distance_in_minutes < 90) { return 'about an hour'+tense; }
	    if (distance_in_minutes < 1440) { return 'about ' + Math.floor(distance_in_minutes / 60) + ' hours'+tense; }
	    if (distance_in_minutes < 2880) { return 'a day'+tense; }
	    if (distance_in_minutes < 43200) { return Math.floor(distance_in_minutes / 1440) + ' days'+tense; }
	    if (distance_in_minutes < 86400) { return 'about a month'+tense; }
	    if (distance_in_minutes < 525960) { return Math.floor(distance_in_minutes / 43200) + ' months'+tense; }
	    if (distance_in_minutes < 1051199) { return 'about a year'+tense; }

	    return 'over ' + Math.floor(distance_in_minutes / 525960) + ' years';
  	},

    render: function() {
    	var timeNow = Date.now();
		var timeSent = Date.parse(this.props.data.created_at);

    	if (this.props.sentByUser == true)
    	{
        return (
			  <li className="clearfix">
			    <div className="message-data align-right">
			      <span className="message-data-time" >{this.distance_of_time_in_words(timeNow, timeSent)}</span> &nbsp; &nbsp;
			      <span className="message-data-name" >{this.props.sender}</span> <i className="fa fa-circle me"></i>
			    </div>
			    <div className="message other-message float-right">
			      {this.props.data.message}
			    </div>
			  </li>
        	);
    	}

    	else
    	{
    		return (
			  <li>
	            <div className="message-data">
	              <span className="message-data-name"><i className="fa fa-circle online"></i> {this.props.sender}</span>
	              <span className="message-data-time">{this.distance_of_time_in_words(timeNow, timeSent)}</span>
	            </div>
	            <div className="message my-message">
	            	{this.props.data.message}
	            </div>
	          </li>
        	);
    	}
    }
});