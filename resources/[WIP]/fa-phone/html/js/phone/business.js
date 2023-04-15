function addGroups(groups) {
    for (let group in groups) {
        let groupElement =`<div class="component-paper lawyer-div" data-action="group-manage" onclick="manageGroups('${groups[group].idsent}')" data-action-data="${groups[group].idsent}" data-tippy-content="Manage ${groups[group].namesent}" >
        <div class="main-container" >
            <div class="image" style="margin-left:-10px">
            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="briefcase" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="svg-inline--fa fa-briefcase fa-w-16 fa-3x " style="width: 1.5em;"><path fill="currentColor" d="M496 224C416.4 224 352 288.4 352 368s64.38 144 144 144s144-64.38 144-144S575.6 224 496 224zM544 384h-54.25C484.4 384 480 379.6 480 374.3V304C480 295.2 487.2 288 496 288C504.8 288 512 295.2 512 304V352h32c8.838 0 16 7.162 16 16C560 376.8 552.8 384 544 384zM320.1 352H208C199.2 352 192 344.8 192 336V288H0v144C0 457.6 22.41 480 48 480h312.2C335.1 449.6 320 410.5 320 368C320 362.6 320.5 357.3 320.1 352zM496 192c5.402 0 10.72 .3301 16 .8066V144C512 118.4 489.6 96 464 96H384V48C384 22.41 361.6 0 336 0h-160C150.4 0 128 22.41 128 48V96H48C22.41 96 0 118.4 0 144V256h360.2C392.5 216.9 441.3 192 496 192zM336 96h-160V48h160V96z" class=""></path></svg>
            </div>
            <div class="details " style="margin-left:5px">
                <div class="title ">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word;">${groups[group].namesent}</p>
                </div>
                <div class="description ">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word;">${groups[group].ranksent}</p>
                </div>
            </div>
        </div>
      </div>`

        $('.jss17911111').append(groupElement);
        tippy('.lawyer-div', {
            theme: 'nopixel',
            inertia: true,
          })
    }
}

function manageGroups(id){
    $.post('http://fa-phone/manageGroup', JSON.stringify({
        GroupID: id
    }));
}

function addGroupSentDatah(props) {
    for (let i = 0; i < props.length; i++) {
        let groupData =``
        let name = props[i].name
        let penis = true
        if (penis) {
            groupData += `<li><a href="#" class="waves-effect waves-light" onclick="SetDropdownHire('${name.dada}')">${name.dada}</a></li>`
            $('.sendmedatanoprn').append(groupData);
            $('.sendmedatanoprn1').append(groupData);
            $('.sendmedatanoprn2').append(groupData);
            $('.sendmedatanoprn3').append(groupData);
        }
    }
}


function buildOptionsMenu(roleM, roleC, chargeA, bankA, canH, logsA) {
        let vaginal = true
        if (vaginal) {
            vaginal = false;
            if (!canH) {
                $('.btn-hire').hide();
            } else {
                $('.btn-hire').show();
            }
            if (!bankA) {
                $('.btn-d-paycheck-1').hide();
            } else {
                $('.btn-d-paycheck-1').show();
            }
            if (!chargeA) {
                $('.btn-charge').hide();
            } else {
                $('.btn-charge').show();
            }
            if (!roleC) {
                $('.btn-d-create-role').hide();
            } else {
                $('.btn-d-create-role').show();
            }
            if (!roleM) {
                $('.btn-d-edit-role').hide();
                $('.btn-d-delete-role').hide();
            } else {
                $('.btn-d-edit-role').show();
                $('.btn-d-delete-role').show();
            }
            if (!logsA) {
                $('.btn-d-logs').hide();
            } else {
                $('.btn-d-logs').show();
            }
        }
}

document.addEventListener('click', function handleClickOutsideBox(event) {
    const box = document.getElementById('option-main');
    const other = document.getElementById('penisinthefuckingbutthoe');

    if (!box.contains(event.target) && !other.contains(event.target)) {
        $(".option-main").fadeOut();
     // box.style.display = 'none';
    }
  });



