var Message = React.createClass({
    render: function() {
    	if (this.props.sentByUser == true)
    	{
        return (
			  <li className="clearfix">
			    <div className="message-data align-right">
			      <span className="message-data-time" >2, Today</span> &nbsp; &nbsp;
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
	              <span className="message-data-time">10:20 AM, Today</span>
	            </div>
	            <div className="message my-message">
	            	{this.props.data.message}
	            </div>
	          </li>
        	);
    	}
    }
});