class EditView
  el:null
  _template:'<form id="editView" action="/<%= id %>" method="PUT"><input type="text" name="text" value="<%= text %>"><button type="button" class="send btn btn-primary btn-mini">OK</button><button type="button" class="cancel btn btn-mini">&times;</button></form>'
  constructor:(data)->
      @.el = _.template(@._template, {'id': data.sid,'text': data.text})