function addGroupManage(group,ranking) {
    // console.log('data',JSON.stringify(group))
    // $('.group-manage-company-name').text(group.groupName).data('group-id', group.groupId);
    // $('.group-manage-company-bank').text('$' + group.bank);
    $('#business-id').val(group.groupId)
    $('#business-id-f').val(group.groupId)
   $('#bussiness-id-add-cash').val(group.groupId)
   $(".btn-d-refresh").attr("bIdRef", group.groupId);
   globalGroup = group.groupId
   globalBank = group.bank
   $.post('http://fa-phone/retreiveGroupRanks', JSON.stringify({
       bID: globalGroup
   }));
    for (let i = 0; i < group.employees.length; i++) {
        let employee = group.employees[i];
        var random = Math.floor(Math.random() * 10000) + 1;
        let position = employee.role
        let employeeEntry =``
        $("#business-current-role").val(employee.myRank)
        buildOptionsMenu(employee.role_manage, employee.role_create, employee.charge_access, employee.bank_access, employee.can_hire, employee.logs_access)
    if (position === "Owner") {
        employeeEntry += `
        <div hoverid=${random} class="component-paper contract-count">
        <div class="main-container">
            <div class="image">
                <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user-circle"
                class="svg-inline--fa fa-user-circle fa-w-16 fa-fw fa-3x " role="img"
                xmlns="http://www.w3.org/2000/svg" viewBox="0 0 496 512">
                <path fill="currentColor"
                d="M377.7 338.8l37.15-92.87C419 235.4 411.3 224 399.1 224h-57.48C348.5 209.2 352 193 352 176c0-4.117-.8359-8.057-1.217-12.08C390.7 155.1 416 142.3 416 128c0-16.08-31.75-30.28-80.31-38.99C323.8 45.15 304.9 0 277.4 0c-10.38 0-19.62 4.5-27.38 10.5c-15.25 11.88-36.75 11.88-52 0C190.3 4.5 181.1 0 170.7 0C143.2 0 124.4 45.16 112.5 88.98C63.83 97.68 32 111.9 32 128c0 14.34 25.31 27.13 65.22 35.92C96.84 167.9 96 171.9 96 176C96 193 99.47 209.2 105.5 224H48.02C36.7 224 28.96 235.4 33.16 245.9l37.15 92.87C27.87 370.4 0 420.4 0 477.3C0 496.5 15.52 512 34.66 512H413.3C432.5 512 448 496.5 448 477.3C448 420.4 420.1 370.4 377.7 338.8zM176 479.1L128 288l64 32l16 32L176 479.1zM271.1 479.1L240 352l16-32l64-32L271.1 479.1zM320 186C320 207 302.8 224 281.6 224h-12.33c-16.46 0-30.29-10.39-35.63-24.99C232.1 194.9 228.4 192 224 192S215.9 194.9 214.4 199C209 213.6 195.2 224 178.8 224h-12.33C145.2 224 128 207 128 186V169.5C156.3 173.6 188.1 176 224 176s67.74-2.383 96-6.473V186z">
                </path>
                </svg>
                </div>
                <div class="details ">
                <div class="title ">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                style="word-break: break-word;">${employee.first_name} ${employee.last_name}</p>
                </div>
                <div class="description ">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                style="word-break: break-word;">${position}</p>
                </div>
                </div>
                <div hoverid="${random}" class="actions actions-show" style="display: none;">`
            } else {
                employeeEntry += `
                <div hoverid=${random} class="component-paper contract-count">
                <div class="main-container">
                    <div class="image">
                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user-circle"
                        class="svg-inline--fa fa-user-circle fa-w-16 fa-fw fa-3x " role="img"
                        xmlns="http://www.w3.org/2000/svg" viewBox="0 0 496 512">
                        <path fill="currentColor"
                        d="M352 128C352 198.7 294.7 256 224 256C153.3 256 96 198.7 96 128C96 57.31 153.3 0 224 0C294.7 0 352 57.31 352 128zM209.1 359.2L176 304H272L238.9 359.2L272.2 483.1L311.7 321.9C388.9 333.9 448 400.7 448 481.3C448 498.2 434.2 512 417.3 512H30.72C13.75 512 0 498.2 0 481.3C0 400.7 59.09 333.9 136.3 321.9L175.8 483.1L209.1 359.2z">
                        </svg>
                        </div>
                        <div class="details ">
                        <div class="title ">
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                        style="word-break: break-word;">${employee.first_name} ${employee.last_name}</p>
                        </div>
                        <div class="description ">
                        <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                        style="word-break: break-word;">${position}</p>
                        </div>
                        </div>
                        <div hoverid="${random}" class="actions actions-show" style="display: none;">`
            }
            if (employee.role_manage === true) {
                employeeEntry +=`
                    <div data-tippy-content="Set Rank" class="btn-set-rank wehat-buisiness" data-cid="${employee.cid}" data-rank="${employee.role}">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user-slash" class="svg-inline--fa fa-user-slash fa-w-20 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                        <path fill="currentColor" d="M351.8 367.3v-44.1C328.5 310.7 302.4 304 274.7 304H173.3c-95.73 0-173.3 77.65-173.3 173.4C.0005 496.5 15.52 512 34.66 512h378.7c11.86 0 21.82-6.337 28.07-15.43l-61.65-61.57C361.7 416.9 351.8 392.9 351.8 367.3zM224 256c70.7 0 128-57.31 128-128S294.7 0 224 0C153.3 0 96 57.31 96 128S153.3 256 224 256zM630.6 364.8L540.3 274.8C528.3 262.8 512 256 495 256h-79.23c-17.75 0-31.99 14.25-31.99 32l.0147 79.2c0 17 6.647 33.15 18.65 45.15l90.31 90.27c12.5 12.5 32.74 12.5 45.24 0l92.49-92.5C643.1 397.6 643.1 377.3 630.6 364.8zM447.8 343.9c-13.25 0-24-10.62-24-24c0-13.25 10.75-24 24-24c13.38 0 24 10.75 24 24S461.1 343.9 447.8 343.9z">
                        </path>
                    </svg>
                </div>`
            }
            if (employee.can_fire === true) {
                employeeEntry +=`<div data-tippy-content="Remove Employee" class="btn-set-remove wehat-buisiness" data-cid="${employee.cid}" data-rank="${employee.role}">
                        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="comment" class="svg-inline--fa fa-comment fa-w-16 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                            <path fill="currentColor" d="M284.9 320l-60.9-.0002c-88.36 0-160 71.63-160 159.1C63.1 497.7 78.33 512 95.1 512l448-.0039c.0137 0-.0137 0 0 0l-14.13-.0013L284.9 320zM630.8 469.1l-249.5-195.5c48.74-22.1 82.65-72.1 82.65-129.6c0-79.53-64.47-143.1-143.1-143.1c-69.64 0-127.3 49.57-140.6 115.3L38.81 5.109C34.41 1.672 29.19 0 24.03 0C16.91 0 9.845 3.156 5.127 9.187c-8.187 10.44-6.375 25.53 4.062 33.7L601.2 506.9c10.5 8.203 25.56 6.328 33.69-4.078C643.1 492.4 641.2 477.3 630.8 469.1z">
                            </path>
                        </svg>
                    </div>`
            }

            if (employee.bank_access === true) {
                employeeEntry +=`<div data-tippy-content="Set Paycheck" class="btn-set-paycheck wehat-buisiness" data-cid="${employee.cid}">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="phone" class="svg-inline--fa fa-phone fa-w-16 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
                        <path fill="currentColor" d="M568.2 336.3c-13.12-17.81-38.14-21.66-55.93-8.469l-119.7 88.17h-120.6c-8.748 0-15.1-7.25-15.1-15.99c0-8.75 7.25-16 15.1-16h78.25c15.1 0 30.75-10.88 33.37-26.62c3.25-20-12.12-37.38-31.62-37.38H191.1c-26.1 0-53.12 9.25-74.12 26.25l-46.5 37.74L15.1 383.1C7.251 383.1 0 391.3 0 400v95.98C0 504.8 7.251 512 15.1 512h346.1c22.03 0 43.92-7.188 61.7-20.27l135.1-99.52C577.5 379.1 581.3 354.1 568.2 336.3zM279.3 175C271.7 173.9 261.7 170.3 252.9 167.1L248 165.4C235.5 160.1 221.8 167.5 217.4 179.1s2.121 26.2 14.59 30.64l4.655 1.656c8.486 3.061 17.88 6.095 27.39 8.312V232c0 13.25 10.73 24 23.98 24s24-10.75 24-24V221.6c25.27-5.723 42.88-21.85 46.1-45.72c8.688-50.05-38.89-63.66-64.42-70.95L288.4 103.1C262.1 95.64 263.6 92.42 264.3 88.31c1.156-6.766 15.3-10.06 32.21-7.391c4.938 .7813 11.37 2.547 19.65 5.422c12.53 4.281 26.21-2.312 30.52-14.84s-2.309-26.19-14.84-30.53c-7.602-2.627-13.92-4.358-19.82-5.721V24c0-13.25-10.75-24-24-24s-23.98 10.75-23.98 24v10.52C238.8 40.23 221.1 56.25 216.1 80.13C208.4 129.6 256.7 143.8 274.9 149.2l6.498 1.875c31.66 9.062 31.15 11.89 30.34 16.64C310.6 174.5 296.5 177.8 279.3 175z">
                        </path>
                    </svg>
                </div>
                `
            }
            if (employee.bank_access2 === true) {
                employeeEntry += `

                <div data-tippy-content="Bank Access" class="btn-bank-access wehat-buisiness" data-name="" data-number="">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="clipboard" class="svg-inline--fa fa-clipboard fa-w-12 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512">
                        <path fill="currentColor" d="M243.4 2.587C251.4-.8625 260.6-.8625 268.6 2.587L492.6 98.59C506.6 104.6 514.4 119.6 511.3 134.4C508.3 149.3 495.2 159.1 479.1 160V168C479.1 181.3 469.3 192 455.1 192H55.1C42.74 192 31.1 181.3 31.1 168V160C16.81 159.1 3.708 149.3 .6528 134.4C-2.402 119.6 5.429 104.6 19.39 98.59L243.4 2.587zM256 128C273.7 128 288 113.7 288 96C288 78.33 273.7 64 256 64C238.3 64 224 78.33 224 96C224 113.7 238.3 128 256 128zM127.1 416H167.1V224H231.1V416H280V224H344V416H384V224H448V420.3C448.6 420.6 449.2 420.1 449.8 421.4L497.8 453.4C509.5 461.2 514.7 475.8 510.6 489.3C506.5 502.8 494.1 512 480 512H31.1C17.9 512 5.458 502.8 1.372 489.3C-2.715 475.8 2.515 461.2 14.25 453.4L62.25 421.4C62.82 420.1 63.41 420.6 63.1 420.3V224H127.1V416z">
                        </path>
                    </svg>
                </div>`
            }
                employeeEntry +=`
            </div>
        </div>
        </div>`
        $(".component-paper").mouseover(function () {
            overid = $(this).attr("hoverid")
            $(".actions[hoverid=" + overid + "]").css("display", "flex");
        }).mouseout(function () {
            $(".actions").css("display", "none");
        });
        $('.g2-entries').append(employeeEntry);
        tippy('.wehat-buisiness', {
            theme: 'nopixel',
            inertia: true,
        })
    }
}

