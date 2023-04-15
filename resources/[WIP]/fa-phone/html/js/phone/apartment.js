$('#house-manage-apt2-upgrade-accept').click(function(){
    $('#upgrade-apartment-2').fadeOut();
    complateInput();
    setTimeout(() => {
        var type = 2;
        $.post('http://fa-phone/upgradeApt', JSON.stringify({
            type: type,
        }));
    }, 1000);
});

$('#house-manage-apt2-upgrade-decline').click(function(){
    $('#upgrade-apartment-2').fadeOut();
});

$('#house-manage-apt3-upgrade-accept').click(function(){
    $('#upgrade-apartment-3').fadeOut();
    complateInput();
    setTimeout(() => {
        var type = 3;
        $.post('http://fa-phone/upgradeApt', JSON.stringify({
            type: type,
        }));
    }, 1000);
});

$('#house-manage-apt3-upgrade-decline').click(function(){
    $('#upgrade-apartment-3').fadeOut();
});

