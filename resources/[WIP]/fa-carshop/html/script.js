var categoryVehicleSelected = "all";
var vehicleSelected = {};

var dataVehicles = []
var handlingVehicle = [];

var selectedColor = "primary";

var showBuy = false;

window.addEventListener('message', function(event) {
    var data = event.data;

    if (event.data.type == "display") {
        $("body").fadeIn();

        showBuy = event.data.showBuy;

        document.getElementById("top-menu").innerHTML = '';
        // document.getElementById("top-menu").innerHTML = '<a href="#all" onclick="menuVehicle(event)" value="all" class="selected">all</a>';

        categoryVehicleSelected = data.categorys[0]

        for(var [key,value] of Object.entries(data.categorys)){

            $('.top-menu').append(`
                <a href="#` + value + `" onclick="menuVehicle(event)" value="` + value + `">` + value + `</a>
            `);
        }

        $.post(`https://${GetParentResourceName()}/menuSelected`, JSON.stringify({menuId: categoryVehicleSelected}));
    }

    if (event.data.type == "hide") {
        $("body").fadeOut();
    }

    if (event.data.type == "menu") {
        $(".carousel-cars").show();

        for(var [k,v] of Object.entries(data.data)){
            dataVehicles.push(v);
        }
        Dealership.Open(dataVehicles);
    }

    if (event.data.type == "updateVehicleInfos") {
        var data = event.data;
        handlingVehicle = data.data;

        vehicleSelected.sale = vehicleSelected.sale*1000
        var priceVehicle = vehicleSelected.sale.toLocaleString('pt-br');

        $('#contentVehicle').append(`
                    <div class="row spacebetween">
                        <span class="priceVehicle">$`+ priceVehicle +`</span>
                    </div>

                    <div class="column spacebetween info">
                        <span class="title">Handling</span>
                        <div class="bar">
                            <span class="percent" style="width:`+Math.ceil(10*handlingVehicle.traction*1.6)+`%"></span>
                        </div>

                    </div>

                    <div class="column spacebetween info">
                        <span class="title">Top Speed</span>
                        <div class="bar">
                            <span class="percent" style="width:`+Math.ceil(handlingVehicle.maxSpeed*1.4)+`%"></span>
                        </div>

                    </div>

                    <div class="column spacebetween info">
                        <span class="title">Acceleration</span>
                        <div class="bar">
                            <span class="percent" style="width:`+Math.ceil(100*handlingVehicle.acceleration)+`%"></span>
                        </div>
                    </div>

                    <div class="column spacebetween info">
                        <span class="title">Breaking</span>
                        <div class="bar">
                            <span class="percent" style="width:`+Math.ceil(100*handlingVehicle.breaking)+`%"></span>
                        </div>
                    </div>

                    <div class="row" id="actionButton">

                    </div>
                `);

                if (showBuy) {
                    $('#actionButton').append(`
                        <a class="buyButton" style=" color:#FC1259;" onclick="buyVehicle()"> Purchase </a>
                    `);
                }
    }

});

$(document).ready(function() {
    $('.upper-bottom-container').on('afterChange', function(event, slick, currentSlide) {

        $('.button-container').appendTo(currentSlide);
    });
});

function menuVehicle(event) {
    var div = $(event.target).parent().find('.selected');

    $(div).removeClass('selected');

    $(event.currentTarget).addClass('selected');

    categoryVehicleSelected = $(event.currentTarget).attr('value');

    document.getElementById("nameBrand").innerHTML = '';
    document.getElementById("contentVehicle").innerHTML = '';
    document.getElementById("vehiclebrand").innerHTML = '';
    document.getElementById("carouselCars").innerHTML = '';

    dataVehicles = []

    $.post(`https://${GetParentResourceName()}/menuSelected`, JSON.stringify({menuId: categoryVehicleSelected.toLowerCase()}));
}

function buyVehicle() {
    $.post(`https://${GetParentResourceName()}/Buy`, JSON.stringify(vehicleSelected));
}



var scrollAmount = 0

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            $.post(`https://${GetParentResourceName()}/Close`);
            $('body').css("display","none");
            document.getElementById("top-menu").innerHTML = '';
            break;
        case 9: // TAB
            break;
        case 17: // TAB
            break;
        case 68: // LEFT A
            $.post(`https://${GetParentResourceName()}/rotate`, JSON.stringify({key: "left"}))
            break;
        case 65: // RIGHT D
            $.post(`https://${GetParentResourceName()}/rotate`, JSON.stringify({key: "right"}))
            break;
        case 39: // RIGHT ARROW
            scrollAmount = scrollAmount + 300
            $('.carousel-cars').animate({scrollLeft:scrollAmount}, 'fast');
            break;
        case 37: // LEFT ARROW
            scrollAmount = scrollAmount - 300
            $('.carousel-cars').animate({scrollLeft:scrollAmount}, 'fast');
            break;
    }
});

