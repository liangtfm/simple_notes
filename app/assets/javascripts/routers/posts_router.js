JournalApp.Routers.PostsRouter = Backbone.Router.extend({

  initialize: function ($rootEl, posts) {
    this.$rootEl = $rootEl;
    this.posts = posts;
  },

  routes: {
    '': 'index',
    'posts/:id': 'show'
  },

  index: function() {
    var that = this;
    var view = new JournalApp.Views.PostsIndex({
      collection: that.posts
    });

    that.$rootEl.html(view.render().$el);
  },

  show: function (id) {
    var that = this;

    var post = _(that.posts.models).findWhere({id: parseInt(id) });
    var show = new JournalApp.Views.PostShow({
      model: post
    })

    that.$rootEl.html(show.render().$el);
  }

});