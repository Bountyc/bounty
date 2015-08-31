User.create!([
  {email: "dkgs1998@gmail.com", encrypted_password: "$2a$10$IlgX.bp8QLou45eRcXI7veUX/BYFwJr0338Wh6GiqvHyL6KLGq7pa", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-08-31 19:55:54", last_sign_in_at: "2015-08-31 19:55:54", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", balance: 999999944.0, first_name: "Gilad", last_name: "Kleinman", reputation: 0},
  {email: "dkgs1998@yahoo.com", encrypted_password: "$2a$10$KbO9uB4CTyCGi6LMoU.StO.c8E45S/IdwYGL2qClp/kdrnvKjVv.y", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-08-31 19:59:17", last_sign_in_at: "2015-08-31 19:59:17", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", balance: 4.0, first_name: "Ron", last_name: "Theawesome", reputation: 0}
])
Answer.create!([
  {description: "`String#start_with?` was introduced in Ruby 1.8.7. You're apparently using an earlier version, which is (sadly) not uncommon, but the 1.8 series is being retired shortly and you should considering upgrading.\r\n\r\nI can't find any reference to `String#start_with?` in the 1.8.6 docs, but it exists in the 1.8.7 docs.\r\n", denial_reason: nil}
])
Bounty.create!([
  {title: "Kendo UI Export Excel with format", description: "I'm using Kendo UI to export my data to an Excel Workbook. But I can't figure out how to get the format to work. This is an dojo example where I've reproduced the problem.\r\n\r\nhttp://dojo.telerik.com/OGETa/3\r\n\r\nIt doesn't seem to accept the format until you've double clicked the cell and pressed enter (or left it again).\r\n\r\nI want to be able to write a =sum(B1:B2) in the B3 cell after I've exported the document, but it will not accept the values B1 and B2 right away as [hh]:mm.", views: nil, price: 50.0, poster_id: 1, status: 0},
  {title: "How to get dynamic height of div in bootstrap", description: "I am trying to create something similar to https://www.pinterest.com/ homepage where height is decided as per content of Div & all divs automatically adjusts it self using bootstrap.\r\n\r\nI tried to do it but It is not working as expected. Here is fiddle link of what I have tried http://jsfiddle.net/gmm2jcn5/\r\n\r\nIn fiddle we can see that there is white gap between 2 divs I want to eliminate that gap.\r\n\r\n    .col-xs-6 {\r\n        border: 1px solid black;\r\n    }\r\n    <link href=\"https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css\" rel=\"stylesheet\"/>\r\n    <script src=\"http://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/2.0.1/bootstrap.min.js\"></script>\r\n    <div class=\"row\">\r\n        <div class=\"col-xs-6\">\r\n            <p class=\"inntertopheading\">heading</p>\r\n            <div class=\"hr\"></div>\r\n            <div class=\"innter-md-text\">\r\n                text\r\n                <div class=\"spacer10\"></div>\r\n                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.\r\n            </div>\r\n        </div>\r\n        <div class=\"col-xs-6\">\r\n            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's. Lorem Ipsum is simply dummy text of the printing and typesetting industry.\r\n        </div>\r\n        <div class=\"col-xs-6\">\r\n            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's. Lorem Ipsum is simply dummy text of the printing and typesetting industry.\r\n        </div>\r\n        <div class=\"col-xs-6\">\r\n            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's\r\n        </div>\r\n    </div>\r\n\r\n", views: nil, price: 1.0, poster_id: 2, status: 0},
  {title: "Why do I get “undefined method `start_with?'”?", description: "I get:\r\n\r\n    undefined method 'start_with?' for \"-f\":String (NoMethodError)\r\nAt this line:\r\n\r\n    if arg.start_with?(\"-v\")\r\nThis worked on a different machine apparently so I'm assuming it could be a problem with my Ruby installation. Any ideas?", views: nil, price: 5.0, poster_id: 1, status: 2}
])
BountyHunter.create!([
  {user_id: 2, bounty_id: 1, status: 3, answer_id: 1, started_working_at: nil},
  {user_id: 1, bounty_id: 2, status: 0, answer_id: nil, started_working_at: "2015-08-31 20:01:58"}
])
Notification.create!([
  {bounty_hunter_id: 1, user_id: 1, notification_type: 1, message: "just accepted your answer to Why do I get “undefined method `start_with?'”?!", seen: true, action_link: nil, clicked: true},
  {bounty_hunter_id: 2, user_id: 2, notification_type: 3, message: "dkgs1998@gmail.com started working on your bounty!", seen: false, action_link: nil, clicked: false},
  {bounty_hunter_id: 1, user_id: 1, notification_type: 2, message: "dkgs1998@yahoo.com proposed a resolution to your bounty!", seen: true, action_link: "/bounties/1", clicked: true}
])
Payment.create!([
  {user_id: 1, amount: 999999999.0, payer_id: nil, payment_id: nil}
])
Tag.create!([
  {name: "ruby", taggings_count: 1},
  {name: "css twitter-bootstrap twitter-bootstrap-3", taggings_count: 1},
  {name: "javascript", taggings_count: 1},
  {name: "html", taggings_count: 1},
  {name: "excel", taggings_count: 1},
  {name: "kendo-ui", taggings_count: 1},
  {name: "format", taggings_count: 1}
])
View.create!([
  {bounty_id: 1, user_id: 1},
  {bounty_id: 1, user_id: 2},
  {bounty_id: 2, user_id: 2},
  {bounty_id: 2, user_id: 1},
  {bounty_id: 3, user_id: 1}
])
