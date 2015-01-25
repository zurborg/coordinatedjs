(->

  if !@moment?
    console?.error? 'moment.js not available'

  else

    clienttime = @moment?()
    servertime = parseFloat '%UNIXTIME%'

    if window.performance?.timing?
      a = window.performance.timing.requestStart
      b = window.performance.timing.responseStart
      d = (b - a) / 2
      clienttime = @moment(a + d)

    calculateOffset = (moment, ctime, stime) ->
      moment(moment(parseFloat(stime) * 1000)).diff ctime, 'milliseconds'

    @$moment = () =>
      @moment().add @$moment.offset, 'milliseconds'

    @$moment.offset = calculateOffset @moment, clienttime, servertime

    @$moment.utc = () =>
      @moment.utc().add @$moment.offset, 'milliseconds'

    @$moment.synced = @$moment()

    @$moment.sync = ($, success) =>
      timeStart = window.performance.now()
      oldOffset = @$moment.offset
      $.ajax
        url: "//localhost:3000/unixtime"
        dataType: 'jsonp'
        cache: false
        beforeSend: =>
          timeStart = window.performance.now()
        success: (servertime) =>
          d = (window.performance.now() - timeStart) / 2
          clienttime = @moment().add -d, 'milliseconds'
          newOffset = calculateOffset @moment, clienttime, servertime
          @$moment.offset = newOffset
          @$moment.synced = @$moment()
          success?.call? null,
            oldOffset:     0+ oldOffset
            newOffset:     0+ newOffset
            requestStart:  0+ @moment(timeStart)
            requestTime:   2* d
            responseStart: 0+ @moment(parseFloat(servertime) * 1000)
            responseEnd:   0+ @$moment.synced

).call window
