var racesMap = {};
var mapsRace = {};
var penRace = {};
var playerIds = 0;
var typeRace = ""

$('.racetrack-wrapper').on('click', '.create-race-button', function(){
   trackID = $(this).attr("trackerID")
   type = $(this).attr("type")
   trackName = $(this).attr("trackerName")
   console.log('ALAHAHAHA',type);
   if (type == "Lap") {
      $("#laps").val("0");
      $("#laps").prop("disabled", false)
  } else {
      $(".creating-race, #laps").val("0");
      $("#laps").prop("disabled", true)
  }
   $('#event_name').val("")
   $('#bet').val("")
   $('#countdown').val("0")
   $('#dnf-pos').val("0")
   $('#dnf-countdown').val("0")
   $('#alias').val(racingAlias)
   $('#track-id').val(trackID)
   $('#track_name').val(trackName)
   $('.creating-race').show()
})

$("#race-p").click(function () {
   const pendingRaces = $('.pending-entries')
   const activeRaces = $('.actve-entries')
   const completeRaces = $('.complete-entries')
     if(pendingRaces.parent().has('.component-paper').length < 1){
        $('.pPending').css('display', 'none')
     }else if(pendingRaces.parent().has('.component-paper').length > 0){

        $('.pPending').show()
     }
     
     if(activeRaces.parent().has('.component-paper').length < 1){
        $('.aPending').css('display', 'none')
     }else if(activeRaces.parent().has('.component-paper').length > 0){

        $('.aPending').show()
     }
     if(completeRaces.parent().has('.component-paper').length < 1){
      $('.cPending').css('display', 'none')
      }else if(completeRaces.parent().has('.component-paper').length > 0){

         $('.cPending').show()
      }
   $("#pending-race").show();
   $("#create-race").hide();
   $('#leaderboard-race').hide();
   $('#h-current').css('display', 'none');
   $('#house-check').css('display', 'none');
   $('#apartment_room_number_hs-2').css('display', 'none');
   $('.h-owned').css('display', 'none');
   $('.house-entries').css('display', 'none');
   $('.access').css('display', 'none');
   $(".jss2907").css("left", (0));
   $("#race-p").css("color", "#95ef77");
   $("#cr-p").css("color", "rgba(255, 255, 255, 0.7)");
   $("#ch-p").css("color", "rgba(255, 255, 255, 0.7)");
   $('.b-lapt-times').css('display', 'none');
   $('.map-name').css('display', 'none');
   $('.map-leaderboard').css('display', 'none');
});


$("#cr-p").click(function () {
   const pendingRaces = $('.pending-entries')
     if(pendingRaces.parent().has('.component-paper').length < 1){
        $('.cPending').css('display', 'none')
     }else if(pendingRaces.parent().has('.component-paper').length > 0){
        $('.cPending').show()
     }
   $("#pending-race").hide();
   $("#create-race").show();
   $(".btn-2").show();
   $(".btn-2-house").show();
   $('#house-check').css('display', 'block');
   $('#apartment_room_number_hs-2').css('display', 'block');
   $('.house-entries').css('display', 'block');
   $('.access').css('display', 'block');
   $(".edit-h").show();
   $(".edit-h").css('display', 'flex');
   $(".edit-h").css('display', 'flex');
   $('.h-current').css('display', 'block');
   $(".jss2907").css("left", ("25%"));
   $("#cr-p").css("color", "#95ef77");
   $("#ch-p").css("color", "rgba(255, 255, 255, 0.7)");
   $("#race-p").css("color", "rgba(255, 255, 255, 0.7)");
   $('.b-lapt-times').css('display', 'none');
   $('.map-name').css('display', 'none');
   $('.map-leaderboard').css('display', 'none');
});

$("#ch-p").click(function () {
   const pendingRaces = $('.pending-entries')
     if(pendingRaces.parent().has('.component-paper').length < 1){
        $('.cPending').css('display', 'none')
     }else if(pendingRaces.parent().has('.component-paper').length > 0){
        $('.cPending').show()
     }
   $("#pending-race").hide();
   $("#create-race").hide();
   $("#leaderboard-race").show();
   $(".btn-2").show();
   $(".btn-2-house").show();
   $('#house-check').css('display', 'block');
   $('#apartment_room_number_hs-2').css('display', 'block');
   $('.house-entries').css('display', 'block');
   $('.access').css('display', 'block');
   $(".edit-h").show();
   $(".edit-h").css('display', 'flex');
   $(".edit-h").css('display', 'flex');
   $('.h-current').css('display', 'block');
   $(".jss2907").css("left", ("50%"));
   $("#ch-p").css("color", "#95ef77");
   $("#race-p").css("color", "rgba(255, 255, 255, 0.7)");
   $("#cr-p").css("color", "rgba(255, 255, 255, 0.7)");
   $('.b-lapt-times').css('display', 'block');
   $('.map-name').css('display', 'block');
   $('.map-leaderboard').css('display', 'block');
});

$('.close-crace').click(function(){
    // console.log("CLICK TO CREATE RACE")
    $('.creating-race').hide()
})