$(".groupsContainer-m, .g2-entries").on('mouseover', '.component-paper', function (e) {
    e.preventDefault();
    overid = $(this).attr("hoverid")
    $(".actions[hoverid=" + overid + "]").css("display", "flex");
}).mouseout(function () {
    $(".actions").css("display", "none");
});

$('.gm2-save3').click(function(){
    $('.option-main').show()
});

function addAccessLogs(item){
    let element = `<div hoverid="${item.cid}" class="component-logs cappacaha" style="right: -5%;">
    <div class="main-container">
    <div class="image">
        <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="users"
            class="svg-inline--fa fa-users fa-w-18 fa-fw fa-3x " role="img"
            xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
            <path fill="currentColor"
            d="M319.9 320c57.41 0 103.1-46.56 103.1-104c0-57.44-46.54-104-103.1-104c-57.41 0-103.1 46.56-103.1 104C215.9 273.4 262.5 320 319.9 320zM369.9 352H270.1C191.6 352 128 411.7 128 485.3C128 500.1 140.7 512 156.4 512h327.2C499.3 512 512 500.1 512 485.3C512 411.7 448.4 352 369.9 352zM512 160c44.18 0 80-35.82 80-80S556.2 0 512 0c-44.18 0-80 35.82-80 80S467.8 160 512 160zM183.9 216c0-5.449 .9824-10.63 1.609-15.91C174.6 194.1 162.6 192 149.9 192H88.08C39.44 192 0 233.8 0 285.3C0 295.6 7.887 304 17.62 304h199.5C196.7 280.2 183.9 249.7 183.9 216zM128 160c44.18 0 80-35.82 80-80S172.2 0 128 0C83.82 0 48 35.82 48 80S83.82 160 128 160zM551.9 192h-61.84c-12.8 0-24.88 3.037-35.86 8.24C454.8 205.5 455.8 210.6 455.8 216c0 33.71-12.78 64.21-33.16 88h199.7C632.1 304 640 295.6 640 285.3C640 233.8 600.6 192 551.9 192z">
            </path>
        </svg>
    </div>
    <div class="details">
        <div class="title ">
            <p class="MuiTypography-root MuiTypography-bodyBusiness MuiTypography-colorTextPrimary"
            id = ""><b>${item.information}</b> <br>${item.infoAction} <br><b>${item.information2}</b></p>
        </div>
        <div class="description ">
            <p class="MuiTypography-root MuiTypography-bodyBusiness MuiTypography-colorTextPrimary ap-street"
                style="word-break: break-word;"><br><b><em>${item.daysAgo}</em></b></p>
        </div>
       </div>
      </div>
     </div>`
    $('.bussiness-log-entries').append(element)
     
}

