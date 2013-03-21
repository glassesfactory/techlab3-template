class IndexListView
  el:null
  _template:'<article id="tweetlist<%= id %>" class="article"><section class="icon"><img src="/assets/images/icon.jpg"></section><section class="tweet"><header>username</header><section class="tweetBody"><%= text %></section><footer><%= created_at %></footer></section></article>'

  constructor:(data)->
    @el = _.template(@_template, {'id': data.id, 'text':data.text, 'created_at':data.created_at})
