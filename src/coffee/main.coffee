require.config {
  shim : {
    'jquery':{
      exports:'jQuery'
    },
    'lodash':{
      exports:'_'
    }
  },
  paths: {
    'jquery' : 'components/jquery/jquery.min'
    'lodash' : 'components/lodash/dist/lodash.min'
    'kazitori' : 'components/kazitori.js/src/js/kazitori'
  }
}
index = null
newController = null
contents = null
require ['jquery', 'lodash', 'kazitori', 'Index', 'New', 'IndexListView', 'TweetModel', 'Show', 'ShowView', 'EditView', 'Alert'], ()->
  class Router extends Kazitori
    routes:
      '/':'index'
      '/<int:id>':'show'

    index:()->
      index.hide()
      contents.hide()
      return

    show:(id)->
      if not contents?
        contents = new Show()
      if @.lastFragment isnt '/'
        contents.hideAndShow(id)
      else
        contents.show(id)
      index.slide()
      return

  $(()->
    index = new Index()
    newController = new New()
    contents = new Show()
    window.App = new Router()
    window.App.addEventListener KazitoriEvent.FIRST_REQUEST, index.fetchTweetCollection
  )
  
  
  return