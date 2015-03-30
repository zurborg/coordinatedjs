(->

  unless @moment? and typeof @moment is 'function'
    console?.error? 'moment.js not available'

  else

    t0 = window.performance?.now?()
    clienttime = @moment()
    t1 = window.performance?.now?()
    servertime = parseFloat '%UNIXTIME%'

    if t0? and t1?
      t0 = (t1 + t0) / 2

    if window.performance.timing?
      a = window.performance.timing.requestStart
      b = window.performance.timing.responseStart
      clienttime = @moment((a + b) / 2)

    calculateOffset = (moment$, ctime, stime) ->
      moment$(moment$(parseFloat(stime) * 1000)).diff ctime, 'milliseconds'

    sysdiff = ->
      return 0 unless t0
      t1 = window.performance.now()
      mm = @moment()
      t2 = window.performance.now()
      mm - clienttime - ((t2 + t1) / 2) - t0

    offset = [ calculateOffset @moment, clienttime, servertime ]

    @$moment = () =>
      @moment().add @$moment.offset(), 'milliseconds'

    @$moment.utc = () =>
      @moment.utc().add @$moment.offset(), 'milliseconds'

    @$moment.offset = () =>
      offset[0] + sysdiff()

    @$moment.synced = @$moment()

    @$moment.sync = ($) =>
      timeStart = window.performance.now()
      url = null
      $.ajax
        url: '%SITEURL%/unixtime'
        dataType: 'jsonp'
        cache: false
        beforeSend: (jqXHR, opts) =>
          url = opts.url
          timeStart = window.performance.now()
        success: (servertime) =>
          timeStop = window.performance.now()
          if url? and window.performance.getEntriesByName?
            resperf = window.performance.getEntriesByName?(url)
            if resperf? and resperf.length is 1
              resperf = resperf[0]
              syncPoint = (resperf.requestStart + resperf.responseStart) / 2
          unless syncPoint
            syncPoint = (timeStart + timeStop) / 2
          d = window.performance.now() - syncPoint
          _clienttime = @moment().add parseInt(-d), 'milliseconds'
          offset[0] = calculateOffset @moment, _clienttime, servertime
          @$moment.synced = @$moment()

).call window
