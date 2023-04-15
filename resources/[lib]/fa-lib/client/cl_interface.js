const regged = [];

function RegisterInterfaceCallback(name, cb) {
    AddEventHandler(`_apx_uiReq:${name}`, cb);

    if (GetResourceState('fa-interface') === 'started') exports['fa-interface'].RegisterIntefaceEvent(name);

    regged.push(name);
}

function SendInterfaceMessage(data) {
    exports['fa-interface'].SendInterfaceMessage(data);
}

function SetInterfaceFocus(hasFocus, hasCursor) {
    exports['fa-interface'].SetInterfaceFocus(hasFocus, hasCursor);
}

function GetInterfaceFocus() {
    return exports['fa-interface'].GetInterfaceFocus();
}

AddEventHandler('_apx_uiReady', () => {
    regged.forEach((eventName) => exports['fa-interface'].RegisterIntefaceEvent(eventName));
});