$('.btn-hire').click(function(){
    $('.option-main').fadeOut()
    $('.group-manage-rank-here').css('display', 'flex');
})
$('.g2-entries').on('click', '.btn-set-rank', function(e){
    // $('#confirm-modal-accept').data('name', $(this).data('name'));
    // console.log('RANK',$(this).data('cid'),$(this).data('rank'))
    $('#user-rank-s').val($(this).data('rank'))
    $('#state_id-s').val($(this).data('cid'))
    $('.group-manage-rank-set-here').css('display', 'flex');
});

$('.g2-entries').on('click', '.btn-set-paycheck', function(e){
    $('#state_id-p').val($(this).data('cid'))
    $(".group-manage-paycheck").css('display', 'flex');
});

$('.g2-entries').on('click', '.btn-set-remove', function(e){
    $('#fire-id-e').val($(this).data('cid'))
    $('#fireform, .fireform').css('display', 'flex');
});

$('.g2-entries').on('click', '.btn-bank-access', function(e){
    //soon
})

$('.gobackBusiness').click(function(){
    openContainer('bussiness')
})

$(".gobackBusinessLogs").click(function(){
    var business_id = $("#business-id").val();
    $.post('http://fa-phone/manageGroup', JSON.stringify({
        GroupID: business_id
    }));
})

