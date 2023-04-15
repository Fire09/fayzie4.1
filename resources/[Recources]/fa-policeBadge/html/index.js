$(function () {
  window.onload = (e) => {
    $("#icemallow-badge").hide();
    window.addEventListener("message", (event) => {
      let item = event.data;
      if (item.action === "open") {
        $("#icemallow-badge").show();
        $("#badgeName").html(item.name);
        $("#badgeNumber").html(`#${item.callsign}`);
        $("#badgeImg").prop("src", item.img);
      } else if (item.action === "close") {
        $("#icemallow-badge").hide();
      } else {
        $("#icemallow-badge").hide();
      }
    });
  };
});
