(this.webpackJsonpboost=this.webpackJsonpboost||[]).push([[0],{136:function(e,t,n){},147:function(e,t,n){"use strict";n.r(t);var c=n(0),s=n.n(c),a=n(31),i=n.n(a),o=n(5),r=(n(136),n(12)),l=n(1),j=function(e){var t=e.completed,n={width:"".concat(t,"%")};return Object(l.jsx)(l.Fragment,{children:Object(l.jsx)("div",{className:"proggresBoosting",children:Object(l.jsx)("div",{style:n,className:"proggresBoosting2"})})})},b=n(224),u=n(238),d=n(249),m=n(239),O=n(88),h=n.n(O),p=n(103),x=function(){return!window.invokeNative};function f(e,t){return g.apply(this,arguments)}function g(){return(g=Object(p.a)(h.a.mark((function e(t,n){var c,s,a,i;return h.a.wrap((function(e){for(;;)switch(e.prev=e.next){case 0:if(x()){e.next=10;break}return c={method:"post",headers:{"Content-Type":"application/json; charset=UTF-8"},body:JSON.stringify(n)},s=window.GetParentResourceName?window.GetParentResourceName():"nui-frame-app",e.next=5,fetch("https://".concat(s,"/").concat(t),c);case 5:return a=e.sent,e.next=8,a.json();case 8:return i=e.sent,e.abrupt("return",i);case 10:case"end":return e.stop()}}),e)})))).apply(this,arguments)}var v=function(e){var t=Object(c.useState)(!0),n=Object(o.a)(t,2),s=n[0],a=n[1],i=Object(c.useState)(!1),r=Object(o.a)(i,2),j=r[0],O=r[1],h=Object(c.useState)(!1),p=Object(o.a)(h,2),x=p[0],g=p[1],v=Object(c.useState)(!1),N=Object(o.a)(v,2),C=N[0],y=N[1],w=Object(c.useState)(!1),S=Object(o.a)(w,2),B=S[0],k=S[1],E=Object(c.useState)(!1),I=Object(o.a)(E,2),T=I[0],A=I[1],P=Object(c.useState)(!1),R=Object(o.a)(P,2),L=R[0],M=R[1],G=Object(c.useState)(!1),U=Object(o.a)(G,2),F=U[0],V=U[1],z=Object(c.useState)(""),D=Object(o.a)(z,2),_=D[0],J=D[1],Y=Object(c.useState)(e.expires||30),Z=Object(o.a)(Y,2),W=Z[0],q=Z[1],Q=Object(c.useState)(99999),X=Object(o.a)(Q,2),K=X[0],H=X[1],$=Object(c.useState)(!1),ee=Object(o.a)($,2),te=ee[0],ne=ee[1];Object(c.useEffect)((function(){var e=W>0&&!te&&s&&setInterval((function(){return q(W-1)}),1e3);return function(){return clearInterval(e)}}),[W]),Object(c.useEffect)((function(){0===W&&(f("fa-boosting:DeclineContract",{props:e,IsInProgress:F}),a(!1))}),[W]),Object(c.useEffect)((function(){var t=K>0&&!te&&s&&setInterval((function(){return H(K-1)}),12e4);return function(){return function(t){clearInterval(t),f("fa-boosting:updateTime",{props:e,counter:W})}(t)}}),[K]),Object(c.useEffect)((function(){window.addEventListener("message",(function(e){e.data&&ce(e.data)}))}),[]);var ce=function(t){"UpdateValueUI"===t.action&&("SetDisableButtons"===t.app?V(!1):"RemoveContractInfo"===t.app&&t.data.IdToRemove===e.id&&a(!1))},se=function(e){J(e.target.value)},ae=function(){y(!0),O(!0)},ie=function(){k(!0),y(!0)},oe=function(){y(!1),k(!1),A(!1),M(!1),O(!1)},re=function(e){k(!1),y(!0),A(!0),M(e)},le=Object(m.a)({root:{"& .MuiInput-underline:after":{borderBottomColor:"white"},"& .MuiInput-underline:before":{borderBottomColor:"white"},"& .MuiInput-underline:hover:not(.Mui-focused):before":{borderBottomColor:"white"},"& .MuiInputBase-root":{color:"white"}}})();return Object(l.jsx)(l.Fragment,{children:s&&Object(l.jsxs)("div",{className:"ContractsInformationContainter",children:[Object(l.jsx)(b.a,{direction:"down",in:j,mountOnEnter:!0,unmountOnExit:!0,children:Object(l.jsxs)("div",{className:"setInputZone",children:[Object(l.jsx)("div",{className:"closeremoveContainer",children:Object(l.jsx)("button",{className:"closeRemove",onClick:oe,children:Object(l.jsx)("i",{className:"fas fa-times",style:{color:"white"}})})}),Object(l.jsx)("div",{className:"transferinfo",children:"Are you sure you want to transfer the contract?"}),Object(l.jsx)("div",{className:"submitfix",children:Object(l.jsx)("form",{onSubmit:function(t){t.preventDefault(),_.trim().length>0&&(O(!1),a(!1),f("fa-boosting:transferContract",{props:e,imputValue:_}))},autoComplete:"off",children:Object(l.jsx)(u.a,{className:"textfix",id:"input-with-icon-textfield",label:"Enter ID",classes:le,onChange:se,InputLabelProps:{style:{color:"white"}},InputProps:{startAdornment:Object(l.jsx)(d.a,{position:"start",children:Object(l.jsx)("i",{className:"fas fa-people-arrows",style:{color:"white"}})})},variant:"standard"},se)})})]})}),Object(l.jsx)(b.a,{direction:"down",in:x,mountOnEnter:!0,unmountOnExit:!0,children:Object(l.jsxs)("div",{className:"startContracZone",children:[Object(l.jsx)("h1",{style:{fontSize:"1.2rem"},children:"Starting Contract..."}),Object(l.jsx)("img",{alt:"img",src:"https://c.tenor.com/I6kN-6X7nhAAAAAj/loading-buffering.gif",width:"64",height:"64"})]})}),C?Object(l.jsx)(l.Fragment,{}):Object(l.jsxs)(l.Fragment,{children:[Object(l.jsx)("div",{className:"typeContainer",style:{marginTop:"10px"},children:Object(l.jsx)("span",{className:"typeReal",children:"".concat(e.type)})}),Object(l.jsxs)("div",{className:"infoContainer1",children:[Object(l.jsx)("div",{style:{marginTop:"4%"},children:"".concat(e.owner)}),Object(l.jsx)("div",{style:{marginTop:"4%"},children:Object(l.jsx)("b",{children:"".concat(e.vehicle)})}),Object(l.jsx)("div",{style:{marginTop:"4%"},children:"Buy in: ".concat(e.units," GNE")}),Object(l.jsxs)("div",{style:{marginTop:"4%"},children:["Expires in:",Object(l.jsx)("span",{style:{color:"green"},children:Object(l.jsxs)("span",{children:[" ","".concat(Math.floor(Math.round(W)/3600),"h ").concat(Math.floor(Math.round(W)%3600/60),"m ").concat(Math.ceil(Math.round(W)%3600%60),"s")]})})]})]}),Object(l.jsx)("div",{className:"buttonContractsInformationContainer",children:e.status?Object(l.jsxs)(l.Fragment,{children:[Object(l.jsx)("button",{disabled:!0,onClick:ie,className:"DisabledButtons",children:"Contract In Progress"}),Object(l.jsx)("button",{disabled:!0,onClick:ae,className:"DisabledButtons",children:"Transfer Contract"}),Object(l.jsx)("button",{onClick:function(){f("fa-boosting:cancelContract",{props:e,IsInProgress:F}),a(!1)},className:"CancelButton",children:"Cancel Contract"})]}):Object(l.jsxs)(l.Fragment,{children:[Object(l.jsx)("button",{disabled:e.disableButtons,onClick:ie,className:"ContractsButon",children:"Start Contract"}),Object(l.jsx)("button",{disabled:e.disableButtons,onClick:ae,className:"ContractsButon",children:"Transfer Contract"}),Object(l.jsx)("button",{disabled:e.disableButtons,onClick:function(){f("fa-boosting:DeclineContract",{props:e,IsInProgress:F}),a(!1)},className:"ContractsButon",children:"Decline Contract"})]})})]}),B?Object(l.jsxs)(l.Fragment,{children:[Object(l.jsx)("div",{className:"closeremoveContainer",children:Object(l.jsx)("button",{className:"closeRemove",onClick:oe,children:Object(l.jsx)("i",{className:"fas fa-times",style:{color:"white"}})})}),Object(l.jsxs)("div",{className:"infoContainer1",children:[Object(l.jsx)("div",{style:{marginTop:"4%",fontSize:"20px"},children:Object(l.jsx)("b",{children:"Select Type"})}),Object(l.jsx)("div",{style:{marginTop:"4%",fontSize:"0.9rem",color:"#a1a1a1"},children:"If you choose vin scratch it will cost and additional ".concat(e.ExtraVin," GNE to claim ownership.")}),Object(l.jsx)("button",{onClick:function(){re(!0)},className:"ContractsButon",style:{top:"25px",left:"0%"},children:"Vin Scratch"}),Object(l.jsx)("button",{onClick:function(){re(!1)},className:"ContractsButon",style:{top:"25px",left:"0%"},children:"Normal Dropoff"})]})]}):Object(l.jsx)(l.Fragment,{}),T?Object(l.jsx)(l.Fragment,{children:Object(l.jsxs)("div",{className:"infoContainer1",style:{marginTop:"70px"},children:[Object(l.jsx)("div",{style:{marginTop:"4%",fontSize:"20px"},children:Object(l.jsx)("b",{children:"Start Contract?"})}),Object(l.jsx)("button",{onClick:function(){O(!1),g(!0),A(!1),ne(!0),setTimeout((function(){y(!1),g(!1),f("fa-boosting:startContract",{props:e,IsVin:L}).then((function(t){t.Contract?(V(!0),e.AffectArray(e.id)):(ne(!1),V(!1))}))}),3e3)},className:"ContractsButon",style:{top:"25px",left:"0%"},children:"Continue"}),Object(l.jsx)("button",{onClick:oe,className:"ContractsButon",style:{top:"25px",left:"0%"},children:"Cancel"})]})}):Object(l.jsx)(l.Fragment,{})]})})},N=n(52),C=n.n(N),y=s.a.memo((function(e){var t=e.counter,n=e.setCounter,s=Object(c.useRef)(),a=Object(c.useState)([{expires:1e5,type:"A",vehicle:"test",owner:"test test",units:200,ExtraVin:"test"}]),i=Object(o.a)(a,2),b=i[0],u=i[1],d=Object(c.useState)(!1),m=Object(o.a)(d,2),O=m[0],h=m[1],p=Object(c.useState)(!1),x=Object(o.a)(p,2),g=x[0],N=x[1],y=Object(c.useState)(80),w=Object(o.a)(y,2),S=w[0],B=w[1],k=Object(c.useState)(0),E=Object(o.a)(k,2),I=E[0],T=E[1],A=Object(c.useState)("A"),P=Object(o.a)(A,2),R=P[0],L=P[1],M=Object(c.useState)("B"),G=Object(o.a)(M,2),U=G[0],F=G[1],V=function(e){var t=Object(r.a)(b),n=t.findIndex((function(t){return t.id===e}));t[n].status=!0,u(t)};Object(c.useEffect)((function(){window.addEventListener("message",(function(e){var t;e.data&&"UpdateValueUI"===(t=e.data).action&&("ContractsBoosting"===t.app?u((function(e){return[].concat(Object(r.a)(e),[t.data.contracts])})):"SetBoostingLevel"===t.app?(L(t.data.type1),F(t.data.type2),B(t.data.level)):"SetDisableButtons"===t.app?h(t.data.enableButtons):"SetExtraVin"===t.app&&T(t.data.ExtraVin))}))}),[]);var z=function(e){N(e),f("fa-boosting:JoinQueue",{queue:e})};return Object(l.jsx)("div",{children:Object(l.jsx)(C.a,{defaultPosition:{x:120,y:60},ref:s,handle:".boosting-b-buttons",children:Object(l.jsx)("div",{className:t?"":"hiddenComponent",children:Object(l.jsxs)("div",{className:"browser1",ref:s,children:[Object(l.jsxs)("div",{className:"boosting-b-buttons",children:[Object(l.jsx)("div",{className:"texto boosting-text",style:{fontWeight:600},children:"Boosting Contracts"}),Object(l.jsxs)("div",{className:"boosting-close-container",children:[Object(l.jsx)("button",{className:"btn min-btn"},"cmin-btn"),Object(l.jsx)("button",{className:"btn close-btn",onClick:function(){n(!1)}},"cclose-btn")]})]}),Object(l.jsxs)("div",{className:"boostin-buttons",children:[Object(l.jsx)("button",{disabled:O,className:"butMycontracts",children:"MY CONTRACTS"},"ContractOpen1"),g?Object(l.jsx)("button",{onClick:function(){return z(!1)},className:"butMyqueue",children:"LEAVE QUEUE"},"ContractOpen2"):Object(l.jsx)("button",{onClick:function(){return z(!0)},disabled:O,className:"butMyqueue",children:"JOIN QUEUE"},"ContractOpen3")]}),Object(l.jsx)("div",{className:"gholsi",children:Object(l.jsxs)("div",{className:"contracts_container",children:[Object(l.jsxs)("div",{style:{display:"flex",justifyContent:"space-evenly",alignItems:"center"},children:[Object(l.jsx)("div",{className:"levelProggres1",children:R}),Object(l.jsx)(j,{completed:S}),Object(l.jsx)("div",{className:"levelProggres1",children:U})]}),Object(l.jsx)("div",{className:"centerContainer",children:Object(l.jsx)("div",{className:"contractsContainers",children:b.map((function(e){return Object(l.jsx)(v,{disableButtons:O,id:e.id,vehicle:e.vehicle,type:e.type,owner:e.owner,expires:e.expires,units:e.units,coords:e.coords,identifier:e.identifier,status:e.status,ExtraVin:I,AffectArray:V})}))})})]})})]})})})})})),w=function(e){var t=e.props,n=Object(c.useState)(!0),s=Object(o.a)(n,2),a=s[0],i=s[1];return setTimeout((function(){i(!1)}),3500),Object(l.jsx)(b.a,{direction:"left",in:a,mountOnEnter:!0,unmountOnExit:!0,children:Object(l.jsxs)("div",{className:"NotificationBack2",children:[Object(l.jsxs)("div",{className:"NotiText",children:[Object(l.jsx)("span",{children:Object(l.jsx)("b",{children:"".concat(t.app)})}),Object(l.jsx)("div",{style:{marginTop:"3px"},children:t.msg})]}),Object(l.jsx)("div",{className:"NotiIcon",children:Object(l.jsx)("img",{alt:"img",src:t.img,height:32,width:32})})]})})},S=function(e){var t=e.counter,n=e.setCounter,s=new Audio("https://freesound.org/data/previews/434/434379_6965625-lq.mp3"),a=Object(c.useRef)(),i=Object(c.useState)([]),j=Object(o.a)(i,2),u=j[0],d=j[1],m=Object(c.useState)([]),O=Object(o.a)(m,2),h=O[0],p=O[1];Object(c.useEffect)((function(){var e=function(e){t&&a.current&&!a.current.contains(e.target)&&n(!1)};return document.addEventListener("mousedown",e),function(){document.removeEventListener("mousedown",e)}}),[t,n]);return Object(c.useEffect)((function(){window.addEventListener("message",(function(e){var t;e.data&&"UpdateValueUI"===(t=e.data).action&&"BoostingNotification"===t.app&&(JSON.parse(localStorage.getItem("popaudio")).pop&&s.play(),d((function(e){return[].concat(Object(r.a)(e),[t.data.notify])})),p((function(e){return[].concat(Object(r.a)(e),[t.data.notify])})))}))}),[]),Object(l.jsxs)("div",{children:[Object(l.jsx)(b.a,{direction:"left",in:t,mountOnEnter:!0,unmountOnExit:!0,timeout:250,children:Object(l.jsxs)("div",{className:"notificationContainer",ref:a,children:[Object(l.jsx)("div",{className:"texto notification-text",children:"Notifications"}),Object(l.jsx)("div",{className:"nContainer",children:u.map((function(e){return Object(l.jsxs)("div",{className:"NotificationBack",children:[Object(l.jsxs)("div",{className:"NotiText",children:[Object(l.jsx)("span",{children:Object(l.jsx)("b",{children:"".concat(e.app)})}),Object(l.jsx)("div",{style:{marginTop:"3px"},children:e.msg})]}),Object(l.jsx)("div",{className:"NotiIcon",children:Object(l.jsx)("img",{alt:"img",src:e.img,height:32,width:32})})]})}))})]})}),Object(l.jsx)("div",{className:"remove",children:h.map((function(e){return Object(l.jsx)(w,{props:e,OutNotifications:h,setOutNotifications:p})}))})]})},B=n(247),k=n(243),E=n(250),I=n(248),T=[{name:"Ferrar",url:"https://cdna.artstation.com/p/assets/images/images/009/412/768/large/mikhail-sharov-4-1080-2.jpg"},{name:"Yung",url:"https://cdna.artstation.com/p/assets/images/images/026/919/896/large/mikhail-sharov-cyberpunk-1-1080.jpg"},{name:"Dirft",url:"https://cdna.artstation.com/p/assets/images/images/009/272/408/large/mikhail-sharov-2-4k.jpg"},{name:"GTR",url:"https://cdnb.artstation.com/p/assets/images/images/029/958/761/large/mikhail-sharov-vulcar-hachura-r-1440-3.jpg"},{name:"AMG",url:"https://cdna.artstation.com/p/assets/images/images/009/420/080/large/mikhail-sharov-r32-1080.jpg"},{name:"R34",url:"https://cdna.artstation.com/p/assets/images/images/020/247/914/large/mikhail-sharov-hellfire2-2k.jpg"},{name:"Lambo",url:"https://cdna.artstation.com/p/assets/images/images/021/250/100/large/mikhail-sharov-enus-paragon.jpg"},{name:"R342",url:"https://cdnb.artstation.com/p/assets/images/images/033/394/951/large/mikhail-sharov-1-2k-jpg.jpg"},{name:"MCLAREN",url:"https://cdnb.artstation.com/p/assets/images/images/011/247/167/large/mikhail-sharov-bmwf82-roller-1080-3.jpg"},{name:"bmw",url:"https://cdnb.artstation.com/p/assets/images/images/025/616/407/large/mikhail-sharov-r35-1080-4.jpg"},{name:"MCLAREN2",url:"https://cdna.artstation.com/p/assets/images/images/039/837/400/large/mikhail-sharov-jester-ls-meet2-v1-2k.jpg"},{name:"carrito",url:"https://imgur.com/WYtC6YK.jpg"}],A=function(e){var t=e.counter,n=e.setCounter,s=e.setWallpaper,a=Object(c.useRef)(),i=Object(c.useRef)(),r=Object(c.useState)((function(){return JSON.parse(localStorage.getItem("popaudio"))||{pop:!0}})),j=Object(o.a)(r,2),O=j[0],h=j[1],p=Object(c.useState)(""),x=Object(o.a)(p,2),f=x[0],g=x[1],v=Object(c.useState)(!1),N=Object(o.a)(v,2),C=N[0],y=N[1],w=function(e){g(e.target.value)};Object(c.useEffect)((function(){localStorage.setItem("popaudio",JSON.stringify(O))}),[O]);Object(c.useEffect)((function(){var e=function(e){t&&a.current&&!a.current.contains(e.target)&&n(!1)};return document.addEventListener("mousedown",e),function(){document.removeEventListener("mousedown",e)}}),[t,n]),Object(c.useEffect)((function(){var e=function(e){C&&i.current&&!i.current.contains(e.target)&&y(!1)};return document.addEventListener("mousedown",e),function(){document.removeEventListener("mousedown",e)}}),[C,y]);var S=Object(m.a)({root:{"& .MuiInput-underline:after":{borderBottomColor:"grey"},"& .MuiInput-underline:before":{borderBottomColor:"grey"},"& .MuiInput-underline:hover:not(.Mui-focused):before":{borderBottomColor:"grey"},"& .MuiInputBase-root":{color:"grey"}}})();return Object(l.jsxs)("div",{children:[Object(l.jsx)(b.a,{direction:"left",in:t,mountOnEnter:!0,unmountOnExit:!0,timeout:250,children:Object(l.jsxs)("div",{className:"settingsContainer",ref:a,children:[Object(l.jsx)("div",{className:"texto settings-text",children:"Settings"}),Object(l.jsx)("div",{className:"inputContainer",children:Object(l.jsx)("form",{onSubmit:function(e){e.preventDefault(),f.trim().length>10&&s(f)},autoComplete:"off",children:Object(l.jsx)(u.a,{className:"textfix",id:"input-with-icon-textfield",label:"Enter Background",classes:S,sx:{width:"100%"},InputLabelProps:{style:{color:"white"}},onChange:w,InputProps:{startAdornment:Object(l.jsx)(d.a,{position:"start",children:Object(l.jsx)("i",{className:"fas fa-photo-video",style:{color:"white"}})})},variant:"standard"},w)})}),Object(l.jsxs)("div",{className:"btnfix",children:[Object(l.jsx)(B.a,{size:"small",variant:"contained",component:"span",sx:{bgcolor:"rgb(19, 85, 167)",fontSize:"0.8125rem",":hover":{bgcolor:"#69a74f",color:"white"}},onClick:function(){},children:"SAVE"}),Object(l.jsx)(B.a,{size:"small",variant:"contained",component:"span",sx:{bgcolor:"rgb(19, 85, 167)",fontSize:"0.8125rem",":hover":{bgcolor:"#69a74f",color:"white"}},onClick:function(){n(!1),y(!0)},children:"PRESETS"})]}),Object(l.jsx)("div",{style:{display:"flex",width:"90%",marginTop:"10px"},children:Object(l.jsx)(E.a,{control:Object(l.jsx)(k.a,{checked:O.pop,onChange:function(e){h({pop:e.target.checked})},style:{color:"#F2A365"}}),color:"primary",label:Object(l.jsx)("span",{style:{color:"white"},children:"Notification Audio"})})})]})}),Object(l.jsx)(b.a,{direction:"up",in:C,children:Object(l.jsxs)("div",{className:"PresetsContainer",ref:i,style:{transition:"all 300ms ease-in-out 0s "},children:[Object(l.jsx)("div",{className:"texto",style:{textAlign:"center",fontSize:"20px"},children:"Preset Backgrounds"}),Object(l.jsx)("div",{className:"Presets",children:Object(l.jsx)(I.a,{container:!0,spacing:{xs:2,md:3},columns:{xs:4,sm:8,md:12},children:T.map((function(e,t){return Object(l.jsx)(I.a,{item:!0,xs:2,sm:4,md:4,children:Object(l.jsx)("div",{className:"bgButton",onClick:function(){return s(e.url)},children:Object(l.jsx)("div",{style:{background:"url(".concat(e.url,") 0% 0% / cover")},className:"bgcontainer"})})},t)}))})})]})})]})},P=function(e){var t=e.icon,n=e.label,s=e.price,a=e.item,i=e.GenCounter,j=e.SetGenCounter,b=e.SetCartItems,u=e.ToPay,d=e.SetToPay,m=Object(c.useState)(0),O=Object(o.a)(m,2),h=O[0],p=O[1];return Object(l.jsxs)("div",{className:"bennysItems",children:[h>0?Object(l.jsx)("button",{className:"CounterBennys",children:h}):Object(l.jsx)(l.Fragment,{}),Object(l.jsx)("div",{className:"bennysIcon",children:Object(l.jsx)("img",{alt:"img",src:t,style:{left:"-50px"}})}),Object(l.jsxs)("div",{className:"BennysText",children:[Object(l.jsx)("p",{children:n}),Object(l.jsx)("p",{children:"Price: ".concat(s," GNE")})]}),Object(l.jsx)("button",{className:"BennysAddCartBTN",onClick:function(){p(h+1),j(i+1),d(u+s),b((function(e){return[{label:n,item:a,price:s,icon:t,index:i+1}].concat(Object(r.a)(e))}))},children:"ADD TO CART"})]})},R=s.a.memo((function(e){var t=e.counter,n=e.setCounter,s=Object(c.useRef)(),a=Object(c.useState)(0),i=Object(o.a)(a,2),j=i[0],b=i[1],u=Object(c.useState)(0),d=Object(o.a)(u,2),m=d[0],O=d[1],h=Object(c.useState)(!1),p=Object(o.a)(h,2),x=p[0],g=p[1],v=Object(c.useState)(!1),N=Object(o.a)(v,2),y=N[0],w=N[1],S=Object(c.useState)(!1),B=Object(o.a)(S,2),k=B[0],E=B[1],I=Object(c.useState)(!1),T=Object(o.a)(I,2),A=T[0],R=T[1],L=Object(c.useState)([]),M=Object(o.a)(L,2),G=M[0],U=M[1],F=Object(c.useState)([]),V=Object(o.a)(F,2),z=V[0],D=V[1],_=Object(c.useState)([]),J=Object(o.a)(_,2),Y=J[0],Z=J[1],W=Object(c.useState)([]),q=Object(o.a)(W,2),Q=q[0],X=q[1],K=Object(c.useState)([]),H=Object(o.a)(K,2),$=H[0],ee=H[1],te=Object(c.useState)([]),ne=Object(o.a)(te,2),ce=ne[0],se=ne[1],ae=Object(c.useState)([]),ie=Object(o.a)(ae,2),oe=ie[0],re=ie[1],le=Object(c.useState)(!0),je=Object(o.a)(le,2),be=je[0],ue=je[1],de=Object(c.useState)(!0),me=Object(o.a)(de,2),Oe=me[0],he=me[1],pe=Object(c.useState)(!0),xe=Object(o.a)(pe,2),fe=xe[0],ge=xe[1];Object(c.useEffect)((function(){window.addEventListener("message",(function(e){var t;e.data&&"UpdateValueUI"===(t=e.data).action&&("SetConsumableItems"===t.app?(X(t.data.ConsumableItems),ge(t.data.enable)):"SetPerformanceObject"===t.app?(ee(t.data.PerformanceObject),ue(t.data.enable)):"SetCosmeticObject"===t.app&&(se(t.data.CosmeticObject),he(t.data.enable)))}))}),[]);return Object(l.jsx)("div",{children:Object(l.jsx)(C.a,{defaultPosition:{x:120,y:60},handle:".boosting-bb-buttons",children:Object(l.jsx)("div",{className:t?"":"hiddenComponent",children:Object(l.jsxs)("div",{className:"BennysApp",children:[Object(l.jsxs)("div",{className:"boosting-bb-buttons",ref:s,children:[Object(l.jsx)("div",{className:"texto boosting-text",style:{fontWeight:600},children:"Bennys Online Shop"}),Object(l.jsxs)("div",{className:"boosting-close-container",children:[Object(l.jsx)("button",{className:"btn min-btn"},"cmin-btn"),Object(l.jsx)("button",{className:"btn close-btn",onClick:function(){n(!1)}},"cclose-btn")]})]}),Object(l.jsxs)("div",{className:"BennysAppButtons",children:[Object(l.jsxs)("div",{className:"auto",children:[Oe&&Object(l.jsx)("button",{className:k?"ButBennys":"ButBennys2",onClick:function(){E(!0),w(!1),g(!1),R(!1),Z(ce)},children:"COSMETIC PARTS"},"Cometic3"),be&&Object(l.jsx)("button",{className:y?"ButBennys":"ButBennys2",onClick:function(){w(!0),g(!1),E(!1),R(!1),D($)},children:"PERFORMANCE PARTS"},"Performance3"),fe&&Object(l.jsx)("button",{className:x?"ButBennys":"ButBennys2",onClick:function(){g(!0),w(!1),E(!1),R(!1),U(Q)},children:"CONSUMABLE PARTS"},"Consumable3"),Object(l.jsx)("input",{className:"InputBennys",onChange:function(e){var t,n=(t=e.target.value,x?Q.filter((function(e){return e.item.toLowerCase().includes(t.toLowerCase())})):performance?$.filter((function(e){return e.item.toLowerCase().includes(t.toLowerCase())})):k?ce.filter((function(e){return e.item.toLowerCase().includes(t.toLowerCase())})):void 0);x?U(n):performance?D(n):k&&Z(n)},placeholder:" Buscar",style:{color:"white",fontSize:"12px"}})]}),Object(l.jsx)("div",{className:"auto",children:Object(l.jsxs)("button",{className:"CarritoBennys",onClick:function(){E(!1),w(!1),g(!1),R(!0),Z(ce)},children:[Object(l.jsx)("i",{className:"fa-solid fa-cart-shopping",style:{color:"white"}}),"Cart",Object(l.jsx)("div",{className:"CounterBennysItems",children:j})]},"Consumable4")})]}),Object(l.jsxs)("div",{className:"bennysContainer",children:[x&&G.map((function(e){return Object(l.jsx)(P,{icon:e.icon,label:e.label,price:e.price,item:e.item,GenCounter:j,SetGenCounter:b,SetCartItems:re,ToPay:m,SetToPay:O})})),y&&z.map((function(e){return Object(l.jsx)(P,{icon:e.icon,label:e.label,price:e.price,item:e.item,GenCounter:j,SetGenCounter:b,SetCartItems:re,ToPay:m,SetToPay:O})})),k&&Y.map((function(e){return Object(l.jsx)(P,{icon:e.icon,label:e.label,price:e.price,item:e.item,GenCounter:j,SetGenCounter:b,SetCartItems:re,ToPay:m,SetToPay:O})})),A&&oe.map((function(e){return Object(l.jsxs)("div",{className:"bennysItemsCart",children:[Object(l.jsx)("div",{className:"bennysItemIcon",children:Object(l.jsx)("img",{alt:"img",src:e.icon,style:{},width:32,height:32})}),Object(l.jsx)("p",{className:"CartItemText",children:"- ".concat(e.label,"(1x) - ").concat(e.price," GNE")}),Object(l.jsx)("button",{className:"ButBennysCart",onClick:function(){return function(e){b(j-1),O(m-e.price),re((function(t){var n=Object(r.a)(t),c=n.findIndex((function(t){return t.index===e.index}));return n.splice(c,1),n}))}(e)},children:"REMOVE ITEM"},"CartItems")]})})),A&&Object(l.jsx)(l.Fragment,{children:Object(l.jsxs)("div",{className:"CartCheckout",children:[Object(l.jsx)("p",{className:"CheckoutText",children:"Total ".concat(m," GNE")}),Object(l.jsx)("button",{className:"CheckOut",onClick:function(){f("fa-boosting:BennysItem",{CartItems:oe,ToPay:m}).then((function(e){e.Continue&&(re([]),b(0),O(0))}))},children:"CHECKOUT"},"CartItems")]})})]})]})})})})})),L=n.p+"static/media/cog.540ab5dc.svg",M=n.p+"static/media/comment.c11482d5.svg",G=n.p+"static/media/wifi.71ec6722.svg",U=n(237),F=n(244),V=n(241),z=n(240),D=function(e){var t=e.counter,n=e.setCounter,s=Object(c.useState)(!0),a=Object(o.a)(s,2),i=a[0],r=a[1],j=Object(c.useState)({open:!1,page:"https://google.com",id:"google"}),b=Object(o.a)(j,2),u=b[0],d=b[1],m=Object(c.useState)(""),O=Object(o.a)(m,2),h=O[0],p=O[1],x=Object(c.useState)(0),g=Object(o.a)(x,2),v=g[0],N=g[1],y=Object(c.useState)(0),w=Object(o.a)(y,2),S=w[0],B=w[1],k=function(e){p(e.target.value)};Object(c.useEffect)((function(){window.addEventListener("message",(function(e){var t;e.data&&"UpdateValueUI"===(t=e.data).action&&("SetBoostingLevel"===t.app?N(t.data.gne):"UpdateGnes"===t.app?B(t.data.gne):"EnableApps"===t.app&&r(t.data.BuyApp))}))}),[]);var E=Object(z.a)({root:{"& .MuiInput-underline:after":{borderBottomColor:"white"},"& .MuiInput-underline:before":{borderBottomColor:"white"},"& .MuiInput-underline:hover:not(.Mui-focused):before":{borderBottomColor:"white"},"& .MuiInputBase-root":{color:"white"}}})();return Object(l.jsx)("div",{children:Object(l.jsx)(C.a,{defaultPosition:{x:120,y:60},handle:".browser-b-buttons",children:Object(l.jsx)("div",{className:t?"":"hiddenComponent",children:Object(l.jsxs)("div",{className:"GneFinance",children:[Object(l.jsxs)("div",{className:"browser-b-buttons",children:[Object(l.jsxs)("div",{className:"browser_tab",onClick:function(){i&&d({open:!0,page:"https://gne.com",id:"gne"})},children:[Object(l.jsx)("img",{src:"https://imgur.com/O10Rx0A.png",style:{marginRight:"0.5rem"},alt:"img",width:"16px",height:"16px"}),Object(l.jsx)("h1",{className:"gne_tab",children:"Finance Tab"})]}),Object(l.jsxs)("div",{className:"boosting-close-container",children:[Object(l.jsx)("button",{className:"btn min-btn"},"cmin-btn"),Object(l.jsx)("button",{className:"btn close-btn",onClick:function(){n(!1)}},"cclose-btn")]})]}),Object(l.jsx)("div",{className:"input_browser",children:Object(l.jsx)("input",{className:"inputStyles",type:"text",name:"name",value:u.page})}),"google"===u.id&&Object(l.jsx)("div",{className:"google",children:Object(l.jsx)("img",{src:"https://pngimg.com/uploads/google/google_PNG19644.png",alt:"img",width:720,height:320})}),u.open&&"gne"===u.id&&Object(l.jsxs)("div",{className:"financePage",children:[Object(l.jsxs)("div",{className:"design",children:[Object(l.jsx)("img",{src:"https://imgur.com/ihdYdZm.png",alt:"img",width:"202px",height:"143px"}),Object(l.jsx)("span",{style:{color:"#505051",fontSize:"18px"},children:"GNE available to buy"}),Object(l.jsxs)("span",{style:{color:"#1a936f",fontSize:"30px"},children:[S,Object(l.jsx)("span",{style:{color:"#505051",fontSize:"18px"},children:" credits"})]})]}),Object(l.jsxs)("div",{className:"design2",children:[Object(l.jsxs)("span",{style:{color:"white",fontSize:"18px"},children:["You have ",Object(l.jsxs)("span",{style:{color:"#1a936f",fontSize:"18px"},children:[" ",v]})," credits"]}),Object(l.jsx)("h3",{children:"GNE Checkout"}),Object(l.jsx)(U.a,{className:"textfix",id:"input-with-icon-textfield",label:"How many units do you want to buy?",classes:E,value:h,onChange:k,InputLabelProps:{style:{color:"white"}},InputProps:{startAdornment:Object(l.jsx)(F.a,{position:"start",children:Object(l.jsx)("i",{className:"fa-brands fa-buy-n-large",style:{color:"white"}})})},variant:"standard"},k),Object(l.jsx)("div",{children:Object(l.jsxs)(V.a,{variant:"contained",onClick:function(){""!==h&&(S>h||v===h)&&(f("ps-purchaseGNE",{imputValue:h}),p(""))},sx:{margin:"10px",bgcolor:"#169776",":hover":{bgcolor:"#5a5a5a",color:"white"}},children:[Object(l.jsx)("i",{className:"fa-solid fa-check",style:{marginRight:"3px"}}),"Purchase"]})})]})]})]})})})})};var _=function(){var e=Object(c.useState)(!1),t=Object(o.a)(e,2),n=t[0],s=t[1],a=Object(c.useState)(!1),i=Object(o.a)(a,2),r=i[0],j=i[1],b=Object(c.useState)(!1),u=Object(o.a)(b,2),d=u[0],m=u[1],O=Object(c.useState)(!1),h=Object(o.a)(O,2),p=h[0],x=h[1],g=Object(c.useState)(!0),v=Object(o.a)(g,2),N=v[0],C=v[1],w=Object(c.useState)((function(){return JSON.parse(localStorage.getItem("boostingLaptop"))||"https://i.imgur.com/9VbxwNU.png"})),B=Object(o.a)(w,2),k=B[0],E=B[1],I=Object(c.useState)(!1),T=Object(o.a)(I,2),P=T[0],U=T[1],F=Object(c.useState)({visible:!window.invokeNative}),V=Object(o.a)(F,2),z=V[0],_=V[1],J=Object(c.useState)({time:"00:00 12/12/2022"}),Y=Object(o.a)(J,2),Z=Y[0],W=Y[1];return Object(c.useEffect)((function(){window.addEventListener("message",(function(e){var t;e.data&&("openApplication"===(t=e.data).action?"OpenBoostingApp"===t.app&&_({visible:t.show}):"UpdateValueUI"===t.action&&("BoostingApp"===t.app?W({time:t.data.time}):"EnableApps"===t.app&&C(t.data.BennysApp)))}))}),[]),Object(c.useEffect)((function(){localStorage.setItem("boostingLaptop",JSON.stringify(k))}),[k]),Object(c.useEffect)((function(){function e(e){"Escape"===e.code&&(_({visible:!1}),f("fa-boosting:closeBoostingApp",{}))}return document.addEventListener("keydown",e),function(){return document.removeEventListener("keydown",e)}}),[z,_]),Object(l.jsx)("div",{className:"BoostingContainer",style:z.visible?{}:{opacity:"0"},children:Object(l.jsx)("div",{className:"rectangule",children:Object(l.jsxs)("div",{className:"container",style:{backgroundImage:"URL('".concat(k,"')")},children:[Object(l.jsxs)("div",{className:"windows_apps",children:[Object(l.jsxs)("button",{className:"win_apps",children:[Object(l.jsx)("img",{height:50,width:50,alt:"img",src:"https://imgur.com/6RPZ0KP.png"}),"Recyle Bin"]}),Object(l.jsxs)("button",{className:"win_apps",children:[Object(l.jsx)("img",{alt:"img",src:"https://imgur.com/X1kbasV.png"}),"Stuff"]}),Object(l.jsxs)("button",{onClick:function(){s(!0)},className:"win_apps",children:[Object(l.jsx)("img",{height:50,width:50,alt:"img",src:"https://i.imgur.com/nZAR3N6.png"}),"Boosting"]}),N&&Object(l.jsxs)("button",{onClick:function(){j(!0)},className:"win_apps",children:[Object(l.jsx)("img",{height:40,width:40,alt:"img",src:"https://imgur.com/kGxkXTk.png"}),"Bennys Parts"]})]}),Object(l.jsx)(D,{counter:P,setCounter:U}),Object(l.jsx)(R,{counter:r,setCounter:j}),Object(l.jsx)(y,{counter:n,setCounter:s}),Object(l.jsx)(S,{counter:p,setCounter:x}),Object(l.jsx)(A,{counter:d,setCounter:m,setWallpaper:E}),Object(l.jsxs)("div",{className:"windows_bar",children:[Object(l.jsxs)("div",{className:"fix_bar",children:[Object(l.jsx)("button",{className:"color4",style:{},children:Object(l.jsx)("img",{alt:"img",src:"https://i.imgur.com/mRsR8UP.png",width:"24",height:"24"})}),Object(l.jsx)("button",{className:"color4",style:{},children:Object(l.jsx)("img",{alt:"img",src:"https://imgur.com/QFOk7B1.png",width:"24",height:"24"})}),Object(l.jsx)("button",{className:P?"OpenedButton":"color4",style:{},onClick:function(){U(!0)},children:Object(l.jsx)("img",{alt:"img",src:"https://i.imgur.com/wFozc9a.png",width:"24",height:"24"})}),n&&Object(l.jsx)("button",{className:"OpenedButton",style:{},children:Object(l.jsx)("img",{alt:"img",src:"https://i.imgur.com/nZAR3N6.png",height:24,width:24})}),r&&Object(l.jsx)("button",{className:"OpenedButton",style:{},children:Object(l.jsx)("img",{alt:"img",src:"https://imgur.com/kGxkXTk.png",height:24,width:24})})]}),Object(l.jsx)("button",{onClick:function(){m(!0)},className:"color",children:Object(l.jsx)("img",{alt:"img",src:L,className:"filter-white",style:{color:"white"},height:17,width:17})}),Object(l.jsx)("button",{className:"color",children:Object(l.jsx)("img",{alt:"img",src:G,style:{color:"white"},className:"filter-white",height:17,width:17})}),Object(l.jsx)("div",{className:"textohora",children:Z.time}),Object(l.jsx)("button",{onClick:function(){x(!0)},className:"color",children:Object(l.jsx)("img",{alt:"img",src:M,style:{color:"white"},className:"filter-white",height:17,width:17})})]})]})})})},J=function(){return Object(l.jsx)("div",{children:Object(l.jsx)(_,{})})};i.a.render(Object(l.jsx)(J,{}),document.getElementById("root"))}},[[147,1,2]]]);
//# sourceMappingURL=main.17d5bc58.chunk.js.map