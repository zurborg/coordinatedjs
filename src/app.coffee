apply = (func) -> (obj, args...) -> func.apply(obj, args)
every = (sec, func) ->
  id = window.setInterval func, sec*1000
  -> window.stopInterval id
delay = (sec, func) ->
  id = window.setTimeout func, sec*1000
  -> window.stopTimeout id
myformat = 'dddd, MMMM Do YYYY, HH:mm:ss'
window.jQuery $ ->
  jQ = (sel, func) -> func.call $(sel), $
  func = ->
    jQ '.server-time', ->
      @text $moment().format myformat
    jQ '.client-time', ->
      @text moment().format myformat
    jQ '.utc-time', ->
      @text $moment.utc().format myformat
    jQ '.offset-time', ->
      @text parseInt($moment.offset())
  func()
  every 0.999, func

  every 5, ->
    $moment.sync $

