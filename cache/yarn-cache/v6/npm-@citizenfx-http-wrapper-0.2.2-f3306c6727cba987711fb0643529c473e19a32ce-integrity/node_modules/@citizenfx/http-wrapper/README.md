# http-wrapper

A quick HTTP wrapper for CitizenFX servers. Can't be used with Express yet as it directly relies on `http` from Node.js, use Koa/similar instead.

## Usage

```js
const { setHttpCallback } = require('@citizenfx/http-wrapper');
const Koa = require('koa');

const app = new Koa();
app.use(async ctx => {
	ctx.body = 'Hello World!'
});

// instead of app.listen()
setHttpCallback(app.callback());
```