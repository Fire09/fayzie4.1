const registered = [];

function RegisterUICallback(name, cb) {
    AddEventHandler(`_fyx_uiReq:${name}`, cb);

    if (GetResourceState('fa-ui') === 'started') exports['fa-ui'].RegisterUIEvent(name);

    registered.push(name);
}

function SendUIMessage(data) {
    exports['fa-ui'].SendUIMessage(data);
}

function SetUIFocus(hasFocus, hasCursor) {
    exports['fa-ui'].SetUIFocus(hasFocus, hasCursor);
}

function GetUIFocus() {
    return exports['fa-ui'].GetUIFocus();
}

AddEventHandler('_fyx_uiReady', () => {
    registered.forEach((eventName) => exports['fa-ui'].RegisterUIEvent(eventName));
});