$('.submit-crace').click(function(){
   let id = $('#track-id').val()
   let name = $('#track_name').val()
   let event_name = $('#event_name').val()
   let alias = $('#alias').val()
   let laps = $('#laps').val()
   let bet = $('#bet').val()
   let countdown = $('#countdown').val()
   let dnf_post = $('#dnf-pos').val()
   let dnf_countdown = $('#dnf-countdown').val()
   let reverse = $("#reverse-track").is(":checked");
   let bubble = $("#bubble-remove").is(":checked");
    // console.log("SUBMIT CREATE RACE", id, name, event_name, alias, laps, bet, countdown, bubble,reverse,JSON.stringify(moment.utc().add(countdown, 'seconds')))
    $.post("https://fa-phone/racing:event:start", JSON.stringify({
      id: id,
      eventName: event_name,
      laps: laps,
      buyIn: bet,
      countdown: countdown,
      startTime: moment.utc().add(countdown, "seconds"),
      dnfPosition: dnf_post,
      dnfCountdown: dnf_countdown,
      reverse: reverse,
      bubble: bubble
  }));
    $('.creating-race').hide()
})

$('#create-r-map').click(function(){
   $('.add-race-track').css('display', 'flex')
})

$('.r-cancel').click(function(){
   $('.add-race-track').hide()
  
})

$('.race-t-submit').click(function(){
   var rName = document.getElementById("r-name").value;
   $('.add-race-track').hide()
   complateInputQuick();
   setTimeout(() => {
      $.post("https://fa-phone/racing:map:save", JSON.stringify({
         name: escapeHtml(rName),
         type: typeRace,
     }));
     closePhoneShell()
   }, 500);
})

function SetRacingTypeSprint() {
   $(".racingType").empty()
   $(".racingType").append('Sprint');
   typeRace = "Point"
}

function SetRacingTypeLaps() {
   $(".racingType").empty()
   $(".racingType").append('Laps');
   typeRace = "Lap"
}

// $(".add-race-track").on('click', '.race-t-submit', function (e) {

//    console.log("SUBMIT HERE")
// }
// var e = document.getElementById("ddlViewBy");
// var strUser = e.value;

// $('.submit-crace').submit(function (e) {
//    e.preventDefault();
//    let reverseTrack = false;
//    if ($('#racing-reverse-track').is(":checked")) { reverseTrack = true };
//    // $.post('http://fa-phone/racing:event:start', JSON.stringify({
//    //     raceMap: $('#racing-start-tracks').val(),
//    //     raceLaps: $('#racing-start-laps').val(),
//    //     raceStartTime: moment.utc().add($('#racing-start-time').val(), 'seconds'),
//    //     reverseTrack: reverseTrack,
//    //     raceCountdown: $('#racing-start-time').val(),
//    //     raceName: $('#racing-start-name').val(),
//    //     mapCreator: $('#racing-start-map-creator').text(),
//    //     mapDistance: $('#racing-start-map-distance').text(),
//    //     mapDescription: $('#racing-start-description').text()
//    // }));
// });

