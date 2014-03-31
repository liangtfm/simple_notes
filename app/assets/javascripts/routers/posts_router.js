JournalApp.Routers.PostsRouter = Backbone.Router.extend({

  initialize: function ($rootEl, posts) {
    this.$rootEl = $rootEl;
    this.posts = posts;
  },

  routes: {
    '': 'index',
    'new': 'new',
    ':id': 'show',
    ':id/edit': 'edit',
    ':id/delete': 'delete'
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

  delete: function (id) {
    var that = this;

    var post = that._getPost(id, function (post) {
      post.destroy();
      that.posts.remove(post);
      Backbone.history.navigate("/", true);
    });
  },

  _getPost: function (id, callback) {
    var that = this;
    var post = that.posts.get(id);
    if (!post) {
      post = new JournalApp.Models.Post({ id: id });
      post.collection = that.posts;
      post.fetch({
        success: function () {
          that.posts.add(post);
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