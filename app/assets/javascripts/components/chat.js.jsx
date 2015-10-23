var Chat = React.createClass({
    getInitialState: function(){

        // This is called before our render function. The object that is 
        // returned is assigned to this.state, so we can use it later.
        return { messages: this.props.messages, messagesCount: 0};
    },

    loadMessagesFromServer: function() {
    	$.get(this.props.loadUrl, function(result) {
    		this.setState({messages: result});

        if (result.length != this.state.messagesCount)
        {
          $('.chat-history')[0].scrollTop = $('.chat-history')[0].scrollHeight;
          this.state.messagesCount = result.length
        }
  		}.bind(this));
    },

    componentDidMount: function(){
        // componentDidMount is called by react when the component 
        // has been rendered on the page. We can set the interval here:
        this.loadMessagesFromServer();
    	setInterval(this.loadMessagesFromServer, this.props.pollInterval);
	  },

    render: function() {
	    var messageNodes = this.state.messages.map(function (message) {
        if (this.props.user_id == message.sender_id)
        {
	       return(<Message data={message} id={message.id} sentByUser={true} sender={this.props.user}/>);
        }
        else
        {
          return(<Message data={message} id={message.id} sentByUser={false} sender={this.props.chatWithUser}/>);
        }
	    }.bind(this));

	    return(
        <div className="chat-history">
          <ul>
          {messageNodes}
          </ul>
        </div>
      );
	}

});