# Twitter検索APIを呼ぶ

getTweets = (query) ->
  $.Deferred (defer) ->
    $.ajax
      url: 'http://search.twitter.com/search.json'
      dataType: 'jsonp'
      data:
        result_type: 'recent'
        rpp: 10
        page: 1
        q: query
    .done (res) ->
      defer.resolve res.results
  .promise()


# NameSpace定義
App = Em.Application.create()

# Viewのメソッド定義(イベントハンドラ定義)
App.SearchButtonView = Em.View.extend
  searchJQuery: ->
    App.tweets.update "jQuery"

  searchEmber: ->
    App.tweets.update "Ember.js"

# Controllerを定義
# (Ember.jsのControllerはControllerといいながら、
# Model or Presenterの位置づけ)
App.tweets = Em.ArrayController.create
  content: [
    #{from_user: 'person1', text: 'hoge'},
    #{from_user: 'person2', text: 'moge'}
  ],

  update: (query) ->
    _this = @
    _this.set 'content', []
    getTweets(query).done (tweets) ->
      _this.set 'content', tweets

