class New
  $el:'<div><header><h2>New Tweet</h2><a href="#" class="close" data-dismiss="alert">&times;</a></header><form id="newForm" class="form" action="/create" method="POST"><div class="controls"><textarea name="text"></textarea></div><div><button id="sendTweet" type="submit" class="btn btn-primary">送信</button></div></form></div>'
  $screen: null
  constructor:()->
    $('.new').on 'click', @toggleClickHandler

  toggleClickHandler:(event)=>
    event.preventDefault()  
    if @.$container
      @_removeContainer()
    else
      $('body').append('<div id="screen" />')
      $('body').append('<div id="newContainer" />')

      @.$container = $('#newContainer')
      @.$container.append(@$el)
      @.$container.css {left: window.innerWidth / 2 - 215}
      # $container.addClass('alert')
      $('form').on 'submit', @_sendTweetHandler
      $('textarea[name=text]').focus()
      $('.close').on 'click', @closeHandler

      @.$screen = $('#screen')
      @.$screen.on 'click', @_screenClickHandler

  _sendTweetHandler:(event)=>
    event.preventDefault()
    data = $('#newForm').serializeArray()
    $.ajax {
      url: '/create'
      method: "POST"
      data:data
      success:(data)=>
        $(window).trigger('post_success', data)
        Alert.dispAlert '作成しました', 'alert-success'
    }
    @_removeContainer()

  closeHandler:(event)=>
    event.preventDefault()
    @_removeContainer()

  _screenClickHandler:(event)=>
    event.preventDefault()
    @_removeContainer()

  _removeContainer:()=>
    @.$container.remove()
    @.$screen.remove()
    @.$container = null
    @.$screen = null