$('.group-manage-fire-reject').click(function(e){
    $('.fireform').fadeOut()
});

$('#group-manage-fire-accept').click(function(e){
    var business_id = $("#business-id-f").val();
    var state_id = $("#fire-id-e").val();
    complateInput();
    // console.log("SUBMIT SHIT",business_id,state_id)
    setTimeout(() => {
        $.post('http://fa-phone/fireEmployee', JSON.stringify({
            business: business_id,
            state_id: state_id
        }));
        $("#business-id-f").val(" ")
        $("#fire-id-e").val("0")
        setTimeout(() => {
            $.post('http://fa-phone/manageGroup', JSON.stringify({
                GroupID: business_id
            }));
        }, 1000);
    }, 1000);
    $('.fireform').fadeOut()
});

$(".group-submit-hire-rank").click(function (e) {
    // manageGroup
    e.preventDefault();
    var business_id = $("#business-id").val();
    var rank = document.getElementById("penisinbuttholebung").innerHTML
    var state_id = $("#grouphirestateid").val();
    console.log(rank)
    complateInput();
    setTimeout(() => {
        $.post('http://fa-phone/addEmployee', JSON.stringify({
            business: business_id,
            rank: rank,
            state_id: state_id
        }));
        $("#user-rank").val("0")
        $("#state_id").val("")
        setTimeout(() => {
            $.post('http://fa-phone/manageGroup', JSON.stringify({
                GroupID: business_id
            }));
        }, 1000);
    }, 1000);
   
    $('.group-manage-rank-here').fadeOut()
});

