function btnHangUp(){
    $.post('https://fa-phone/btnHangup', JSON.stringify({}))
} 

function btnAnswer(){ 
    $.post('https://fa-phone/btnAnswer', JSON.stringify({}))
}

function pingReject(){
    $.post('https://fa-phone/fa-ui:pingReject', JSON.stringify({}))
} 

function pingAccept(){
    $.post('https://fa-phone/fa-ui:pingAccept', JSON.stringify({}))
}

function billDecline(){
}

function billAccept(data){
    let price = data.amount
    let sID = data.sellerID
    $.post('https://fa-phone/purchaseCar', JSON.stringify({amount:price, sID: sID}))
}

function createCameraDropdown(cameraData) {
    var camData = `<li><a href="#" class="waves-effect waves-light" onclick="SetStateBagCamera('${cameraData.cid}')">${cameraData.name}</a></li>`
    console.log(camData)
    $('.removeCamera').append(camData);
}


function SetStateBagCamera(func) {
    $("#cameraRemoveID").val(func)
}