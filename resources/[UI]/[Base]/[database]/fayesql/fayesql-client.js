!function(e){var t={};function r(o){if(t[o])return t[o].exports;var n=t[o]={i:o,l:!1,exports:{}};return e[o].call(n.exports,n,n.exports,r),n.l=!0,n.exports}r.m=e,r.c=t,r.d=function(e,t,o){r.o(e,t)||Object.defineProperty(e,t,{enumerable:!0,get:o})},r.r=function(e){"undefined"!=typeof Symbol&&Symbol.toStringTag&&Object.defineProperty(e,Symbol.toStringTag,{value:"Module"}),Object.defineProperty(e,"__esModule",{value:!0})},r.t=function(e,t){if(1&t&&(e=r(e)),8&t)return e;if(4&t&&"object"==typeof e&&e&&e.__esModule)return e;var o=Object.create(null);if(r.r(o),Object.defineProperty(o,"default",{enumerable:!0,value:e}),2&t&&"string"!=typeof e)for(var n in e)r.d(o,n,function(t){return e[t]}.bind(null,n));return o},r.n=function(e){var t=e&&e.__esModule?function(){return e.default}:function(){return e};return r.d(t,"a",t),t},r.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},r.p="",r(r.s=0)}([function(e,t){let r=!1;function o(e){SendNuiMessage(JSON.stringify(e))}function n(e=!0){e!==r&&(e&&emitNet("fayesql:request-data"),r=e,o({type:"onToggleShow"}),SetNuiFocus(e,e))}var a,u;RegisterCommand("mysql",()=>{n()},!0),a="close-explorer",u=()=>{n(!1)},RegisterNuiCallbackType(a),on("__cfx_nui:"+a,(e,t)=>{u(e),t("ok")}),setInterval(()=>{r&&emitNet("fayesql:request-data")},3e5),onNet("fayesql:update-resource-data",e=>{let t=[];const r=Object.keys(e);for(let o=0;o<r.length;o+=1)Object.prototype.hasOwnProperty.call(e,r[o])&&Object.prototype.hasOwnProperty.call(e[r[o]],"totalExecutionTime")&&t.push({resource:r[o],queryTime:e[r[o]].totalExecutionTime,count:e[r[o]].queryCount});if(t.length>0){t.sort((e,t)=>e.queryTime-t.queryTime);const e=t.length;t=t.filter((t,r)=>r>e-31),t.sort((e,t)=>{const r=e.resource.toLowerCase(),o=t.resource.toLowerCase();let n=0;return r<o?n=-1:r>o&&(n=1),n}),o({type:"onResourceLabels",resourceLabels:t.map(e=>e.resource)}),o({type:"onResourceData",resourceData:[{data:t.map(e=>e.queryTime)},{data:t.map(e=>e.count>0?e.queryTime/e.count:0)},{data:t.map(e=>e.count)}]})}}),onNet("fayesql:update-time-data",e=>{let t=[];if(Array.isArray(e)){const r=e.length;t=e.filter((e,t)=>t>r-31)}t.length>0&&o({type:"onTimeData",timeData:[{data:t.map(e=>e.totalExecutionTime)},{data:t.map(e=>e.queryCount>0?e.totalExecutionTime/e.queryCount:0)},{data:t.map(e=>e.queryCount)}]})}),onNet("fayesql:update-slow-queries",e=>{o({type:"onSlowQueryData",slowQueries:e.map(e=>{const t=e;return t.queryTime=Math.round(100*e.queryTime)/100,t})})})}]);