$(".group-close-hire-rank").click(function (e) {
    $('.group-manage-rank-here').fadeOut()
});

$("#rankSet-submit-input").click(function (e) {
    // manageGroup
    e.preventDefault();
    var business_id = $("#business-id").val();
    let rank = document.getElementById("penisinbuttholebung3").innerHTML
    var state_id = $("#state_id-s").val();
    // console.log("EDIT RANKS",business_id,rank,state_id)
    complateInput();
    // console.log("SUBMIT SHIT")
    setTimeout(() => {
        $.post('http://fa-phone/editEmployee', JSON.stringify({
            business: business_id,
            rank: rank,
            state_id: state_id
        }));
        $("#user-rank").val("0")
        $("#state_id").val("")
        setTimeout(() => {
            $.post('http://fa-phone/manageGroup', JSON.stringify({
                GroupID: business_id
            }));
        }, 1000);
    }, 1000);
   
    $('.group-manage-rank-set-here').fadeOut()
});

$(".btn-d-refresh").click(function(e){
    bId = $(this).attr("bIdRef")
    setTimeout(() => {
        $.post('http://fa-phone/manageGroup', JSON.stringify({
            GroupID: bId
        }));
    }, 1000);
    $('.option-main').fadeOut()
})

$(".btn-d-paycheck-1").click(function(e){
    $('.option-main').fadeOut()
    $('.payexternal').css('display', 'flex');
})

$(".payexternal-close").click(function(e) {
    $(".payexternal").fadeOut()
})

$(".payexternal-submit").click(function(e) {
    $(".payexternal").fadeOut()
    var stateid = $(".payexternal-state-id").val();
    var amt = $(".payexternal-amount").val();
    var business_id = $("#business-id").val();
    complateInput();
    setTimeout(() => {
        $.post('http://fa-phone/payExternal', JSON.stringify({
            pStateId: stateid,
            pAmount: amt,
            pBusinessID: business_id
        }))
    }, 1000)
})

$(".btn-d-create-role").click(function(e){
    $('.option-main').fadeOut()
    $('.group-create-role-here').css('display', 'flex');
})

$(".create-rank-close-input").click(function(e) {
    $('.group-create-role-here').fadeOut()
})