$(document).on('keydown', function(ev) {
    var input = $(ev.target);
    var num = input.hasClass('input-number');
    var _key = false;
    if (ev.which == 68) {
        if (num === false) {
            _key = "left"
        }
        else if (num) {
            input.val(parseInt(input.val()) + 1)
            inputChange(input,true)
        }
    }
    if (ev.which == 65) {
        if (num === false) {
            _key = "right"
        }
        else if (num) {
            input.val(parseInt(input.val()) - 1)
            inputChange(input,false)
        }
    }

    if (_key) {
        $.post(`https://${GetParentResourceName()}/rotate`, JSON.stringify({key: _key}))
    }
});

$(document).on('mousedown', ".item-cars", function(event){
    switch(event.which) {
        case 3:
            // click direito

            break;
        case 1:
            // click esquerdo

            var div = $(this).parent().find('.selectedVehicle');
            $(div).removeClass('selectedVehicle');

            var classList = $(event.currentTarget).attr('class').split(/\s+/);
            var itemDisabled = false;

            $.each(classList, function(index, item) {
                if (item === 'disable') {
                    itemDisabled = true;
                }
            });

            if(!itemDisabled) {
                $(event.currentTarget).addClass('selectedVehicle');

                var dataCar = $(event.currentTarget).find('.specification').find('span');
                var scroll =  $(event.currentTarget).position();

                if(scroll.left > 500) {
                    scrollAmount = scrollAmount + scroll.left
                } else if( scroll.left < 0 ) {
                    scrollAmount = scrollAmount - scrollAmount/2 + scroll.left
                } else {
                    scrollAmount = scrollAmount - scroll.left
                }

                $('.carousel-cars').animate({scrollLeft:scrollAmount}, 'fast');

                $('.modal').css("display","none");

                document.getElementById("nameBrand").innerHTML = '';
                document.getElementById("vehiclebrand").innerHTML = '';
                document.getElementById("contentVehicle").innerHTML = '';

                document.getElementById("vehiclebrand").innerHTML = ' <img id="vehicle_brand_image" src="../imgs/brands/'+dataCar[0].outerText+'.png">';

                $('#nameBrand').append(`
                    <span id="vehicle_name">`+dataCar[1].outerText+`</span>
                    <span id="vehicle_line"></span>
                    <span id="vehicle_brand">`+dataCar[0].outerText+`</span>
                `);

                $(".changeVehicleColor").css("display","block");

                vehicleSelected = {brand: dataCar[0].outerText, modelcar: dataCar[9].outerText, sale: dataCar[7].outerText/1000, name: dataCar[1].outerText }

                $.post(`https://${GetParentResourceName()}/SpawnVehicle`, JSON.stringify({ modelcar: dataCar[9].outerText, price: dataCar[7].outerText }));

                if (dataCar[7].outerText < 1) {
                    document.getElementById("buttonbuy").innerHTML = '<span class="sold-out-text">Sold OUT</span>';
                }
            }
        break;
    }
});

(() => {
    Dealership = {};

    Dealership.Open = function(data) {
        for(i = 0; i < (data.length); i++) {

            var modelUper = data[i].model;

            if (data[i].qtd < 1) {
                $(".carousel-cars").append(`
                <div class="item-cars">
                    <div class="col-lg-3 col-md-6 ">
                        <div class="specification" style="opacity:0.0; position:absolute;">
                            <span id="brand">`+ data[i].brand +`</span>
                            <span id="name">`+ data[i].name +`</span>
                            <span id="fabrication">`+ data[i].fabrication +`</span>
                            <span id="handling">`+ data[i].handling +`</span>
                            <span id="topspeed">`+ data[i].topspeed +`</span>
                            <span id="power">`+ data[i].power +`</span>
                            <span id="breaking">`+ data[i].breaking +`</span>
                            <span id="price">`+ data[i].price +`</span>
                            <span id="qtd">`+ data[i].qtd +`</span>
                            <span id="model">`+ data[i].model +`</span>
                            <span id="category">`+ data[i].category +`</span>
                        </div>
                        <div class="soldOut">SOLD OUT</div>
                        <div class="img-fluid" style="background-image: url(../imgs/` + modelUper.toUpperCase() +`.png);"> <span class="exibeName">`+ data[i].name +`</span></div>
                    </div>
                </div>`);
            }
            else if (data[i].qtd > 0) {
                $(".carousel-cars").append(`
                <div class="item-cars" >
                    <div class="col-lg-3 col-md-6 ">
                        <div class="specification" style="opacity:0.0; position:absolute;">
                            <span id="brand">`+ data[i].brand +`</span>
                            <span id="name">`+ data[i].name +`</span>
                            <span id="fabrication">`+ data[i].fabrication +`</span>
                            <span id="handling">`+ data[i].handling +`</span>
                            <span id="topspeed">`+ data[i].topspeed +`</span>
                            <span id="power">`+ data[i].power +`</span>
                            <span id="breaking">`+ data[i].breaking +`</span>
                            <span id="price">`+ data[i].price +`</span>
                            <span id="qtd">`+ data[i].qtd +`</span>
                            <span id="model">`+ data[i].model +`</span>
                            <span id="category">`+ data[i].category +`</span>
                        </div>

                        <div class="img-fluid" style="background-image:  url(../imgs/` + modelUper.toUpperCase() +`.png);"> <span class="exibeName">`+ data[i].name +`</span></div>
                    </div>
                </div>`);
            }
        }
    }

    Dealership.Open(dataVehicles)
})();