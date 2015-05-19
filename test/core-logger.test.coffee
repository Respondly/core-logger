crypto = require 'crypto'
fs = require 'fs'
expect = require('chai').expect
nock = require('nock')
CoreLogger = require('../index.coffee')

fakeApiKey = 'abc123'

logglyInputs = [
  {"level":"silly","message":"** SILLY **"},
  {"data":"so meta","level":"silly","message":"** SILLY **"},
  {"level":"debug","message":"** DEBUG **"},
  {"data":"so meta","level":"debug","message":"** DEBUG **"},
  {"level":"verbose","message":"** VERBOSE **"},
  {"data":"so meta","level":"verbose","message":"** VERBOSE **"},
  {"level":"info","message":"** INFO **"},
  {"data":"so meta","level":"info","message":"** INFO **"},
  {"level":"warn","message":"** WARN **"},
  {"data":"so meta","level":"warn","message":"** WARN **"},
  {"level":"error","message":"** ERROR **"}
  {"data":"so meta","level":"error","message":"** ERROR **"}
]

MockLoggly = nock('https://logs-01.loggly.com:443')

for input in logglyInputs
  MockLoggly
  .post('/inputs/abc123', input)
  .reply(200, {"response":"ok"},{
    server: 'nginx/1.1.19',
    date: 'Mon, 18 May 2015 21:23:45 GMT'
    'content-type': 'text/html'
    'content-length': '19'
    connection: 'keep-alive'
  })


describe 'Core Logger', ->
  logger = undefined

  # setup a logger that logs to a file
  before ->
    params =
      logToLoggly: true
      logglyOptions:
        subdomain: "core-logger"
        inputToken: fakeApiKey

      level: 'silly'
    logger = new CoreLogger(params)

  it 'sends a silly log message', ->
    expectedResult =
      level: 'silly'
      message: '** SILLY **'
      meta: {}

    logger.silly(expectedResult.message).then (result) ->
      expect(result).to.eql(expectedResult)

  it 'sends a silly log message with meta data', ->
    expectedResult =
      level: 'silly'
      message: '** SILLY **'
      meta:
        data: 'so meta'

    logger.silly(expectedResult.message, expectedResult.meta).then (result) ->
      expect(result).to.eql(expectedResult)

  it 'sends a debug log message', ->
    expectedResult =
      level: 'debug'
      message: '** DEBUG **'
      meta: {}

    logger.debug(expectedResult.message).then (result) ->
      expect(result).to.eql(expectedResult)

  it 'sends a debug log message with meta data', ->
    expectedResult =
      level: 'debug'
      message: '** DEBUG **'
      meta:
        data: 'so meta'

    logger.debug(expectedResult.message, expectedResult.meta).then (result) ->
      expect(result).to.eql(expectedResult)

  it 'sends a verbose log message', ->
    expectedResult =
      level: 'verbose'
      message: '** VERBOSE **'
      meta: {}

    logger.verbose(expectedResult.message).then (result) ->
      expect(result).to.eql(expectedResult)

  it 'sends a verbose log message with meta data', ->
    expectedResult =
      level: 'verbose'
      message: '** VERBOSE **'
      meta:
        data: 'so meta'

    logger.verbose(expectedResult.message, expectedResult.meta).then (result) ->
      expect(result).to.eql(expectedResult)

  it 'sends a info log message', ->
    expectedResult =
      level: 'info'
      message: '** INFO **'
      meta: {}

    logger.info(expectedResult.message).then (result) ->
      expect(result).to.eql(expectedResult)

  it 'sends a info log message with meta data', ->
    expectedResult =
      level: 'info'
      message: '** INFO **'
      meta:
        data: 'so meta'

    logger.info(expectedResult.message, expectedResult.meta).then (result) ->
      expect(result).to.eql(expectedResult)

  it 'sends a warn log message', ->
    expectedResult =
      level: 'warn'
      message: '** WARN **'
      meta: {}

    logger.warn(expectedResult.message).then (result) ->
      expect(result).to.eql(expectedResult)

  it 'sends a warn log message with meta data', ->
    expectedResult =
      level: 'warn'
      message: '** WARN **'
      meta:
        data: 'so meta'

    logger.warn(expectedResult.message, expectedResult.meta).then (result) ->
      expect(result).to.eql(expectedResult)

  it 'sends a error log message', ->
    expectedResult =
      level: 'error'
      message: '** ERROR **'
      meta: {}

    logger.error(expectedResult.message).then (result) ->
      expect(result).to.eql(expectedResult)

  it 'sends a error log message with meta data', ->
    expectedResult =
      level: 'error'
      message: '** ERROR **'
      meta:
        data: 'so meta'

    logger.error(expectedResult.message, expectedResult.meta).then (result) ->
      expect(result).to.eql(expectedResult)
