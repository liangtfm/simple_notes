JournalApp.Views.PostNewView = Backbone.View.extend({

  initialize: function() {
    var that = this;
  },

  template: JST["posts/new"],

  render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  events: {
    "click .create": "newPost"
  },

  newPost: function(event) {
    event.preventDefault();
    var that = this;

    console.log(event.target.form);
    var attrs = $(event.target.form).serializeJSON();


    this.model.set(attrs);

    this.collection.create(this.model, {
      success: function() {
        Backbone.history.navigate("#/");
      },
      error: function(data, xhr) {
        console.log(xhr.responseText);
      }
    });
  }

});