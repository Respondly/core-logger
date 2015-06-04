_ = require 'lodash'
winston = require 'winston'
Loggly = require('winston-loggly').Loggly
Promise = require('es6-promise').Promise
Papertrail = require('winston-papertrail').Papertrail


class CoreLogger

  constructor: (options={}) ->
    @logger = new winston.Logger()

    sharedTransportParams =
      level: options.level ? 'info'
      label: options.label ? 'default'

    if options.logToConsole ? true
      consoleTransportParams =
        colorize: true
        timestamp: true

      consoleTransportParams = _.extend(consoleTransportParams, sharedTransportParams)
      @addTransport(winston.transports.Console, consoleTransportParams)

    if options.logToFile is true
      logFilePath = options.logFilePath
      if not logFilePath?
        throw new Error('If `logToFile` is specified `logFilePath` is needed')

      fileTransportParams =
        filename: logFilePath
      fileTransportParams = _.extend(fileTransportParams, sharedTransportParams)
      @addTransport(winston.transports.File, fileTransportParams)

    if options.logToLoggly is true

      # take a look at the readme for avialble options:
      # https://github.com/winstonjs/winston-loggly/blob/master/README.md
      if not options.logglyOptions?
        throw new Error('If `logToLoggly` is specified `logglyOptions` is needed')

      # use json by default if not specified
      logglyTransportParams = _.extend(json: true, options.logglyOptions)

      logglyTransportParams = _.extend(logglyTransportParams, sharedTransportParams)

      @addTransport(Loggly, logglyTransportParams)

    # Take a look at the github repo for avialble options
    # https://github.com/kenperkins/winston-papertrail#usage
    if options.logToPaperTrail is true
      if not options.paperTrailOptions
        throw new Error('If `logToPaperTrail` is specified then `paperTrailOptions` is needed')

      paperTrailTransportParams = _.extend(program: sharedTransportParams.label, options.paperTrailOptions)
      paperTrailTransportParams = _.extend(paperTrailTransportParams, sharedTransportParams)


      @addTransport(Papertrail, paperTrailTransportParams)

    @

  addTransport: (transport, args) ->
    @logger.add(transport, args)

  removeTransport: (transport) ->
    @logger.remove(transport)

  silly: (args...) -> @log.apply @, ['silly'].concat(args)

  debug: (args...) -> @log.apply @, ['debug'].concat(args)

  verbose: (args...) -> @log.apply @, ['verbose'].concat(args)

  info: (args...) -> @log.apply @, ['info'].concat(args)

  warn: (args...) -> @log.apply @, ['warn'].concat(args)

  error: (args...) -> @log.apply @, ['error'].concat(args)

  log: (args...) ->
    new Promise (resolve, reject) =>
      args.push (err, level, message, meta) ->
        if err
          reject new Error(err)
        else
          resolveParams =
            level: level
            message: message
            meta: meta
          resolve resolveParams

      @logger.log.apply @logger, args


module.exports = CoreLogger
