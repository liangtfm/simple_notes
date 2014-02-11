window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // alert('Hello from Backbone!');
    var posts = new JournalApp.Collections.Posts;
    posts.fetch({
      success: function() {
        new JournalApp.Routers.PostsRouter($('#content'), posts);
        Backbone.history.start();
      }
    })
  },
};

$(document).ready(function(){
  JournalApp.initialize();
});
