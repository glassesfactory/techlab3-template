class ShowView
  el:null
  _template:'<header><section class="icon"><a href="#" class="close closeShow" data-dismiss="alert">&times;</a><img src="/assets/images/icon.jpg" width="50"></section><section class="name">username</section></header><section class="tweet"><%= text %></section><footer><span class="ed"><a href="#" class="edit">[edit]</a></span><span class="del"><a href="/<%= id %>" data-delete="<%= id %>" class="delete">[del]</a></span><%= created_at %></footer>'
  constructor:(data)->
    @.el = _.template(@._template, {'id':data.sid,'text':data.text, 'created_at':data.created_at})
