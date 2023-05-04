/*! For license information please see 5610.js.LICENSE.txt */
"use strict";(self.webpackChunknpwd_nui=self.webpackChunknpwd_nui||[]).push([[5610,5251,9071],{65610:function(e,t,n){var r=this&&this.__createBinding||(Object.create?function(e,t,n,r){void 0===r&&(r=n),Object.defineProperty(e,r,{enumerable:!0,get:function(){return t[n]}})}:function(e,t,n,r){void 0===r&&(r=n),e[r]=t[n]}),u=this&&this.__exportStar||function(e,t){for(var n in e)"default"===n||Object.prototype.hasOwnProperty.call(t,n)||r(t,e,n)};Object.defineProperty(t,"__esModule",{value:!0}),u(n(1738),t),u(n(1145),t),u(n(82034),t),u(n(87422),t),u(n(11937),t),u(n(59735),t),u(n(55550),t),u(n(10316),t)},59735:function(e,t,n){Object.defineProperty(t,"__esModule",{value:!0}),t.NuiContext=void 0;var r=n(92950);t.NuiContext=r.createContext(null)},82034:function(e,t,n){Object.defineProperty(t,"__esModule",{value:!0}),t.useNuiCallback=void 0;var r=n(92950),u=n(59735),o=n(10316),i=n(1738);t.useNuiCallback=function(e,t,n,a){var c=r.useContext(u.NuiContext),s=c.sendAbortable,l=c.callbackTimeout,f=r.useRef(),v=r.useRef(),d=r.useRef(o.eventNameFactory(e,t)),p=r.useRef(t),b=r.useRef(e),h=r.useState(!1),y=h[0],m=h[1],w=r.useState(!1),_=w[0],g=w[1],O=r.useState(null),N=O[0],k=O[1],E=r.useState(null),j=E[0],C=E[1],P=r.useCallback((function(e){_&&(v.current&&clearTimeout(v.current),y||(C(e),k(null),g(!1),null==n||n(e)))}),[n,y,_]),S=r.useCallback((function(e){v.current&&clearTimeout(v.current),k(e),C(null),g(!1),null==a||a(e)}),[a]);return i.useNuiEvent(b.current,p.current+"Success",P),i.useNuiEvent(b.current,p.current+"Error",S),[r.useCallback((function(e,t){g((function(n){if(!n){m(!1),k(null),C(null),f.current=s(p.current,e);var r=t||{timeout:l},u=!1!==r.timeout&&(r.timeout||l);return u&&(clearTimeout(v.current),v.current=setTimeout((function(){m(!0),S(new Error('fivem-nui-react-lib: "'+d.current+'" event callback timed out after '+u+" milliseconds")),f.current&&f.current.abort(),v.current=void 0,f.current=void 0}),u)),!0}return n}))}),[]),{loading:_,response:j,error:N}]}},1738:function(e,t,n){Object.defineProperty(t,"__esModule",{value:!0}),t.useNuiEvent=void 0;var r=n(92950),u=n(10316);t.useNuiEvent=function(e,t,n){var o=r.useRef();r.useEffect((function(){o.current=n}),[n]),r.useEffect((function(){var n=u.eventNameFactory(e,t),r=function(e){if(o.current&&o.current.call){var t=e.data;o.current(t)}};return function(e,t,n){e.addEventListener(t,n)}(window,n,r),function(){return window.removeEventListener(n,r)}}),[e,t])}},1145:function(e,t,n){Object.defineProperty(t,"__esModule",{value:!0}),t.useNuiEventCallback=void 0;var r=n(92950),u=n(59735),o=n(10316),i=n(1738);t.useNuiEventCallback=function(e,t,n,a){console.warn("@ useNuiEventCallback is deprecated, please use useNuiCallback instead");var c=r.useContext(u.NuiContext),s=c.sendAbortable,l=c.callbackTimeout,f=r.useRef(),v=r.useRef(),d=r.useRef(o.eventNameFactory(e,t)),p=r.useRef(t),b=r.useRef(e),h=r.useState(!1),y=h[0],m=h[1],w=r.useState(!1),_=w[0],g=w[1],O=r.useState(null),N=O[0],k=O[1],E=r.useState(null),j=E[0],C=E[1],P=r.useCallback((function(e){_&&(v.current&&clearTimeout(v.current),y||(C(e),k(null),g(!1),null==n||n(e)))}),[n,y,_]),S=r.useCallback((function(e){v.current&&clearTimeout(v.current),k(e),C(null),g(!1),null==a||a(e)}),[a]);return r.useEffect((function(){_&&!v.current&&(clearTimeout(v.current),v.current=setTimeout((function(){m(!0),S(new Error('fivem-nui-react-lib: "'+d.current+'" event callback timed out after '+l+" milliseconds")),f.current&&f.current.abort(),v.current=void 0,f.current=void 0}),1e4))}),[_,S]),i.useNuiEvent(b.current,p.current+"Success",P),i.useNuiEvent(b.current,p.current+"Error",S),[r.useCallback((function(e){g((function(t){return t||(f.current=s(p.current,e),!0)}))}),[]),{loading:_,response:j,error:N}]}},87422:function(e,t,n){Object.defineProperty(t,"__esModule",{value:!0}),t.useNuiRequest=void 0;var r=n(92950),u=n(59735);t.useNuiRequest=function(){var e=r.useContext(u.NuiContext);if(!e)throw new Error("fivem-nui-react-lib: useNuiRequest must be used inside NuiProvider passing the `resource` prop");var t=e.send,n=e.sendAbortable;return r.useMemo((function(){return{send:t,sendAbortable:n}}),[t,n])}},55550:function(e,t,n){var r=this&&this.__assign||function(){return r=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var u in t=arguments[n])Object.prototype.hasOwnProperty.call(t,u)&&(e[u]=t[u]);return e},r.apply(this,arguments)},u=this&&this.__awaiter||function(e,t,n,r){return new(n||(n=Promise))((function(u,o){function i(e){try{c(r.next(e))}catch(e){o(e)}}function a(e){try{c(r.throw(e))}catch(e){o(e)}}function c(e){var t;e.done?u(e.value):(t=e.value,t instanceof n?t:new n((function(e){e(t)}))).then(i,a)}c((r=r.apply(e,t||[])).next())}))},o=this&&this.__generator||function(e,t){var n,r,u,o,i={label:0,sent:function(){if(1&u[0])throw u[1];return u[1]},trys:[],ops:[]};return o={next:a(0),throw:a(1),return:a(2)},"function"==typeof Symbol&&(o[Symbol.iterator]=function(){return this}),o;function a(o){return function(a){return function(o){if(n)throw new TypeError("Generator is already executing.");for(;i;)try{if(n=1,r&&(u=2&o[0]?r.return:o[0]?r.throw||((u=r.return)&&u.call(r),0):r.next)&&!(u=u.call(r,o[1])).done)return u;switch(r=0,u&&(o=[2&o[0],u.value]),o[0]){case 0:case 1:u=o;break;case 4:return i.label++,{value:o[1],done:!1};case 5:i.label++,r=o[1],o=[0];continue;case 7:o=i.ops.pop(),i.trys.pop();continue;default:if(!((u=(u=i.trys).length>0&&u[u.length-1])||6!==o[0]&&2!==o[0])){i=0;continue}if(3===o[0]&&(!u||o[1]>u[0]&&o[1]<u[3])){i.label=o[1];break}if(6===o[0]&&i.label<u[1]){i.label=u[1],u=o;break}if(u&&i.label<u[2]){i.label=u[2],i.ops.push(o);break}u[2]&&i.ops.pop(),i.trys.pop();continue}o=t.call(e,i)}catch(e){o=[6,e],r=0}finally{n=u=0}if(5&o[0])throw o[1];return{value:o[0]?o[1]:void 0,done:!0}}([o,a])}}};Object.defineProperty(t,"__esModule",{value:!0}),t.NuiProvider=void 0;var i=n(85893),a=n(92950),c=n(59735),s=n(10316);function l(e,t){var n=new AbortController,u=n.signal;return{abort:function(){return n.abort()},promise:fetch(e,r(r({},t),{signal:u}))}}function f(e,t,n){return["https://"+e+"/"+t,{method:"post",headers:{"Content-Type":"application/json; charset=UTF-8"},body:JSON.stringify(n)}]}t.NuiProvider=function(e){var t=e.resource,n=e.children,v=e.timeout,d=a.useRef(t||""),p=a.useRef(v||1e4),b=function(e){var t=e.data,n=t.app,r=t.method,u=t.data;n&&r&&window.dispatchEvent(new MessageEvent(s.eventNameFactory(n,r),{data:u}))};a.useEffect((function(){return window.addEventListener("message",b),function(){return window.removeEventListener("message",b)}}),[]);var h=a.useCallback((function(e,t){return void 0===t&&(t={}),u(void 0,void 0,void 0,(function(){return o(this,(function(n){return[2,fetch.apply(void 0,f(d.current,e,t))]}))}))}),[]),y=a.useCallback((function(e,t){return void 0===t&&(t={}),l.apply(void 0,f(d.current,e,t))}),[]);return i.jsx(c.NuiContext.Provider,r({value:{send:h,sendAbortable:y,resource:d.current,callbackTimeout:p.current}},{children:n}),void 0)}},11937:function(e,t,n){var r=this&&this.__assign||function(){return r=Object.assign||function(e){for(var t,n=1,r=arguments.length;n<r;n++)for(var u in t=arguments[n])Object.prototype.hasOwnProperty.call(t,u)&&(e[u]=t[u]);return e},r.apply(this,arguments)},u=this&&this.__awaiter||function(e,t,n,r){return new(n||(n=Promise))((function(u,o){function i(e){try{c(r.next(e))}catch(e){o(e)}}function a(e){try{c(r.throw(e))}catch(e){o(e)}}function c(e){var t;e.done?u(e.value):(t=e.value,t instanceof n?t:new n((function(e){e(t)}))).then(i,a)}c((r=r.apply(e,t||[])).next())}))},o=this&&this.__generator||function(e,t){var n,r,u,o,i={label:0,sent:function(){if(1&u[0])throw u[1];return u[1]},trys:[],ops:[]};return o={next:a(0),throw:a(1),return:a(2)},"function"==typeof Symbol&&(o[Symbol.iterator]=function(){return this}),o;function a(o){return function(a){return function(o){if(n)throw new TypeError("Generator is already executing.");for(;i;)try{if(n=1,r&&(u=2&o[0]?r.return:o[0]?r.throw||((u=r.return)&&u.call(r),0):r.next)&&!(u=u.call(r,o[1])).done)return u;switch(r=0,u&&(o=[2&o[0],u.value]),o[0]){case 0:case 1:u=o;break;case 4:return i.label++,{value:o[1],done:!1};case 5:i.label++,r=o[1],o=[0];continue;case 7:o=i.ops.pop(),i.trys.pop();continue;default:if(!((u=(u=i.trys).length>0&&u[u.length-1])||6!==o[0]&&2!==o[0])){i=0;continue}if(3===o[0]&&(!u||o[1]>u[0]&&o[1]<u[3])){i.label=o[1];break}if(6===o[0]&&i.label<u[1]){i.label=u[1],u=o;break}if(u&&i.label<u[2]){i.label=u[2],i.ops.push(o);break}u[2]&&i.ops.pop(),i.trys.pop();continue}o=t.call(e,i)}catch(e){o=[6,e],r=0}finally{n=u=0}if(5&o[0])throw o[1];return{value:o[0]?o[1]:void 0,done:!0}}([o,a])}}};Object.defineProperty(t,"__esModule",{value:!0}),t.NuiServiceProvider=void 0;var i=n(85893),a=n(92950),c=n(59735),s=n(10316);function l(e,t){var n=new AbortController,u=n.signal;return{abort:function(){return n.abort()},promise:fetch(e,r(r({},t),{signal:u}))}}function f(e,t,n){return["https://"+e+"/"+t,{method:"post",headers:{"Content-Type":"application/json; charset=UTF-8"},body:JSON.stringify(n)}]}t.NuiServiceProvider=function(e){var t=e.resource,n=e.children,v=e.timeout;console.warn("@ NuiServiceProvider is deprecated, please use NuiProvider instead");var d=a.useRef(),p=function(e){var t=e.data,n=t.app,r=t.method,u=t.data;n&&r&&window.dispatchEvent(new MessageEvent(s.eventNameFactory(n,r),{data:u}))};a.useEffect((function(){return window.addEventListener("message",p),function(){return window.removeEventListener("message",p)}}),[]);var b=a.useCallback((function(e,n){return void 0===n&&(n={}),u(void 0,void 0,void 0,(function(){return o(this,(function(r){return[2,fetch.apply(void 0,f(t,e,n))]}))}))}),[]),h=a.useCallback((function(e,n){return void 0===n&&(n={}),l.apply(void 0,f(t,e,n))}),[]);return i.jsx(c.NuiContext.Provider,r({value:{resource:d.current,send:b,sendAbortable:h,callbackTimeout:v||1e4}},{children:n}),void 0)}},10316:function(e,t){Object.defineProperty(t,"__esModule",{value:!0}),t.eventNameFactory=void 0,t.eventNameFactory=function(e,t){return e+":"+t}},27418:function(e){var t=Object.getOwnPropertySymbols,n=Object.prototype.hasOwnProperty,r=Object.prototype.propertyIsEnumerable;function u(e){if(null==e)throw new TypeError("Object.assign cannot be called with null or undefined");return Object(e)}e.exports=function(){try{if(!Object.assign)return!1;var e=new String("abc");if(e[5]="de","5"===Object.getOwnPropertyNames(e)[0])return!1;for(var t={},n=0;n<10;n++)t["_"+String.fromCharCode(n)]=n;if("0123456789"!==Object.getOwnPropertyNames(t).map((function(e){return t[e]})).join(""))return!1;var r={};return"abcdefghijklmnopqrst".split("").forEach((function(e){r[e]=e})),"abcdefghijklmnopqrst"===Object.keys(Object.assign({},r)).join("")}catch(e){return!1}}()?Object.assign:function(e,o){for(var i,a,c=u(e),s=1;s<arguments.length;s++){for(var l in i=Object(arguments[s]))n.call(i,l)&&(c[l]=i[l]);if(t){a=t(i);for(var f=0;f<a.length;f++)r.call(i,a[f])&&(c[a[f]]=i[a[f]])}}return c}},75251:function(e,t,n){n(27418);var r=n(92950),u=60103;if(t.Fragment=60107,"function"==typeof Symbol&&Symbol.for){var o=Symbol.for;u=o("react.element"),t.Fragment=o("react.fragment")}var i=r.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner,a=Object.prototype.hasOwnProperty,c={key:!0,ref:!0,__self:!0,__source:!0};function s(e,t,n){var r,o={},s=null,l=null;for(r in void 0!==n&&(s=""+n),void 0!==t.key&&(s=""+t.key),void 0!==t.ref&&(l=t.ref),t)a.call(t,r)&&!c.hasOwnProperty(r)&&(o[r]=t[r]);if(e&&e.defaultProps)for(r in t=e.defaultProps)void 0===o[r]&&(o[r]=t[r]);return{$$typeof:u,type:e,key:s,ref:l,props:o,_owner:i.current}}t.jsx=s,t.jsxs=s},85893:function(e,t,n){e.exports=n(75251)}}]);