function addRaceTracker(raceTrack,scid){
   const pendingRaces = $('.pending-entries')
   const activeRaces = $('.active-entries')
   const completeRaces = $('.complete-entries')
//    console.log("PENDING ENTRIES",pendingRaces.parent().has('.component-paper').length)
   if(pendingRaces.parent().has('.component-paper').length > 0){
      $('.pPending').show()
   }else if(activeRaces.parent().has('.component-paper').length > 0){
      $('.aPending').show()
   }else if(completeRaces.parent().has('.component-paper').length > 0){
      $('.cPending').show()
   }
      mapsRace = raceTrack
    races = raceTrack.races;
   for (let race in races){
      var random = Math.floor(Math.random() * 10000) + 1;
            let raced = race
            let miles = (races[race].distance*0.00014).toFixed(2)
   //      let tracks = `<div hoverid="${random}" class="component-paper" style="width: 100%;" id="trackPaper">
   //                   <div class="main-container clicked-function-container">
   //                      <div class="details ">
   //                         <div class="title ">
   //                            <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
   //                            style="word-break: break-word;">${races[race].name}</p>
   //                         </div>
   //                         <div class="description ">
   //                            <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
   //                            style="word-break: break-word;">Laps</p>
   //                         </div>
   //                      </div>
   //                      <div class="details-aux " style="padding-top: 10px;">
   //                         <div class="text">
   //                            <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
   //                            style="word-break: break-word;">${miles}mi</p>
   //                         </div>
   //                      </div>
   //                      <div hoverid="${random}" class="actions actions-show">
   //                         <div data-tippy-content="Delete" class="">
   //                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
   //                               class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
   //                               xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
   //                               <path fill="currentColor"
   //                                  d="M135.2 17.69C140.6 6.848 151.7 0 163.8 0H284.2C296.3 0 307.4 6.848 312.8 17.69L320 32H416C433.7 32 448 46.33 448 64C448 81.67 433.7 96 416 96H32C14.33 96 0 81.67 0 64C0 46.33 14.33 32 32 32H128L135.2 17.69zM31.1 128H416V448C416 483.3 387.3 512 352 512H95.1C60.65 512 31.1 483.3 31.1 448V128zM111.1 208V432C111.1 440.8 119.2 448 127.1 448C136.8 448 143.1 440.8 143.1 432V208C143.1 199.2 136.8 192 127.1 192C119.2 192 111.1 199.2 111.1 208zM207.1 208V432C207.1 440.8 215.2 448 223.1 448C232.8 448 240 440.8 240 432V208C240 199.2 232.8 192 223.1 192C215.2 192 207.1 199.2 207.1 208zM304 208V432C304 440.8 311.2 448 320 448C328.8 448 336 440.8 336 432V208C336 199.2 328.8 192 320 192C311.2 192 304 199.2 304 208z">
   //                               </path>
   //                            </svg>
   //                         </div>
   //                         <div data-tippy-content="Leaderboard" class="">
   //                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
   //                               class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
   //                               xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
   //                               <path fill="currentColor"
   //                                  d="M572.1 82.38C569.5 71.59 559.8 64 548.7 64h-100.8c.2422-12.45 .1078-23.7-.1559-33.02C447.3 13.63 433.2 0 415.8 0H160.2C142.8 0 128.7 13.63 128.2 30.98C127.1 40.3 127.8 51.55 128.1 64H27.26C16.16 64 6.537 71.59 3.912 82.38C3.1 85.78-15.71 167.2 37.07 245.9c37.44 55.82 100.6 95.03 187.5 117.4c18.7 4.805 31.41 22.06 31.41 41.37C256 428.5 236.5 448 212.6 448H208c-26.51 0-47.99 21.49-47.99 48c0 8.836 7.163 16 15.1 16h223.1c8.836 0 15.1-7.164 15.1-16c0-26.51-21.48-48-47.99-48h-4.644c-23.86 0-43.36-19.5-43.36-43.35c0-19.31 12.71-36.57 31.41-41.37c86.96-22.34 150.1-61.55 187.5-117.4C591.7 167.2 572.9 85.78 572.1 82.38zM77.41 219.8C49.47 178.6 47.01 135.7 48.38 112h80.39c5.359 59.62 20.35 131.1 57.67 189.1C137.4 281.6 100.9 254.4 77.41 219.8zM498.6 219.8c-23.44 34.6-59.94 61.75-109 81.22C426.9 243.1 441.9 171.6 447.2 112h80.39C528.1 135.7 526.5 178.7 498.6 219.8z">
   //                               </path>
   //                            </svg>
   //                         </div>
   //                         <div data-tippy-content="Preview" class="rPreview" mID="${race}">
   //                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
   //                               class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
   //                               xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
   //                               <path fill="currentColor"
   //                                  d="M279.6 160.4C282.4 160.1 285.2 160 288 160C341 160 384 202.1 384 256C384 309 341 352 288 352C234.1 352 192 309 192 256C192 253.2 192.1 250.4 192.4 247.6C201.7 252.1 212.5 256 224 256C259.3 256 288 227.3 288 192C288 180.5 284.1 169.7 279.6 160.4zM480.6 112.6C527.4 156 558.7 207.1 573.5 243.7C576.8 251.6 576.8 260.4 573.5 268.3C558.7 304 527.4 355.1 480.6 399.4C433.5 443.2 368.8 480 288 480C207.2 480 142.5 443.2 95.42 399.4C48.62 355.1 17.34 304 2.461 268.3C-.8205 260.4-.8205 251.6 2.461 243.7C17.34 207.1 48.62 156 95.42 112.6C142.5 68.84 207.2 32 288 32C368.8 32 433.5 68.84 480.6 112.6V112.6zM288 112C208.5 112 144 176.5 144 256C144 335.5 208.5 400 288 400C367.5 400 432 335.5 432 256C432 176.5 367.5 112 288 112z">
   //                               </path>
   //                            </svg>
   //                         </div>
   //                         <div data-tippy-content="Set GPS" class="pGPS" mID="${race}">
   //                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
   //                               class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
   //                               xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
   //                               <path fill="currentColor"
   //                                  d="M384 192C384 279.4 267 435 215.7 499.2C203.4 514.5 180.6 514.5 168.3 499.2C116.1 435 0 279.4 0 192C0 85.96 85.96 0 192 0C298 0 384 85.96 384 192H384z">
   //                               </path>
   //                            </svg>
   //                         </div>
   //                         <div data-tippy-content="Create Race" trackerID="${race}" type="${races[race].type}" trackerName="${races[race].name}" class="create-race-button">
   //                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
   //                               class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
   //                               xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
   //                               <path fill="currentColor"
   //                                  d="M509.5 .0234c-6.145 0-12.53 1.344-18.64 4.227c-44.11 20.86-76.81 27.94-104.1 27.94c-57.89 0-91.53-31.86-158.2-31.87C195 .3203 153.3 8.324 96 32.38V32c0-17.75-14.25-32-32-32S32 14.25 32 32L31.96 496c0 8.75 7.25 16 16 16H80C88.75 512 96 504.8 96 496V384c51.74-23.86 92.71-31.82 128.3-31.82c71.09 0 120.6 31.78 191.7 31.78c30.81 0 65.67-5.969 108.1-23.09C536.3 355.9 544 344.4 544 332.1V30.74C544 12.01 527.8 .0234 509.5 .0234zM480 141.8c-31.99 14.04-57.81 20.59-80 22.49v80.21c25.44-1.477 51.59-6.953 80-17.34V308.9c-22.83 7.441-43.93 11.08-64.03 11.08c-5.447 0-10.71-.4258-15.97-.8906V244.5c-4.436 .2578-8.893 .6523-13.29 .6523c-25.82 0-47.35-4.547-66.71-10.08v66.91c-23.81-6.055-50.17-11.41-80-12.98V213.1C236.2 213.7 232.5 213.3 228.5 213.3C208.8 213.3 185.1 217.7 160 225.1v69.1C139.2 299.4 117.9 305.8 96 314.4V250.7l24.77-10.39C134.8 234.5 147.6 229.9 160 225.1V143.4C140.9 148.5 120.1 155.2 96 165.3V101.8l24.77-10.39C134.8 85.52 147.6 80.97 160 77.02v66.41c26.39-6.953 49.09-10.17 68.48-10.16c4.072 0 7.676 .4453 11.52 .668V65.03C258.6 66.6 274.4 71.55 293.2 77.83C301.7 80.63 310.7 83.45 320 86.12v66.07c20.79 6.84 41.45 12.96 66.71 12.96c4.207 0 8.781-.4766 13.29-.8594V95.54c25.44-1.477 51.59-6.953 80-17.34V141.8zM240 133.9v80.04c18.61 1.57 34.37 6.523 53.23 12.8C301.7 229.6 310.7 232.4 320 235.1V152.2C296.1 144.3 271.6 135.8 240 133.9z">
   //                               </path>
   //                            </svg>
   //                         </div>
   //                      </div>
   //                   </div>
   //                </div>`

        
   //      $('.racetrack-wrapper').append(tracks)
   //      tippy('[data-tippy-content]', {
   //       theme: 'nopixel',
   //       inertia: true,
   //     })

   // }

   let tracks = `<div hoverid="${random}" class="component-paper" style="width: 100%;" id="trackPaper">
                     <div class="main-container clicked-function-container">
                        <div class="details ">
                           <div class="title ">
                              <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                              style="word-break: break-word;">${races[race].name}</p>
                           </div>
                           <div class="description ">
                              <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                              style="word-break: break-word;">Laps</p>
                           </div>
                        </div>
                        <div class="details-aux " style="padding-top: 10px;">
                           <div class="text">
                              <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                              style="word-break: break-word;">${miles}mi</p>
                           </div>
                        </div>
                        <div hoverid="${random}" class="actions actions-show">
                           <div data-tippy-content="Preview" class="rPreview" mID="${race}">
                              <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                                 class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                                 xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                 <path fill="currentColor"
                                    d="M279.6 160.4C282.4 160.1 285.2 160 288 160C341 160 384 202.1 384 256C384 309 341 352 288 352C234.1 352 192 309 192 256C192 253.2 192.1 250.4 192.4 247.6C201.7 252.1 212.5 256 224 256C259.3 256 288 227.3 288 192C288 180.5 284.1 169.7 279.6 160.4zM480.6 112.6C527.4 156 558.7 207.1 573.5 243.7C576.8 251.6 576.8 260.4 573.5 268.3C558.7 304 527.4 355.1 480.6 399.4C433.5 443.2 368.8 480 288 480C207.2 480 142.5 443.2 95.42 399.4C48.62 355.1 17.34 304 2.461 268.3C-.8205 260.4-.8205 251.6 2.461 243.7C17.34 207.1 48.62 156 95.42 112.6C142.5 68.84 207.2 32 288 32C368.8 32 433.5 68.84 480.6 112.6V112.6zM288 112C208.5 112 144 176.5 144 256C144 335.5 208.5 400 288 400C367.5 400 432 335.5 432 256C432 176.5 367.5 112 288 112z">
                                 </path>
                              </svg>
                           </div>
                           <div data-tippy-content="Set GPS" class="pGPS" mID="${race}">
                              <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                                 class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                                 xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                 <path fill="currentColor"
                                    d="M384 192C384 279.4 267 435 215.7 499.2C203.4 514.5 180.6 514.5 168.3 499.2C116.1 435 0 279.4 0 192C0 85.96 85.96 0 192 0C298 0 384 85.96 384 192H384z">
                                 </path>
                              </svg>
                           </div>
                           <div data-tippy-content="Create Race" trackerID="${race}" type="${races[race].type}" trackerName="${races[race].name}" class="create-race-button">
                              <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                                 class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                                 xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                                 <path fill="currentColor"
                                    d="M509.5 .0234c-6.145 0-12.53 1.344-18.64 4.227c-44.11 20.86-76.81 27.94-104.1 27.94c-57.89 0-91.53-31.86-158.2-31.87C195 .3203 153.3 8.324 96 32.38V32c0-17.75-14.25-32-32-32S32 14.25 32 32L31.96 496c0 8.75 7.25 16 16 16H80C88.75 512 96 504.8 96 496V384c51.74-23.86 92.71-31.82 128.3-31.82c71.09 0 120.6 31.78 191.7 31.78c30.81 0 65.67-5.969 108.1-23.09C536.3 355.9 544 344.4 544 332.1V30.74C544 12.01 527.8 .0234 509.5 .0234zM480 141.8c-31.99 14.04-57.81 20.59-80 22.49v80.21c25.44-1.477 51.59-6.953 80-17.34V308.9c-22.83 7.441-43.93 11.08-64.03 11.08c-5.447 0-10.71-.4258-15.97-.8906V244.5c-4.436 .2578-8.893 .6523-13.29 .6523c-25.82 0-47.35-4.547-66.71-10.08v66.91c-23.81-6.055-50.17-11.41-80-12.98V213.1C236.2 213.7 232.5 213.3 228.5 213.3C208.8 213.3 185.1 217.7 160 225.1v69.1C139.2 299.4 117.9 305.8 96 314.4V250.7l24.77-10.39C134.8 234.5 147.6 229.9 160 225.1V143.4C140.9 148.5 120.1 155.2 96 165.3V101.8l24.77-10.39C134.8 85.52 147.6 80.97 160 77.02v66.41c26.39-6.953 49.09-10.17 68.48-10.16c4.072 0 7.676 .4453 11.52 .668V65.03C258.6 66.6 274.4 71.55 293.2 77.83C301.7 80.63 310.7 83.45 320 86.12v66.07c20.79 6.84 41.45 12.96 66.71 12.96c4.207 0 8.781-.4766 13.29-.8594V95.54c25.44-1.477 51.59-6.953 80-17.34V141.8zM240 133.9v80.04c18.61 1.57 34.37 6.523 53.23 12.8C301.7 229.6 310.7 232.4 320 235.1V152.2C296.1 144.3 271.6 135.8 240 133.9z">
                                 </path>
                              </svg>
                           </div>
                        </div>
                     </div>
                  </div>`

        
        $('.racetrack-wrapper').append(tracks)
        tippy('[data-tippy-content]', {
         theme: 'nopixel',
         inertia: true,
       })

   }

		// if(pendingRaces.parent().has('.component-paper').length < 1){
      //    $('.cPending').css('display', 'none')
      // }else if(pendingRaces.parent().has('.component-paper').length > 0){
      //    console.log
      //    $('.cPending').show()
      // }

   $('.pGPS').click(function(){
      mID = $(this).attr("mID")

      $.post('http://fa-phone/fa-phone:racing:setGPS', JSON.stringify({
         mID: mID,
     }));
   })
   $('.rPreview').click(function(){
      mID = $(this).attr("mID")

      $.post('http://fa-phone/fa-phone:racing:seePreview', JSON.stringify({
         mID: mID,
     }));
   })
   $(".component-paper").mouseover(function () {
      overid = $(this).attr("hoverid")
      $(".actions[hoverid=" + overid + "]").css("display", "flex");
  }).mouseout(function () {
      $(".actions").css("display", "none");
  });
}


