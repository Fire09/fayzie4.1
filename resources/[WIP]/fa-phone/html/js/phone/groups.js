// PlayerManager.group = {
//     Job: currentJob,
//     hasJobVehicle: true,
//     inZone: "Mission row",
//     lastVehicle: null,
//     task: 1,
//     group_id: -1
// }

getJobZone = () => {
    const fakeZones = ["Alta St", "Alta St", "Alta St"]
    return fakeZones[Math.round(Math.random())]
}


task = {
    zone: "",
    current: 0,
    goal: 0,
}

taskGenZone = () => {
    const oldZone = task.zone
    task.zone = getJobZone()
    //If old zone same als the new one REGEN !
    if (oldZone === task.zone)
        task.zone = getJobZone()
}

taskGenNew = () => {

    //TODO add generation of the zone in .lua

    //We are on our first task so generate one
    if (task.current === 0 && task.goal === 0) {
        taskGenZone()
        task.current = 0
        task.goal = 15
    }

    // We arent done yet
    if (task.current < task.goal)
        return

    //We completed out task !
    if (task.current === task.goal) {
        //Todo add random on goal ?
        taskGenZone()
        task.goal = 15
        task.current = 0
    }


}

taskSendUpdate = (tsk) => {
    $.post("https://fa-phone/taskGroupUpdate", JSON.stringify({
        gtask: tsk,
        gid: PlayerManager.group.group_id
    }))
}


function addIdleGroup(IdleGroup) {
    let counts = 0
    $(".idle-g-entries").empty()

    IdleGroup.forEach(grp => {
        const gGroup = grp.members
        // console.log(gGroup, gGroup.length)
        let length = gGroup.length
        let element = `
        <div class="sanitation-group" style=" margin-top: 15px;">
        <i gId="${grp.id}" members="${gGroup}" class="fa-solid fa-right-to-bracket g-join" aria-label="Join" style="color: #f0eeec; margin-bottom: -15px; left: 15px; font-size: 15px;"></i>
        <i class="fas fa-users-slash" style="color: #f0eeec; margin-bottom: -15px; left: 15px; font-size: 15px;"></i>
        <span style="color: white; margin-left: 10px; margin-top: -3px; width: 169px; font-size: 15px;">${grp.name}</span>
        <span style="color: #f0eeec; right: -75px; margin-top: 25px; width: 169px; font-size: 15px; position: absolute;"><i class="fas fa-people-arrow-left" style="font-size: 1rem; margin-right: 0.5px;"> ${length}</i></span>
        <span style="color: #f0eeec; right: -115px; margin-top: 25px; width: 169px; font-size: 15px; position: absolute;"><i class="fas fa-user" style="font-size: 1rem; margin-right: 1.5px;"> ${length}</i></span>
    </div>
    `
        $('.idle-g-entries').append(element);

    })
    $('.g-join').click(function () {
        gid = $(this).attr("gId")
        members = $(this).attr("members")
        $.post("https://fa-phone/j_group", JSON.stringify({
            gId: gid,
            members: members
        }))
        PlayerManager.group.group_id = gid

    })
}

function addBusyGroups(group) {
    let counts = 0
    $(".busy-g-entries").empty()

    group.forEach(grp => {
        const gGroup = grp.members
        let length = gGroup.length
        let element = `
        <div class="sanitation-group" style=" margin-top: 15px;">
        <i class="fas fa-users-slash" style="color: #f0eeec; margin-bottom: -15px; left: 15px; font-size: 15px;"></i>
        <span style="color: white; margin-left: 10px; margin-top: -3px; width: 169px; font-size: 15px;">${grp.name}</span>
        <span style="color: #f0eeec; right: -75px; margin-top: 25px; width: 169px; font-size: 15px; position: absolute;"><i class="fas fa-people-arrow-left" style="font-size: 1rem; margin-right: 0.5px;"> ${length}</i></span>
        <span style="color: #f0eeec; right: -115px; margin-top: 25px; width: 169px; font-size: 15px; position: absolute;"><i class="fas fa-user" style="font-size: 1rem; margin-right: 1.5px;"> ${length}</i></span>
    </div>
    `
        $('.busy-g-entries').append(element);

    })
}



