window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    // alert('Hello from Backbone!');
  }
};

$(document).ready(function(){
  JournalApp.initialize();

  var posts = new JournalApp.Collections.Posts;
  posts.fetch({
    success: function(collection) {
      console.log(collection);
      var view = new JournalApp.Views.PostsIndex({ collection: collection });
      $("body").append(view.render().$el);
    }
  })

});
