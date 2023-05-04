const { Readable, Writable } = require('stream');
const http = require('http');

const objectify = (obj, [k, v]) => ({ ...obj, [k]: v });

class IncomingMessage extends Readable {
    constructor(cfxReq, cfxRes) {
        super();

        this.headers = Object.entries(cfxReq.headers).map(([k, v]) => [k.toLowerCase(), v]).reduce(objectify, {});
        this.httpVersion = '1.1';
        this.httpVersionMajor = 1;
        this.httpVersionMinor = 1;
        this.method = cfxReq.method;
        this.rawHeaders = Object.entries(this.headers).flatMap((x) => x);
        this.rawTrailers = [];
        this.setTimeout = (ms, cb) => {
            global.setTimeout(cb, ms);
            return this;
        }
        this.trailers = {};
        this.url = cfxReq.path;
        this.aborted = false;

        //Setting Remote Address
        try {
            let addrParts = cfxReq.address.split(':');
            if(addrParts.length != 2 || !addrParts[0].length || !addrParts[1].length){
                throw new Error('Invalid IP:PORT');
            }
            this.connection = {
                remoteAddress: addrParts[0],
                remotePort: addrParts[1]
            };
        } catch (error) {
            console.error(`requestHandler parsing ip:port error: ${error.message}`);
            this.connection = {
                remoteAddress: '0.0.0.0',
                remotePort: 0
            };
        }
        this.socket = this.connection;

        cfxReq.setDataHandler((data) => {
            if (data instanceof ArrayBuffer || ArrayBuffer.isView(data)) {
                this.push(Buffer.from(data));
            } else {
                this.push(data, 'utf8');
            }

            this.push(null);
        }, 'binary');
    }

    _read(len) {

    }

    destroy(err) {

    }
}

class ServerResponse extends Writable {
    constructor(cfxReq, cfxRes) {
        super();

        this.cfxReq = cfxReq;
        this.cfxRes = cfxRes;

        this.connection = {
            remoteAddress: cfxReq.address,
            remotePort: 0,
            writable: true,
            on(...args) {

            }
        };
        this.socket = this.connection;
        this.finished = false;
        this.headersSent = false;
        this.sendDate = true;

        this.statusCode = 200;
        this.statusMessage = 'OK';

        this.headers = {};
    }

    addTrailers(headers) {

    }

    end(chunk, encoding, callback) {
        if (this.finished) {
            return;
        }

        if (typeof chunk === 'function') {
            callback = chunk;
            chunk = null;
        } else if (typeof encoding === 'function') {
            callback = encoding;
            encoding = null;
        }

        if (chunk) {
            this.write(chunk, encoding);
        }

        this.cfxRes.send();

        if (callback) {
            callback();
        }

        this.finished = true;
        this.cfxReq = null;
        this.cfxRes = null;
    }

    getHeader(name) {
        return this.headers[name.toLowerCase()];
    }

    getHeaderNames() {
        return Object.entries(this.headers).map(([name]) => name);
    }

    getHeaders() {
        // TODO: make shallow?
        return Object.assign({}, this.headers);
    }

    hasHeader(name) {
        return (this.headers[name.toLowerCase()] !== undefined);
    }

    removeHeader(name) {
        delete this.headers[name.toLowerCase()];
    }

    setHeader(name, value) {
        this.headers[name.toLowerCase()] = value;
    }

    setTimeout(ms, cb) {

    }

    _write(chunk, encoding, callback) {
        if (!this.headersSent) {
            this.writeHead(this.statusCode, this.statusMessage, this.headers);
        }

        this.cfxRes.write(chunk.buffer.slice(chunk.byteOffset, chunk.byteOffset + chunk.byteLength));

        callback();
    }

    writeContinue() {

    }

    writeHead(statusCode, reason, obj) {
        if (this.headersSent) {
            return;
        }

        this.headersSent = true;

        var originalStatusCode = statusCode;

        statusCode |= 0;
        if (statusCode < 100 || statusCode > 999) {
            throw new Error(`invalid status code ${originalStatusCode}`);
        }


        if (typeof reason === 'string') {
            // writeHead(statusCode, reasonPhrase[, headers])
            this.statusMessage = reason;
        } else {
            // writeHead(statusCode[, headers])
            if (!this.statusMessage)
                this.statusMessage = http.STATUS_CODES[statusCode] || 'unknown';
            obj = reason;
        }
        this.statusCode = statusCode;

        let headers;
        if (this._headers) {
            var k;
            if (obj) {
                var keys = Object.keys(obj);
                for (var i = 0; i < keys.length; i++) {
                    k = keys[i];
                    if (k) this.setHeader(k, obj[k]);
                }
            }
            if (k === undefined && this._header) {
                throw new Error(`invalid header`);
            }

            headers = this._headers;
        } else {
            headers = obj;
        }

        const headerList = {};

        for (const [key, value] of Object.entries(headers)) {
            if (Array.isArray(value)) {
                headerList[key] = value.map(a => a.toString());
            } else {
                headerList[key] = value.toString();
            }
        }

        this.cfxRes.writeHead(this.statusCode, headerList);
    }

    _final(callback) {

    }
}

const setHttpCallback = (requestHandler) => {
    global.SetHttpHandler((req, res) => {
        requestHandler(new IncomingMessage(req, res), new ServerResponse(req, res));
    });
};

module.exports.IncomingMessage = IncomingMessage;
module.exports.ServerResponse = ServerResponse;
module.exports.setHttpCallback = setHttpCallback;
