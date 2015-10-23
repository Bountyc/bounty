


function awardresolution(user_id){
  $.ajax({
          url: "/api/disputes/"+dispute_id+"/resolve",
          type: "PUT",
          data:{
            dispute_id: dispute_id,
            winner_id: user_id
          },
          dataType: "text",
                success: function(count) {
                    console.log("success");

                },
                error: function(xhr, status, errorThrown) {
                    alert("Sorry, there was a problem!");
                    alert("Error: " + errorThrown);
                    alert("Status: " + status);
                    alert(JSON.stringify( xhr));
                }
            });
}


function getMessages(){
      $.ajax({
                url: "/api/messages",
                data: {
                    dispute_id: dispute_id
                },
                type: "GET",
                dataType: "json",
                success: function(messages) {
                  messages = messages["items"];
                  console.log(messages);
                    $('.chat-history').empty();
                    messages.forEach(function(message) {
                      console.log(message);
                      var template = Handlebars.compile( $("#othermessage-template").html());
                      if (message.user.id == current_user_id) {
                        template = Handlebars.compile( $("#mymessage-template").html());
                      }

                      var context = { 
                        sender: message.user.email,
                        messageOutput: message.contents,
                        time: "2e"
                      };
                    
                      $('.chat-history').append(template(context));
                    
                    });
            //        $('.chat-history').scrollTop($('.chat-history')[0].scrollHeight);
                },
                error: function(xhr, status, errorThrown) {
                    alert("Sorry, there was a problem!");
                    alert("Error: " + errorThrown);
                    alert("Status: " + status);
                    alert(JSON.stringify( xhr));
                },
                // code to run regardless of success or failure
                complete: function(xhr, status) {
                  console.log("complete");
                }
            });
setTimeout(getMessages, 500);
    }
    getMessages();
(function(){
  var chat = {
    messageToSend: '',
   
    init: function() {
      this.cacheDOM();
      this.bindEvents();
      this.render();
      
      
    },
    cacheDOM: function() {
      this.$chatHistory = $('.chat-history');
      this.$button = $('button');
      this.$textarea = $('#message-to-send');
      this.$chatHistoryList =  this.$chatHistory.find('ul');
    },
    bindEvents: function() {
      this.$button.on('click', this.addMessage.bind(this));
      this.$textarea.on('keyup', this.addMessageEnter.bind(this));
    },
    render: function() {
      this.scrollToBottom();
      if (this.messageToSend.trim() !== '') {
        var template = Handlebars.compile( $("#mymessage-template").html());
        var context = { 
          sender: current_user_name,
          messageOutput: this.messageToSend,
          time: this.getCurrentTime()
        };

        this.$chatHistoryList.append(template(context));
        this.scrollToBottom();
        this.$textarea.val('');
        
      }
      
    },
    

 addMessage: function() {
      message = {user_id: current_user_id, contents: this.$textarea.val(), dispute_id: dispute_id };
      $.ajax({
                url: "/api/messages",
                
                type: "POST",
                dataType: "text",
                success: function(count) {
                    console.log("success");

                },
                error: function(xhr, status, errorThrown) {
                    alert("Sorry, there was a problem!");
                    alert("Error: " + errorThrown);
                    alert("Status: " + status);
                    alert(JSON.stringify( xhr));
                },
                complete: function(xhr, status) {
                  console.log("complete");
                }
            });


      this.messageToSend = this.$textarea.val();
      this.render();         
    },
    addMessageEnter: function(event) {
        // enter was pressed
        if (event.keyCode === 13) {
          this.addMessage();
        }
    },
    scrollToBottom: function() {
       this.$chatHistory.scrollTop(this.$chatHistory[0].scrollHeight);
    },
    getCurrentTime: function() {
      return new Date().toLocaleTimeString().
              replace(/([\d]+:[\d]{2})(:[\d]{2})(.*)/, "$1$3");
    }
    
  };
  
  chat.init();
  
  var searchFilter = {
    options: { valueNames: ['name'] },
    init: function() {
      var userList = new List('people-list', this.options);
      var noItems = $('<li id="no-items-found">No items found</li>');
      
      userList.on('updated', function(list) {
        if (list.matchingItems.length === 0) {
          $(list.list).append(noItems);
        } else {
          noItems.detach();
        }
      });
    }
  };
  
  searchFilter.init();
  
})();