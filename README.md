# Core Logger

## Installation

    npm install

## Test

    # Run tests.
    npm test

    # Watch and re-run tests.
    npm run tdd

## Basic Usage

```javascript
var CoreLogger = require('core-logger');

// simple debug Console logger
var loggerParams = {
  level: 'debug'
};

var logger = new CoreLogger(loggerParams);

logger.silly('silly log message', { data: 'some data'});
logger.debug('debug log message', { data: 'some data'});
logger.verbose('verbose log message', { data: 'some data'});
logger.info('info log message', { data: 'some data'});
logger.warn('warn log message', { data: 'some data'});
logger.error('error log message', { data: 'some data'});

// all log types return an es6 style promise
logger.error('error log message', { data: 'some data'}).then(function(response){
  console.log(response);
});
```

## Logger Configuration Options

```javascript
// default parameters
var loggerParams = {
  level: 'debug'
  label: 'default'
  logToConsole: true
  logToFile: false
  logFilePath: ''
  logToLoggly: false
  logglyOptions: // for full loggly options check out https://github.com/winstonjs/winston-loggly/blob/master/README.md
    subdomain: 'your-subdomain'
    inputToken: 'loggly api token'
};
```

## License (MIT)

Copyright © 2015, **Respondly**

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
