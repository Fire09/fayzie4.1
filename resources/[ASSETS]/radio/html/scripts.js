$(document).ready(function () {
    var RadioChannel = "0.0";
    var Emergency = false;
    var Powered = false;

    function escapeHtml(string) {
        return String(string).replace(/[&<>"'`=\/]/g, function (s) {
            return entityMap[s];
        });
    }

    function closeGui() {
        $(".full-screen").fadeOut(100);
        $(".radio-container").fadeOut(100);
        $("#cursor").css("display", "none");

        $.post("https://radio/close", JSON.stringify({}));
    }

    function Save() {
        if (Powered) {
            RadioChannel = parseFloat($("#RadioChannel").val());

            if (!RadioChannel) {
                RadioChannel = "0.0";
            }

            if (RadioChannel < 100.0 || RadioChannel > 999.9) {
                if (RadioChannel < 10 && Emergency === false) {
                    RadioChannel = "0.0";
                }
            }

            $.post("https://radio/setRadioChannel", JSON.stringify({
                channel: RadioChannel
            }), function(success) {
                if (success == false) {
                    RadioChannel = "0.0";
                    $("#RadioChannel").val("");
                    $("#RadioChannel").attr("placeholder", "100.0+");
                    $("#RadioChannel").prop("disabled", false);
                }
            });
        }
    }

    // Listen for NUI Events
    window.addEventListener("message", function (event) {
        var item = event.data;

        if (item.setChannel) {
            RadioChannel = item.setChannel;
        }

        if (item.setState) {
            Powered = item.setState;
        }

        if (item.emergency) {
            Emergency = item.emergency;
        }

        if (item.open) {
            if (RadioChannel != "0.0" && Powered) {
                $("#RadioChannel").val(RadioChannel);
            } else {
                if (Powered) {
                    $("#RadioChannel").val("");
                    $("#RadioChannel").attr("placeholder", "100.0+");
                    $("#RadioChannel").prop("disabled", false);
                } else {
                    $("#RadioChannel").val("");
                    $("#RadioChannel").attr("placeholder", "Off");
                    $("#RadioChannel").prop("disabled", true);
                }
            }

            $(".full-screen").fadeIn(100);
            $(".radio-container").fadeIn(100);
            $("#cursor").css("display", "block");
            $("#RadioChannel").focus();
        }
    });

    $("#Radio-Form").submit(function (e) {
        e.preventDefault();
        Save();
    });

    $("#power").click(function () {
        if (Powered === false) {
            Powered = true;
            $("#RadioChannel").prop("disabled", false);
            $("#RadioChannel").focus();
            $("#RadioChannel").val(RadioChannel === "0.0" ? "" : RadioChannel);
            $("#RadioChannel").attr("placeholder", "100.0+");
            $.post("https://radio/poweredOn", JSON.stringify({
                channel: RadioChannel
            }));
        } else {
            Powered = false;
            $.post("https://radio/poweredOff", JSON.stringify({}));
            $("#RadioChannel").val("");
            $("#RadioChannel").attr("placeholder", "Off");
            $("#RadioChannel").prop("disabled", true);
        }
    });
    $("#volumeUp").click(function () {
        $.post("https://radio/volumeUp", JSON.stringify({}));
    });

    $("#volumeDown").click(function () {
        $.post("https://radio/volumeDown", JSON.stringify({}));
    });

    // On 'Esc' call close method
    document.onkeyup = function (data) {
        if (data.which == 27) {
            closeGui();
        }
    };
});