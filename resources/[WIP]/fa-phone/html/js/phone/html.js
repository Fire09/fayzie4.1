function initTippy() {
  $(".jss52346").hide();
  $(".lsbn-post-create").hide()
  $(".lsbn-song-create").hide()
  tippy('.jss35', {
    theme: 'nopixel',
    inertia: true,
  })
  tippy('.jss44', {
    theme: 'nopixel',
    inertia: true,
  })
  tippy('.asdfasdf', {
    theme: 'nopixel',
    inertia: true,
  })
  tippy('[data-tippy-content]', {
    theme: 'nopixel',
    inertia: true,
  })
}

function flipCaret(pName, t) {
  $(pName).css('-webkit-animation', "rotatetomommy 0.2s  linear")
  $(t).addClass('Mui-focused');

  setTimeout(() => {
      $(pName).css('transform', "rotate(180deg)")
  }, 150)
}

function setPhoneContactInput(name, number) {
  console.log(name, number)
  $("#contactInput-id").val(number)
  document.getElementById("contactInput").innerHTML = name;
}

function flipCaretv2(pName, t) {
  $(pName).css('-webkit-animation', "rotatetodaddy 0.2s  linear")
  $(t).removeClass('Mui-focused');

  setTimeout(() => {
      $(pName).css('transform', "rotate(0deg)")
  }, 150)
}

let isHeart = false;
function phoneBankFocus() {
    $('#wb-phone').addClass('Mui-focused');
    $('#message-form').addClass('Mui-focused');
    $('#arama-form').addClass('Mui-focused');
    $('.wbp-text').addClass('MuiInputLabel-shrink Mui-focused')
  };
  function SetDropdownHire(text) {
    document.getElementById("penisinbuttholebung").innerHTML = text;
    document.getElementById("penisinbuttholebung1").innerHTML = text;
    document.getElementById("penisinbuttholebung2").innerHTML = text;
    document.getElementById("penisinbuttholebung3").innerHTML = text;
  }
  
  function changeThisHourShitDiamondSports(id) {
    document.getElementById("diamondEventTimeHours").innerHTML = id;
  }

  function changeThisMinuteShitDiamondSports(id) {
    document.getElementById("diamondEventTimeMinutes").innerHTML = id;
  }

  function setDropdownDocuments(text) {
    $(".jss2717369").empty();
    document.getElementById("documentsbung").innerHTML = text;
    $.post('https://fa-phone/getDocuments', JSON.stringify({
        pType: text
    }))
  }

  function saveDocument() {
    let documentID = document.getElementById("document-id").value
    let documentText = tinymce.get('fuckthisseashit').getContent()
    let documentTitle = document.getElementById("ppclankkv2").value
    console.log(documentText)
    complateInputQuick();
    $(".dv2-save2").hide();
    $(".dc2-save4").show();
    setTimeout(() => {
      $.post('https://fa-phone/updateDocument', JSON.stringify({
        documentID: documentID,
        documentText: documentText,
        documentTitle: documentTitle
    }));
    }, 1500)
  }

  function createNewDocument() {
    let type = document.getElementById("documentsbung").innerHTML;
//    console.log(type)
    if (type === "Licenses" || type === "Vehicle Registration" || type === "Housing Documents" || type === "Contracts") {} else {
      $(".jss2717369").empty();
      complateInputQuick();
      $.post('https://fa-phone/createDocument', JSON.stringify({
        documentType: type
    }));
        setTimeout(() => {
          $.post('https://fa-phone/getDocuments', JSON.stringify({
            pType: type
        }));
      }, 1500)
    }
}
  //currentColor
  function changeToHeartViceVersa() {
    //'transform', 'scale(2,2)'
    //class="svg-inline--fa fa-circle fa-w-16 fa-fw fa-lg "
    isHeart = true;
    document.getElementById("fuckmehomebutton").setAttribute("class", "fa-circle fa-w-16 fa-fw fa-lg pushitout")
    document.getElementById("homeSVGID").setAttribute("d", "M0 190.9V185.1C0 115.2 50.52 55.58 119.4 44.1C164.1 36.51 211.4 51.37 244 84.02L256 96L267.1 84.02C300.6 51.37 347 36.51 392.6 44.1C461.5 55.58 512 115.2 512 185.1V190.9C512 232.4 494.8 272.1 464.4 300.4L283.7 469.1C276.2 476.1 266.3 480 256 480C245.7 480 235.8 476.1 228.3 469.1L47.59 300.4C17.23 272.1 .0003 232.4 .0003 190.9L0 190.9z")
    document.getElementById("homeSVGID").setAttribute("fill", "#146EBE")
    $("#fuckmehomebutton").css('font-size','1.05em');

  }

  function changeToRegularViceVersa() {
    if (isHeart) {
      setTimeout(() => {
        isHeart = false;
        document.getElementById("fuckmehomebutton").setAttribute("class", "fa-circle fa-w-16 fa-fw fa-lg popthecherry")
        document.getElementById("homeSVGID").setAttribute("d", "M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm0 448c-110.5 0-200-89.5-200-200S145.5 56 256 56s200 89.5 200 200-89.5 200-200 200z")
        document.getElementById("homeSVGID").setAttribute("fill", "currentColor")
        $("#fuckmehomebutton").css('font-size','1.05em');
      }, 150)
    }
  }


  function reversedPhoneBankFocus() {
    $('#message-phone').removeClass('Mui-focused');
    $('#wb-phone').removeClass('Mui-focused');
    $('.wbp-text').removeClass('Mui-focused')
  };