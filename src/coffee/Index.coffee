# define ['jquery', 'underscore', 'TweetModel'], ()->
class Index
  tweets:[]
  $el:null
  state:true
  constructor:()->
    tweets = []
    @.$el = $('#main')
    @.$el.on 'click', '.article', @articleSelectedHandler
    @resize()
    $(window).on 'post_success', @newTweetAppend
    $(window).on 'resize', @resize
      

  fetchTweetCollection:()=>
    @.$el.empty()
    
    window.App.removeEventListener KazitoriEvent.FIRST_REQUEST, @fetchTweetCollection
    $.ajax({
      url:"/"
      dataType:"json"
      contentType:"application/json"
      success:@_fetchSuccessHandler
      error:@_errorHandler
      })

  _fetchSuccessHandler:(datas)=>
    for data in datas
      @.tweets.push new TweetModel(data.sid, data.text, data.created_at, data.updated_at)
    @render()

  _errorHandler:(error)=>
    console.log error, "error"
  # return Index
  
  render:()->
    elem = ''
    if @.tweets.length < 1
      elem += '<article class="article nullpo">ぬるぽ</article>'
    
    for tweet in @tweets
      elem += new IndexListView(tweet).el
    @.$el.append(elem)
    $('#container').css { 'height':@$el.height() + 20}

  articleSelectedHandler:(event)=>
    event.preventDefault()
    tgt = event.currentTarget
    id = $(tgt).attr('id').replace('tweetlist', '')
    
    if window.App.fragment is '/' + id
      window.App.change('/')
      return
    else if window.App.fragment isnt '/'
      @hide() 
    window.App.change('/' + id)

  newTweetAppend:(event, data)=>
    tweet = new TweetModel(data.sid, data.text, data.created_at, data.updated_at)
    @.tweets.unshift tweet
    elem = new IndexListView(tweet).el
    @.$el.prepend(elem)

  slide:()=>
    # console.log @$el
    @$el.animate {left: @.pos - 420}
    @.state = false

  hide:()=>
    @$el.animate {left: @.pos - 250 }
    @.state = true

  resize:()=>
    container = $('#container')
    @.pos = container.offset().left + container.width() / 2
    if @.state
      @.$el.css {left: @.pos - 250}
    else
      @$el.css {left: @.pos - 420}

