do(window)->
  Alert =()->
    throw new Error('いつからインスタンス化出来ると錯覚していた?')

  Alert._tmpl = '<div class="modalAlert"><section class="msg"><%= msg %></section><div class="action"><button class="btn btn-primary send" type="button">OK</button><button class="btn cancel" type="button">キャンセル</button></div></div>'
  Alert.container = null

  Alert.dispModalAlert =(msg, target, cb, args)->
    Alert.target = target
    Alert.cb = cb
    Alert.args = args


    $('body').append(_.template(Alert._tmpl, {'msg': msg}))
    $('body').append($('<div id="screen" />'))
    Alert.container = $('.modalAlert')
    Alert.container.css
      left: window.innerWidth / 2 - 175

    Alert.container.on 'click', '.send', Alert._sendHandler
    Alert.container.on 'click', '.cancel', Alert._hideHandler

  Alert._sendHandler =(event)->
    event.preventDefault()
    Alert.cb.apply(Alert.target, Alert.args)
    $('#screen').remove()
    Alert.container.remove()
    Alert.container = null

  Alert._hideHandler =(event)->
    event.preventDefault()
    $('#screen').remove()
    Alert.container.remove()
    Alert.container = null


  Alert.dispAlert =(msg, alertType)->
    alertBody = '<div class="alert <%= alertType %>"><button type="button" class="close" data-dismiss="alert">&times;</button><%= msg %></div>'
    $('#container').prepend(_.template(alertBody, {'msg': msg, 'alertType': if alertType then alertType else ''}))
    $('.alert').on 'click', '.close', (event)->
      $('.alert').remove()

  window.Alert = Alert