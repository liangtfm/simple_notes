JournalApp.Views.PostsIndex = Backbone.View.extend({

  initialize: function () {
    var that = this;

    var renderCallback = that.render.bind(that);

    that.listenTo(that.collection, "remove", renderCallback);
    that.listenTo(that.collection, "add", renderCallback);
    that.listenTo(that.collection, "change:title", renderCallback);
    that.listenTo(that.collection, "reset", renderCallback);
  },

  template: JST['posts/index'],

  render: function () {
    var content = this.template({ posts: this.collection });
    this.$el.html(content);
    return this; // this is the instance of the view.
  }

})