function pendingRace(races,sCID){
   let mouseInOver = false
   // console.log("PENDING RACE", JSON.stringify(races))
   const pendingRaces = $('.pending-entries')
   const activeRaces = $('.active-entries')
   const completeRaces = $('.complete-entries')
   penRace = races
//    console.log("PENDING ENTRIES",pendingRaces.parent().has('.component-paper').length)
   if(pendingRaces.parent().has('.component-paper').length > 0){
      $('.pPending').show()
   }else{
      $('.pPending').hide()
   }
   if(activeRaces.parent().has('.component-paper').length > 0){
      $('.aPending').show()
   }else{
      $('.aPending').hide()
   }
   if(completeRaces.parent().has('.component-paper').length > 0){
      $('.cPending').show()
   }else{
      $('.cPending').hide()
   }
   $('.pending-entries').empty()
   $('.active-entries').empty()
   $('.complete-entries').empty()
   for (let race in races) {
      
      var random = Math.floor(Math.random() * 10000) + 1;
      let miles = (races[race].mapDistance*0.00014).toFixed(2)
      var addRacer = []
      // console.log("RACE ID",races[race].id,races[race].owner,sCID,races[race].state)
      // console.log("RACE STATUS",races[race].state)
    //   console.log("RACERS",JSON.stringify(races[race].players))
    //   console.log("MAP ID",race,races[race].state)
      let pendingRace = `<div hoverid=${random} class="component-paper contract-count" eventID=${race}>
      <div class="main-container">
              
                  <div class="details ">
                  <div class="title ">
                     <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                     style="word-break: break-word;">${races[race].eventName}</p>
                  </div>
                  <div class="description ">
                     <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                     style="word-break: break-word;">${races[race].laps > 0 ? ("Laps" + "(" + races[race].laps + ")") : "Sprint"} / ${races[race].state}</p>
                  </div>
               </div>
               <div class="details-aux " style="padding-top: 20px;">
                  <div class="text">
                     <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                     style="word-break: break-word;">${miles}mi</p>
                  </div>
               </div>
              <div hoverid=${random} hoverid=${random} class="actions actions-show" style="display: none;">
                  <div data-tippy-content="Preview" class="pPreview" mID=${races[race].id}>
                      <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user-slash" class="svg-inline--fa fa-user-slash fa-w-20 fa-fw fa-lg " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512">
                          <path fill="currentColor"  d="M279.6 160.4C282.4 160.1 285.2 160 288 160C341 160 384 202.1 384 256C384 309 341 352 288 352C234.1 352 192 309 192 256C192 253.2 192.1 250.4 192.4 247.6C201.7 252.1 212.5 256 224 256C259.3 256 288 227.3 288 192C288 180.5 284.1 169.7 279.6 160.4zM480.6 112.6C527.4 156 558.7 207.1 573.5 243.7C576.8 251.6 576.8 260.4 573.5 268.3C558.7 304 527.4 355.1 480.6 399.4C433.5 443.2 368.8 480 288 480C207.2 480 142.5 443.2 95.42 399.4C48.62 355.1 17.34 304 2.461 268.3C-.8205 260.4-.8205 251.6 2.461 243.7C17.34 207.1 48.62 156 95.42 112.6C142.5 68.84 207.2 32 288 32C368.8 32 433.5 68.84 480.6 112.6V112.6zM288 112C208.5 112 144 176.5 144 256C144 335.5 208.5 400 288 400C367.5 400 432 335.5 432 256C432 176.5 367.5 112 288 112z">
                          </path>
                      </svg>
                  </div>
                  <div data-tippy-content="Set GPS" class="peGPS" mID=${races[race].id}>
                  <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                     class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                     xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                     <path fill="currentColor"
                        d="M384 192C384 279.4 267 435 215.7 499.2C203.4 514.5 180.6 514.5 168.3 499.2C116.1 435 0 279.4 0 192C0 85.96 85.96 0 192 0C298 0 384 85.96 384 192H384z">
                     </path>
                  </svg>
               </div>`
               let isRaceOwner = races[race].owner === sCID 
               playerIds = sCID
               let isInRace = inRace(race);
               if (isInRace == false && races[race].state == "open") {
                  pendingRace += `<div data-tippy-content="Join" class="pJoin" eventID=${races[race].id}>
                     <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                        class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                        xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                        <path fill="currentColor"
                           d="M224 256c70.7 0 128-57.31 128-128S294.7 0 224 0C153.3 0 96 57.31 96 128S153.3 256 224 256zM274.7 304H173.3C77.61 304 0 381.6 0 477.3C0 496.5 15.52 512 34.66 512h378.7C432.5 512 448 496.5 448 477.3C448 381.6 370.4 304 274.7 304zM616 200h-48v-48C568 138.8 557.3 128 544 128s-24 10.75-24 24v48h-48C458.8 200 448 210.8 448 224s10.75 24 24 24h48v48C520 309.3 530.8 320 544 320s24-10.75 24-24v-48h48C629.3 248 640 237.3 640 224S629.3 200 616 200z">
                        </path>
                     </svg>
                  </div>`
               }
               if(races[race].state != "close" && isInRace == true){
                  pendingRace += `<div data-tippy-content="Leave" class="pLeave" eventID=${races[race].id}>
                  <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                     class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                     xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                     <path fill="currentColor"
                        d="M96 480h64C177.7 480 192 465.7 192 448S177.7 416 160 416H96c-17.67 0-32-14.33-32-32V128c0-17.67 14.33-32 32-32h64C177.7 96 192 81.67 192 64S177.7 32 160 32H96C42.98 32 0 74.98 0 128v256C0 437 42.98 480 96 480zM504.8 238.5l-144.1-136c-6.975-6.578-17.2-8.375-26-4.594c-8.803 3.797-14.51 12.47-14.51 22.05l-.0918 72l-128-.001c-17.69 0-32.02 14.33-32.02 32v64c0 17.67 14.34 32 32.02 32l128 .001l.0918 71.1c0 9.578 5.707 18.25 14.51 22.05c8.803 3.781 19.03 1.984 26-4.594l144.1-136C514.4 264.4 514.4 247.6 504.8 238.5z">
                     </path>
                  </svg>
               </div>`
               }
               
               if (isRaceOwner && races[race].state != "close"){
                  pendingRace += `
                  <div data-tippy-content="Start Race" class="pStartRace">
                     <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                        class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                        xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                        <path fill="currentColor"
                           d="M256 0C114.6 0 0 114.6 0 256c0 141.4 114.6 256 256 256s256-114.6 256-256C512 114.6 397.4 0 256 0zM406.6 278.6l-103.1 103.1c-12.5 12.5-32.75 12.5-45.25 0s-12.5-32.75 0-45.25L306.8 288H128C110.3 288 96 273.7 96 256s14.31-32 32-32h178.8l-49.38-49.38c-12.5-12.5-12.5-32.75 0-45.25s32.75-12.5 45.25 0l103.1 103.1C414.6 241.3 416 251.1 416 256C416 260.9 414.6 270.7 406.6 278.6z">
                        </path>
                     </svg>
                  </div>
                  <div data-tippy-content="End Race" class="pEndRace">
                     <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marked"
                        class="svg-inline--fa fa-map-marked fa-w-18 fa-fw fa-lg " role="img"
                        xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512">
                        <path fill="currentColor"
                           d="M509.5 .0234c-6.145 0-12.53 1.344-18.64 4.227c-44.11 20.86-76.81 27.94-104.1 27.94c-57.89 0-91.53-31.86-158.2-31.87C195 .3203 153.3 8.324 96 32.38V32c0-17.75-14.25-32-32-32S32 14.25 32 32L31.96 496c0 8.75 7.25 16 16 16H80C88.75 512 96 504.8 96 496V384c51.74-23.86 92.71-31.82 128.3-31.82c71.09 0 120.6 31.78 191.7 31.78c30.81 0 65.67-5.969 108.1-23.09C536.3 355.9 544 344.4 544 332.1V30.74C544 12.01 527.8 .0234 509.5 .0234zM480 141.8c-31.99 14.04-57.81 20.59-80 22.49v80.21c25.44-1.477 51.59-6.953 80-17.34V308.9c-22.83 7.441-43.93 11.08-64.03 11.08c-5.447 0-10.71-.4258-15.97-.8906V244.5c-4.436 .2578-8.893 .6523-13.29 .6523c-25.82 0-47.35-4.547-66.71-10.08v66.91c-23.81-6.055-50.17-11.41-80-12.98V213.1C236.2 213.7 232.5 213.3 228.5 213.3C208.8 213.3 185.1 217.7 160 225.1v69.1C139.2 299.4 117.9 305.8 96 314.4V250.7l24.77-10.39C134.8 234.5 147.6 229.9 160 225.1V143.4C140.9 148.5 120.1 155.2 96 165.3V101.8l24.77-10.39C134.8 85.52 147.6 80.97 160 77.02v66.41c26.39-6.953 49.09-10.17 68.48-10.16c4.072 0 7.676 .4453 11.52 .668V65.03C258.6 66.6 274.4 71.55 293.2 77.83C301.7 80.63 310.7 83.45 320 86.12v66.07c20.79 6.84 41.45 12.96 66.71 12.96c4.207 0 8.781-.4766 13.29-.8594V95.54c25.44-1.477 51.59-6.953 80-17.34V141.8zM240 133.9v80.04c18.61 1.57 34.37 6.523 53.23 12.8C301.7 229.6 310.7 232.4 320 235.1V152.2C296.1 144.3 271.6 135.8 240 133.9z">
                        </path>
                     </svg>
                  </div>
               `
               }
               pendingRace +=` </div> </div><div class="drawer">`
               let users = races[race].players
               if (races[race].state == "close"){
                for (let player in users) {
                    number = player
                    pendingRace += `
                    
                       <div class="item">
                          <div class="icon">`
                          if (isRaceOwner){
                            pendingRace +=`
                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marker-alt" class="svg-inline--fa fa-map-marker-alt fa-fw " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><path fill="currentColor" d="M576 136c0 22.09-17.91 40-40 40c-.248 0-.4551-.1266-.7031-.1305l-50.52 277.9C482 468.9 468.8 480 453.3 480H122.7c-15.46 0-28.72-11.06-31.48-26.27L40.71 175.9C40.46 175.9 40.25 176 39.1 176c-22.09 0-40-17.91-40-40S17.91 96 39.1 96s40 17.91 40 40c0 8.998-3.521 16.89-8.537 23.57l89.63 71.7c15.91 12.73 39.5 7.544 48.61-10.68l57.6-115.2C255.1 98.34 247.1 86.34 247.1 72C247.1 49.91 265.9 32 288 32s39.1 17.91 39.1 40c0 14.34-7.963 26.34-19.3 33.4l57.6 115.2c9.111 18.22 32.71 23.4 48.61 10.68l89.63-71.7C499.5 152.9 496 144.1 496 136C496 113.9 513.9 96 536 96S576 113.9 576 136z">
 
                            </path>
                         </svg>`
                          }else{
                            pendingRace +=`
                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marker-alt" class="svg-inline--fa fa-map-marker-alt fa-fw " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><path fill="currentColor" d="M224 256c70.7 0 128-57.31 128-128s-57.3-128-128-128C153.3 0 96 57.31 96 128S153.3 256 224 256zM274.7 304H173.3C77.61 304 0 381.6 0 477.3c0 19.14 15.52 34.67 34.66 34.67h378.7C432.5 512 448 496.5 448 477.3C448 381.6 370.4 304 274.7 304z">
 
                            </path>
                         </svg>`
                          }
                         
                          pendingRace +=`</div>
                       <div class="text">
                             <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">
                                ${users[player].name} [<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marker-alt" class="svg-inline--fa fa-map-marker-alt fa-fw " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><path fill="currentColor" d="M509.8 332.5l-69.89-164.3c-14.88-41.25-50.38-70.98-93.01-79.24c18-10.63 46.35-35.9 34.23-82.29c-1.375-5.001-7.112-7.972-11.99-6.097l-202.3 75.66C35.89 123.4 0 238.9 0 398.8v81.24C0 497.7 14.25 512 32 512h236.2c23.75 0 39.3-25.03 28.55-46.28l-40.78-81.71V383.3c-45.63-3.5-84.66-30.7-104.3-69.58c-1.625-3.125-.9342-6.951 1.566-9.327l12.11-12.11c3.875-3.875 10.64-2.692 12.89 2.434c14.88 33.63 48.17 57.38 87.42 57.38c17.13 0 33.05-5.091 46.8-13.22l46 63.9c6 8.501 15.75 13.34 26 13.34h50.28c8.501 0 16.61-3.388 22.61-9.389l45.34-39.84C511.6 357.7 514.4 344.2 509.8 332.5zM328.1 223.1c-13.25 0-23.96-10.75-23.96-24c0-13.25 10.75-23.92 24-23.92s23.94 10.73 23.94 23.98C352 213.3 341.3 223.1 328.1 223.1z">
  
                                </path>
                             </svg>${users[player].position}] [ ${formatDuration(users[player].fastest)} / ${formatDuration(users[player].total)} ]
                             </p>
                             </div>
                       </div>
                    
                    `
                 }
               }else{
                for (let player in users) {
                    number = player
                    pendingRace += `
                    
                       <div class="item">
                          <div class="icon">`
                          if (isRaceOwner){
                           pendingRace +=`
                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marker-alt" class="svg-inline--fa fa-map-marker-alt fa-fw " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><path fill="currentColor" d="M576 136c0 22.09-17.91 40-40 40c-.248 0-.4551-.1266-.7031-.1305l-50.52 277.9C482 468.9 468.8 480 453.3 480H122.7c-15.46 0-28.72-11.06-31.48-26.27L40.71 175.9C40.46 175.9 40.25 176 39.1 176c-22.09 0-40-17.91-40-40S17.91 96 39.1 96s40 17.91 40 40c0 8.998-3.521 16.89-8.537 23.57l89.63 71.7c15.91 12.73 39.5 7.544 48.61-10.68l57.6-115.2C255.1 98.34 247.1 86.34 247.1 72C247.1 49.91 265.9 32 288 32s39.1 17.91 39.1 40c0 14.34-7.963 26.34-19.3 33.4l57.6 115.2c9.111 18.22 32.71 23.4 48.61 10.68l89.63-71.7C499.5 152.9 496 144.1 496 136C496 113.9 513.9 96 536 96S576 113.9 576 136z">
 
                            </path>
                         </svg>`
                          }else{
                           pendingRace +=`
                            <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="map-marker-alt" class="svg-inline--fa fa-map-marker-alt fa-fw " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"><path fill="currentColor" d="M224 256c70.7 0 128-57.31 128-128s-57.3-128-128-128C153.3 0 96 57.31 96 128S153.3 256 224 256zM274.7 304H173.3C77.61 304 0 381.6 0 477.3c0 19.14 15.52 34.67 34.66 34.67h378.7C432.5 512 448 496.5 448 477.3C448 381.6 370.4 304 274.7 304z">
 
                            </path>
                         </svg>`
                          }
                          pendingRace +=`</div>
                       <div class="text">
                             <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">
                                ${users[player].name}
                             </p>
                             </div>
                       </div>
                         
                    
                    `
                 }
               }
              
                   pendingRace +=`</div>`
         if (races[race].state == "open"){
            $('.pending-entries').append(pendingRace)
         }else if (races[race].state == "active"){
            $('.active-entries').append(pendingRace)
         }else if(races[race].state == "close"){
            $('.complete-entries').append(pendingRace)
         }                                     
   }
   
   $(".component-paper").mouseover(function () {
      overid = $(this).attr("hoverid")
      $(".actions[hoverid=" + overid + "]").css("display", "flex");
  }).mouseout(function () {
      $(".actions").css("display", "none");
  });
   $(".pPreview").mouseover(function () {
      mouseInOver = true
   }).mouseout(function () {
      mouseInOver = false
   });
   $(".peGPS").mouseover(function () {
      mouseInOver = true
   }).mouseout(function () {
      mouseInOver = false
   });
   $(".pJoin").mouseover(function () {
      mouseInOver = true
   }).mouseout(function () {
      mouseInOver = false
   });
   $(".pEndRace").mouseover(function () {
      mouseInOver = true
   }).mouseout(function () {
      mouseInOver = false
   });
   $(".pStartRace").mouseover(function () {
      mouseInOver = true
   }).mouseout(function () {
      mouseInOver = false
   });
   $(".pLeave").mouseover(function () {
      mouseInOver = true
   }).mouseout(function () {
      mouseInOver = false
   });

   $(".component-paper").click(function () {
      var check = $('.drawer').css('display')
   if (check === "none" && !mouseInOver) {
      $(this).children(".drawer").css("display", "block");
      drawer = 1
   } else if (check === "block" && !mouseInOver){
      $(this).children(".drawer").css("display", "none");
      drawer = 0
   }
   });
  
}

