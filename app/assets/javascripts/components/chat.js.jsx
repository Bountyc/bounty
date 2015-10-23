var Chat = React.createClass({
    getInitialState: function(){

        // This is called before our render function. The object that is 
        // returned is assigned to this.state, so we can use it later.
        return { messages: this.props.messages };
    },

 //    loadEmailsFromServer: function() {
 //    	$.get("/emails.json", function(result) {
 //    		this.setState({emails: result});
 //  		}.bind(this));
 //    },

 //    componentDidMount: function(){

 //        // componentDidMount is called by react when the component 
 //        // has been rendered on the page. We can set the interval here:
 //        this.loadEmailsFromServer();
 //    	setInterval(this.loadEmailsFromServer, this.props.pollInterval);
	// },
    render: function() {

    	alert(this.state.messages[0].message)
	    var messageNodes = this.state.messages.map(function (message) {
	      return(<p>{message.message}</p>);
	    });
	    return(messageNodes);
	}

});