$(".create-rank-submit-input").click(function(e) {
    $('.group-create-role-here').fadeOut()
    var createdRoleInput = $('.groupCreateRole-input').val();
    var business_id = $("#business-id").val();
    let hire = $("#hireCheckbox").is(":checked");
    let fire = $("#fireCheckbox").is(":checked");
    let changeRoles = $("#changeRoleCheckbox").is(":checked");
    let keys = $("#propertyKeysCheckbox").is(":checked");
    let stash = $("#stashAccessCheckbox").is(":checked");
    let craft = $("#craftAccessCheckbox").is(":checked");
    let charge = $("#chargeExternalCheckbox").is(":checked");
    let bank = $("#bankAccessCheckbox").is(":checked");
    let logs = $("#logsAccessCheckbox").is(":checked");

    complateInput();
    setTimeout(() => {
        $.post('http://fa-phone/createBusinessRole', JSON.stringify({
            pBusinessId: business_id, 
            pRoleName: createdRoleInput, 
            pPermHire: hire, 
            pPermFire: fire, 
            pPermChangeRoles: changeRoles, 
            pPermKeys: keys, 
            pPermStash: stash, 
            pPermCraft: craft, 
            pPermCharge: charge, 
            pPermBank: bank,
            pPermLogs: logs

        }))
        setTimeout(() => {
            $.post('http://fa-phone/manageGroup', JSON.stringify({
                GroupID: business_id
            }));
        }, 1000);
    }, 1000);
})

$(".btn-d-edit-role").click(function(e){
    $('.option-main').fadeOut();
    $('.group-edit-role-here').css('display','flex');
})

$(".edit-rank-close-input").click(function(e) {
    $('.group-edit-role-here').fadeOut()
})

$(".edit-rank-submit-input").click(function(e) {
    var business_id = $("#business-id").val();
    let rolename = document.getElementById("penisinbuttholebung1").innerHTML
    let currole = $("#business-current-role").val();
    let hire = $("#hireCheckbox1").is(":checked");
    let fire = $("#fireCheckbox2").is(":checked");
    let changeRoles = $("#changeRoleCheckbox3").is(":checked");
    let keys = $("#propertyKeysCheckbox7").is(":checked");
    let stash = $("#stashAccessCheckbox8").is(":checked");
    let craft = $("#craftAccessCheckbox9").is(":checked");
    let charge = $("#chargeExternalCheckbox6").is(":checked");
    let bank = $("#bankAccessCheckbox10").is(":checked");
    let logs = $("#logsAccessCheckbox11").is(":checked");

    $('.group-edit-role-here').fadeOut()
    complateInput();
    setTimeout(() => {
        $.post('http://fa-phone/editBusinessRole', JSON.stringify({
            pBusinessId:      business_id, 
            pCurRole:         currole, 
            pRoleName:        rolename, 
            pPermFire:        fire, 
            pPermHire:        hire, 
            pPermChangeRoles: changeRoles, 
            pPermKeys:        keys, 
            pPermStash:       stash, 
            pPermCraft:       craft, 
            pPermCharge:      charge, 
            pPermBank:        bank,
            pPermLogs:        logs
        }))
        setTimeout(() => {
            $.post('http://fa-phone/manageGroup', JSON.stringify({
                GroupID: business_id
            }));
        }, 1000);
    }, 1000);
})

$(".btn-d-delete-role").click(function(e){
    $('.option-main').fadeOut()
    $('.group-delete-role-here').css('display','flex');
})

$(".delete-rank-close-input").click(function(e) {
    $('.group-delete-role-here').fadeOut()
})

$(".delete-rank-submit-input").click(function(e) {
    $('.group-delete-role-here').fadeOut()
    let rolename = document.getElementById("penisinbuttholebung2").innerHTML
    var business_id = $("#business-id").val();
    complateInput();
    setTimeout(() => {
        $.post('http://fa-phone/deleteRole', JSON.stringify({
            pBusinessID: business_id,
            pRole: rolename
        }))
        setTimeout(() => {
            $.post('http://fa-phone/manageGroup', JSON.stringify({
                GroupID: business_id
            }));
        }, 1000);
    }, 1000);
})

$(".btn-d-logs").click(function(e){
    $('.option-main').fadeOut()
    var business_id = $("#business-id").val();
    $.post('http://fa-phone/openBusinessLogs', JSON.stringify({
        business: business_id
    }))
})