function formatDuration(ms) {
    var duration = moment.duration(ms);
    if (duration.asHours() > 1) {
      return Math.floor(duration.asHours()) + moment.utc(duration.asMilliseconds()).format(":mm:ss");
    } else {
      return moment.utc(duration.asMilliseconds()).format("mm:ss");
    }
  }

// much better
  function msToTime(duration) {
    var milliseconds = parseInt((duration%1000))
        , seconds = parseInt((duration/1000)%60)
        , minutes = parseInt((duration/(1000*60))%60)
        , hours = parseInt((duration/(1000*60*60))%24);
    
    hours = (hours < 10) ? "0" + hours : hours;
    minutes = (minutes < 10) ? "0" + minutes : minutes;
    seconds = (seconds < 10) ? "0" + seconds : seconds;
    
    return hours + ":" + minutes + ":" + seconds + "." + milliseconds;
    } 

$('.pending-entries').on('click', '.pPreview',function(){
   mID = $(this).attr("mID")
//    console.log("MAP ID", mID)
   $.post('http://fa-phone/fa-phone:racing:seePreview', JSON.stringify({
         mID: mID,
     }));
});

$('.pending-entries').on('click', '.peGPS',function(){
   mID = $('.peGPS').attr("mID")
   $.post('http://fa-phone/fa-phone:racing:setGPS', JSON.stringify({
      mID: mID,
  }));
});

