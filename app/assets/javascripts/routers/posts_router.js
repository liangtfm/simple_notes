JournalApp.Routers.PostsRouter = Backbone.Router.extend({

  initialize: function ($rootEl, posts) {
    this.$rootEl = $rootEl;
    this.posts = posts;
  },

  routes: {
    '': 'index',
    'posts/new': 'new',
    'posts/:id': 'show',
    ':id/edit': 'edit'
  },

  index: function() {
    var that = this;
    var formView = new JournalApp.Views.PostsIndexView({
      collection: that.posts
    });

    that._swapView(formView);
  },

  new: function() {
  var that = this;
  var newPost = new JournalApp.Models.Post();

  var formView = new JournalApp.Views.PostNewView({
    model: newPost,
    collection: that.posts
  });

    that._swapView(formView);
  },

  show: function (id) {
    var that = this;

    var post = _(that.posts.models).findWhere({id: parseInt(id) });
    var formView = new JournalApp.Views.PostShowView({
      model: post
    })

    that._swapView(formView);
  },

  edit: function (id) {
    var that = this;

    var post = _(that.posts.models).findWhere({id: parseInt(id) });

    var formView = new JournalApp.Views.PostEditView({
      model: post
    })

    that._swapView(formView);
  },

  _getPost: function (id, callback) {
    var post = JournalApp.posts.get(id);
    if (!post) {
      post = new JournalApp.Models.Post({ id: id });
      post.collection = JournalApp.posts;
      post.fetch({
        success: function () {
          JournalApp.posts.add(post);
          callback(post);
        }
      });
    } else {
      callback(post);
    }
  },

  _swapView: function (view) {
    this._currentView && this._currentView.remove();
    this._currenView = view;
    this.$rootEl.html(view.render().$el);
  }

});