function addGroupLeader(leaders, stat) {
    $(".groupLeader-entries").empty()
    if (stat === 0) {
        $('#not-ready').attr("gId", leaders.id)
        $('#b-g-ready').attr("gId", leaders.id)
        $('#g-disband').attr("gId", leaders.id)
        let gleader = ` <ul class="row collapsible groupLeader-entries">
            <div class="groupLeader-group" style="font-size:10px; margin-top: 5px;">
                <span class="g-dot" style="left: 16vw; margin-top: -9px;"></span>
                <i class="fas fa-user-graduate" style="margin-top: -7px; margin-left: 5px;"></i>
                <span class="group-leader" gid="${leaders.id}" style="color: white; margin-top: -10px; width: 169px; font-size: 15px;">${leaders.name}</span>
            </div>
        </ul>`
        $('.groupLeader-entries').append(gleader);
    } else {
        $('#not-ready').attr("gId", leaders.id)
        $('#b-g-ready').attr("gId", leaders.id)
        let gleader = ` <ul class="row collapsible groupLeader-entries">
        <div class="groupLeader-group" style="font-size:10px; margin-top: 5px;">
            <span class="g-dot" style="left: 16vw; margin-top: -9px;"></span>
            <i class="fas fa-user-graduate" style="margin-top: -7px; margin-left: 5px;"></i>
            <span class="group-leader" gid="${leaders.id}" style="color: white; margin-top: -10px; width: 169px; font-size: 15px;">${leaders.name}</span>
        </div>
    </ul>`
        $('.groupLeader-entries').append(gleader);
        $('.b-g-ready').css('display', 'flex')
        $('.g-disband').css('display', 'flex')
    }

}


function addGroupMembers(group, src) {
    $('#not-ready').attr("gId", group.gid)
    $('#b-g-ready').attr("gId", group.gid)
    $('#g-disband').attr("gId", group.gid)
    
    if (src == group.src) {
        $('.b-g-ready').css('display', 'none')
        $('.g-disband').css('display', 'flex')
        $(".g-disband").text("Leave Group")
    }

    let members = ` <ul class="row collapsible groupMembers-entries">
                        <div class="groupLeader-group" style="font-size:10px; margin-top: 5px;">
                            <span class="g-dot" style="left: 16vw; margin-top: -9px;"></span>
                            <i class="fas fa-user" style="margin-top: -7px; margin-left: 5px;"></i>
                            <span style="color: white; margin-top: -10px; width: 169px; font-size: 15px;">${group.name}</span>
                        </div>
                    </ul>`
    $('.groupLeader-entries-wrapper').append(members);

}
let ready = 0
$('.b-g-ready').click(function () {
    let gId = $(this).attr("gid")
    if (ready == 0) {
        ready = 1
        $(".sonar-wrapper").css('display', 'block')
        $(".b-g-ready").text("Not Ready for jobs")
        $.post("https://fa-phone/JobReady", JSON.stringify({
            status: true,
            gId: gId
        }))
    } else {
        ready = 0
        $(".sonar-wrapper").css('display', 'none')
        $(".b-g-ready").text("Ready for jobs")
        $.post("https://fa-phone/JobReady", JSON.stringify({
            status: false,
            gId: gId
        }))
    }
    PlayerManager.group.group_id = gId
})

$('#create-Group').click(function () {
    $.post("https://fa-phone/c_group", JSON.stringify({}))
    complateInputQuick();
    setTimeout(() => {
        // $.post("https://fa-phone/btnDebt", JSON.stringify({}))
        openContainer("groupLeader")
    }, 2000);
})

$('.g-disband').click(function () {
    let gId = $(this).attr("gid")
    $.post("https://fa-phone/leave_group", JSON.stringify({
        gid: gId
    }))
    complateInputQuick();
    setTimeout(() => {
        // $.post("https://fa-phone/btnDebt", JSON.stringify({}))
        openContainer("sanitation")
    }, 2000);
})


window.onload = function () {
    if (ready == 0) {
        $(".not-ready").css('display', 'none')
    }
};