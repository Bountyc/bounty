var ChatForm = React.createClass({
  handleSubmit: function ( event ) {
    event.preventDefault();

    var message = this.refs.message.getDOMNode().value.trim();

    // 
    if (!message) {
      return false;
    }

    // submit
    var formData = $( this.refs.form.getDOMNode() ).serialize();
    this.props.onMessageSubmit( formData, this.props.form.action );

    // reset form
    this.refs.message.getDOMNode().value = "";
  },
  render: function () {
    return (
      <form ref="form" className="comment-form" action={ this.props.form.action } accept-charset="UTF-8" method="post" onSubmit={ this.handleSubmit }>
        <input name="utf8" type="hidden" value="✓" />
        <input type="hidden" name={ this.props.form.csrf_param } value={ this.props.form.csrf_token } />
        <textarea ref="message" name="message" placeholder="Type your message" id="message-to-send" rows="3" />
        <button type="submit">Send</button>
      </form>
    )
  }
});