$('.pending-entries').on('click', '.pJoin',function(){
   eID = $(this).attr("eventID")
   $.post('http://fa-phone/racing:event:join', JSON.stringify({
      id: eID
   }));
});

$('.pending-entries, .active-entries').on('click', '.pLeave', function(){
   $.post('http://fa-phone/racing:event:leave', JSON.stringify({}));
});

$('.pending-entries').on('click', '.pStartRace',function(){
   mID = $(this).attr("mID")
   $.post('http://fa-phone/racing:event:start', JSON.stringify({}));
});

$('.pending-entries, .active-entries').on('click', '.pEndRace',function(){
   $.post('http://fa-phone/racing:event:end', JSON.stringify({}));
});

$('.save-create-map').click(function(){
   $.post("https://fa-phone/racing:map:save", JSON.stringify({
     }));
})

$('.cancel-create-map').click(function(){

   $.post('http://fa-phone/racing:map:cancel', JSON.stringify({

  }));
})

function inRace(raceId) {
   let currentRace = penRace[raceId]

   if(currentRace.players !== undefined) {
       currentRace.players = Object.values(currentRace.players).sort((a,b) => a.total - b.total);
   }

   for (let id in currentRace.players) {
      let racer = currentRace.players[id];
    //   console.log("PLAYER PLAYER",racer.characterId == playerIds,JSON.stringify(racer))

       if (racer.characterId == playerIds) {
           return true
       }
   }

   return false
}