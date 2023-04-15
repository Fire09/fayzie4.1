$('#advert').click(function(){
    $('.sari-add').css('display', 'flex');
})

$('.sari-add').on('click', '#close-input', function(){
    $('.sari-add').css('display', 'none');
})

$('.sari-add').on('click', '#submit-input', function(){ 
    hasPostedYP = true;
    let ypost = escapeHtml($("#saridetailinput").val())
        $('.sari-add').css('display', 'none');
        complateInput();
        $.post('http://fa-phone/newPostSubmit', JSON.stringify({
            advert: ypost
        }));
        $("#saridetailinput").val("")
        $("#sari-name").val("")
})