$("#paycheck-submit-input").click(function (e) {
    // manageGroup
    e.preventDefault();
    var business_id = $("#business-id").val();
    var amount = $("#paycheck-amount").val();
    var state_id = $("#state_id-p").val();
    // console.log(business_id,amount,state_id)
    complateInput();
    // console.log("SUBMIT SHIT")
    setTimeout(() => {
        $.post('http://fa-phone/payCheckEmployee', JSON.stringify({
            business: business_id,
            amount: amount,
            state_id: state_id
        }));
        $("#user-rank").val("0")
        $("#state_id").val("")
        setTimeout(() => {
            $.post('http://fa-phone/manageGroup', JSON.stringify({
                GroupID: business_id
            }));
        }, 1000);
    }, 1000);
   
    $('.group-manage-paycheck').fadeOut()
});

$("#paycheck-submit-input-1").click(function (e) {
    // manageGroup
    e.preventDefault();
    var business_id = $("#business-id").val();
    var amount = $("#paycheck-amount-1").val();
    var state_id = $("#state_id-p-1").val();
    // console.log(business_id,amount,state_id)
    complateInput();
    setTimeout(() => {
        $.post('http://fa-phone/payCheckEmployee', JSON.stringify({
            business: business_id,
            amount: amount,
            state_id: state_id
        }));
        $("#user-rank").val("0")
        $("#state_id").val("")
        setTimeout(() => {
            $.post('http://fa-phone/manageGroup', JSON.stringify({
                GroupID: business_id
            }));
        }, 1000);
    }, 1000);
   
    $('.group-manage-paycheck-1').fadeOut()
});

$('.btn-add-cashB').click(function(e){
    // console.log("ADD CASH TO BANK",globalGroup)
    $('#bussiness-id-add-cash').val(globalGroup)
    $('.group-manage-add-cash').show()
    $('.option-main').fadeOut()
});


$('#add-cash-close-input').click(function(e){
    $('.group-manage-add-cash').fadeOut()
});

$('.btn-chck-cashB').click(function(e){
    $('.option-main').fadeOut()
    $('#bank-acct').empty()
    // console.log("ADD CASH TO BANK",globalGroup)
    $('#bank-txt').css('display', 'block')
    $('#bank-acct').css('display', 'block')
    $('#bank-acct').append('<b>'+globalBank.toLocaleString('en-US', { style: 'currency', currency: 'USD' })+'</b>')
    setTimeout(() => {
        $('#bank-txt').css('display', 'none')
        $('#bank-acct').css('display', 'none')
        $('#bank-acct').empty()
    }, 5000);
});

$("#add-cash-submit-input").click(function(e){
    let bId = $('#bussiness-id-add-cash').val()
    let amount = $('#add-cash-b-amount').val()
    $('.group-manage-add-cash').fadeOut()
    complateInput();
    $.post('http://fa-phone/addCashBank', JSON.stringify({
            bid: bId,
            amount: amount,
    }));
    setTimeout(() => {
        $('#bussiness-id-add-cash').val("")
        $('#add-cash-b-amount').val("")
        $.post('http://fa-phone/manageGroup', JSON.stringify({
        GroupID: bId
        }));
    }, 1000);
});

$('#paycheck-close-input-1').click(function(){
    $('.group-manage-paycheck-1').fadeOut()
    $('#group-manage-paycheck-1').fadeOut()
});

$('.btn-charge').click(function(){
    $('.option-main').fadeOut()
    $('.chargecustomer').css('display', 'flex');
})

$(".groupbill-close-bank").click(function(e) {
    $(".chargecustomer").fadeOut()
})

$(".groupbill-submit").click(function(e) {
    $(".chargecustomer").fadeOut()
    complateInput();
    var stateID = $('.groupbank-transfer-no').val();
    var comment = $('.groupbank-transfer-comment').val();
    var business_id = $("#business-id").val();
    var amount = $("#chargecustomeramountgiven").val();
    console.log(stateID, comment,business_id, amount)
    $.post('http://fa-phone/chargeCustomer', JSON.stringify({
        GroupID: business_id,
        stateID: stateID,
        amount: amount,
        reason: comment,
    }));
})