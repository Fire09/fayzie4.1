const insertNotiID = []

function createNotiID() {
	const Id = getRandomIntInclusive(1, 10000000)
	console.log(Id)
	if (insertNotiID.includes(Id)) {
		createNotiID()
	} else {
        console.log(Id)
		insertNotiID.push(Id);
		return Id
	}
}

function removeNotiID(num) {
	i = insertNotiID.indexOf(num);
	if (i >= 0) {
		insertNotiID.splice(i,1);
	}
}

function createNotifyCallAction(title, detail, num) {
	if ($('.arama-notify-check').length < 1) {
		$('.top-notifications-wrapper-mounted').prepend(createNotifyCall(title, detail, num));
	}
};


function kevin() {
	const notificationContainer = $('.top-notifications-wrapper')
	if (notificationContainer.parent().has('.notification-container').length > 0) {
		if (pPhoneOpen === false) {
			movePhone('notify')
			//globalyhide()
		}
	} else {
		if (pPhoneOpen === false) {
			movePhone('close')
		}
	}
}


// function addWingzNotify(item, handle) {
function addWingzNotify(item) {
	let apps = item.Napp;
	let count = 1;
	let timeout = 0;
	let entries = 1;
	let timerStart = 0;
	let Time = 3000;
	let notification = ``
	const Id = getRandomIntInclusive(1, 10000000)
	const Notif = $(".notification-container").filter(`[data-id="${Id}"]`)
	if (Notif) {
		$.each($(".notification-container"), function (i, d) {
			count = count + 1
			kevin()
		})
	}

	if (entries < 3) {
		notification = `<div class="notification-container" data-id="${Id}">
				<div class="app-bar">`
		if (apps === "twat") {
			notification += `<div class="icon" style="background-color: rgb(0, 176, 255); color: white;">`
		} else if (apps === "sms") {
			notification += `<div class="icon" style="background-color: rgb(139, 230, 22, 0.95); color: white;">`
		} else if (apps === "email") {
			notification += `<div class="icon" style="background-color: rgb(144, 202, 249); color: white;">`
		} else if (apps === "racen") {
			timeout = 12000;
			notification += `<div class="icon" style="background-color: rgb(6, 141, 112); color: white;">`
		} else if (apps === "jobactivity") {
			notification += `<div class="icon" style="background-color: rgb(45, 48, 52); color: white;">`
		} else if (apps === "charge") {
			notification += `<div class="icon" style="background-color: rgb(38, 50, 56); color: white;">`
		} else if (apps === "maintenance") {
			notification += `<div class="icon" style="background-color: rgb(255, 211, 0); color: black;">`
		} else {
			notification += `<div class="icon" style="background-color: rgb(38, 50, 56); color: white;">`
		}
		notification += `<svg aria-hidden="true" focusable="false" data-prefix="fab" data-icon="twitter" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">`
		if (apps === "twat") {
			notification += `<path fill="currentColor" d="M459.37 151.716c.325 4.548.325 9.097.325 13.645 0 138.72-105.583 298.558-298.558 298.558-59.452 0-114.68-17.219-161.137-47.106 8.447.974 16.568 1.299 25.34 1.299 49.055 0 94.213-16.568 130.274-44.832-46.132-.975-84.792-31.188-98.112-72.772 6.498.974 12.995 1.624 19.818 1.624 9.421 0 18.843-1.3 27.614-3.573-48.081-9.747-84.143-51.98-84.143-102.985v-1.299c13.969 7.797 30.214 12.67 47.431 13.319-28.264-18.843-46.781-51.005-46.781-87.391 0-19.492 5.197-37.36 14.294-52.954 51.655 63.675 129.3 105.258 216.365 109.807-1.624-7.797-2.599-15.918-2.599-24.04 0-57.828 46.782-104.934 104.934-104.934 30.213 0 57.502 12.67 76.67 33.137 23.715-4.548 46.456-13.32 66.599-25.34-7.798 24.366-24.366 44.833-46.132 57.827 21.117-2.273 41.584-8.122 60.426-16.243-14.292 20.791-32.161 39.308-52.628 54.253z"></path>`
		} else if (apps === "sms") {
			//139, 230, 22, 0.95
			notification += `<path fill="currentColor" d="M256 32C114.6 32 .0272 125.1 .0272 240c0 49.63 21.35 94.98 56.97 130.7c-12.5 50.37-54.27 95.27-54.77 95.77c-2.25 2.25-2.875 5.734-1.5 8.734C1.979 478.2 4.75 480 8 480c66.25 0 115.1-31.76 140.6-51.39C181.2 440.9 217.6 448 256 448c141.4 0 255.1-93.13 255.1-208S397.4 32 256 32z"></path>`
		} else if (apps === "email") {
			notification += `<path fill="currentColor" d="M464 64C490.5 64 512 85.49 512 112C512 127.1 504.9 141.3 492.8 150.4L275.2 313.6C263.8 322.1 248.2 322.1 236.8 313.6L19.2 150.4C7.113 141.3 0 127.1 0 112C0 85.49 21.49 64 48 64H464zM217.6 339.2C240.4 356.3 271.6 356.3 294.4 339.2L512 176V384C512 419.3 483.3 448 448 448H64C28.65 448 0 419.3 0 384V176L217.6 339.2z"></path>`
		} else if (apps === "racen") {
			notification += `<path fill="currentColor" d="M509.5 .0234c-6.145 0-12.53 1.344-18.64 4.227c-44.11 20.86-76.81 27.94-104.1 27.94c-57.89 0-91.53-31.86-158.2-31.87C195 .3203 153.3 8.324 96 32.38V32c0-17.75-14.25-32-32-32S32 14.25 32 32L31.96 496c0 8.75 7.25 16 16 16H80C88.75 512 96 504.8 96 496V384c51.74-23.86 92.71-31.82 128.3-31.82c71.09 0 120.6 31.78 191.7 31.78c30.81 0 65.67-5.969 108.1-23.09C536.3 355.9 544 344.4 544 332.1V30.74C544 12.01 527.8 .0234 509.5 .0234zM480 141.8c-31.99 14.04-57.81 20.59-80 22.49v80.21c25.44-1.477 51.59-6.953 80-17.34V308.9c-22.83 7.441-43.93 11.08-64.03 11.08c-5.447 0-10.71-.4258-15.97-.8906V244.5c-4.436 .2578-8.893 .6523-13.29 .6523c-25.82 0-47.35-4.547-66.71-10.08v66.91c-23.81-6.055-50.17-11.41-80-12.98V213.1C236.2 213.7 232.5 213.3 228.5 213.3C208.8 213.3 185.1 217.7 160 225.1v69.1C139.2 299.4 117.9 305.8 96 314.4V250.7l24.77-10.39C134.8 234.5 147.6 229.9 160 225.1V143.4C140.9 148.5 120.1 155.2 96 165.3V101.8l24.77-10.39C134.8 85.52 147.6 80.97 160 77.02v66.41c26.39-6.953 49.09-10.17 68.48-10.16c4.072 0 7.676 .4453 11.52 .668V65.03C258.6 66.6 274.4 71.55 293.2 77.83C301.7 80.63 310.7 83.45 320 86.12v66.07c20.79 6.84 41.45 12.96 66.71 12.96c4.207 0 8.781-.4766 13.29-.8594V95.54c25.44-1.477 51.59-6.953 80-17.34V141.8zM240 133.9v80.04c18.61 1.57 34.37 6.523 53.23 12.8C301.7 229.6 310.7 232.4 320 235.1V152.2C296.1 144.3 271.6 135.8 240 133.9z"></path>`
		} else if (apps === "jobactivity") {
			notification += `<path fill="currentColor" d="M511.8 287.6L512.5 447.7C512.5 450.5 512.3 453.1 512 455.8V472C512 494.1 494.1 512 472 512H456C454.9 512 453.8 511.1 452.7 511.9C451.3 511.1 449.9 512 448.5 512H392C369.9 512 352 494.1 352 472V384C352 366.3 337.7 352 320 352H256C238.3 352 224 366.3 224 384V472C224 494.1 206.1 512 184 512H128.1C126.6 512 125.1 511.9 123.6 511.8C122.4 511.9 121.2 512 120 512H104C81.91 512 64 494.1 64 472V360C64 359.1 64.03 358.1 64.09 357.2V287.6H32.05C14.02 287.6 0 273.5 0 255.5C0 246.5 3.004 238.5 10.01 231.5L266.4 8.016C273.4 1.002 281.4 0 288.4 0C295.4 0 303.4 2.004 309.5 7.014L416 100.7V64C416 46.33 430.3 32 448 32H480C497.7 32 512 46.33 512 64V185L564.8 231.5C572.8 238.5 576.9 246.5 575.8 255.5C575.8 273.5 560.8 287.6 543.8 287.6L511.8 287.6z"></path>`
		} else if (apps === "charge") {
			notification += `<path fill="currentColor" d="M326.7 403.7C304.7 411.6 280.8 416 256 416C231.2 416 207.3 411.6 185.3 403.7C184.1 403.6 184.7 403.5 184.5 403.4C154.4 392.4 127.6 374.6 105.9 352C70.04 314.6 48 263.9 48 208C48 93.12 141.1 0 256 0C370.9 0 464 93.12 464 208C464 263.9 441.1 314.6 406.1 352C405.1 353 404.1 354.1 403.1 355.1C381.7 376.4 355.7 393.2 326.7 403.7L326.7 403.7zM235.9 111.1V118C230.3 119.2 224.1 120.9 220 123.1C205.1 129.9 192.1 142.5 188.9 160.8C187.1 171 188.1 180.9 192.3 189.8C196.5 198.6 203 204.8 209.6 209.3C221.2 217.2 236.5 221.8 248.2 225.3L250.4 225.9C264.4 230.2 273.8 233.3 279.7 237.6C282.2 239.4 283.1 240.8 283.4 241.7C283.8 242.5 284.4 244.3 283.7 248.3C283.1 251.8 281.2 254.8 275.7 257.1C269.6 259.7 259.7 261 246.9 259C240.9 258 230.2 254.4 220.7 251.2C218.5 250.4 216.3 249.7 214.3 249C203.8 245.5 192.5 251.2 189 261.7C185.5 272.2 191.2 283.5 201.7 286.1C202.9 287.4 204.4 287.9 206.1 288.5C213.1 291.2 226.4 295.4 235.9 297.6V304C235.9 315.1 244.9 324.1 255.1 324.1C267.1 324.1 276.1 315.1 276.1 304V298.5C281.4 297.5 286.6 295.1 291.4 293.9C307.2 287.2 319.8 274.2 323.1 255.2C324.9 244.8 324.1 234.8 320.1 225.7C316.2 216.7 309.9 210.1 303.2 205.3C291.1 196.4 274.9 191.6 262.8 187.9L261.1 187.7C247.8 183.4 238.2 180.4 232.1 176.2C229.5 174.4 228.7 173.2 228.5 172.7C228.3 172.3 227.7 171.1 228.3 167.7C228.7 165.7 230.2 162.4 236.5 159.6C242.1 156.7 252.9 155.1 265.1 156.1C269.5 157.7 283 160.3 286.9 161.3C297.5 164.2 308.5 157.8 311.3 147.1C314.2 136.5 307.8 125.5 297.1 122.7C292.7 121.5 282.7 119.5 276.1 118.3V112C276.1 100.9 267.1 91.9 256 91.9C244.9 91.9 235.9 100.9 235.9 112V111.1zM48 352H63.98C83.43 377.9 108 399.7 136.2 416H64V448H448V416H375.8C403.1 399.7 428.6 377.9 448 352H464C490.5 352 512 373.5 512 400V464C512 490.5 490.5 512 464 512H48C21.49 512 0 490.5 0 464V400C0 373.5 21.49 352 48 352H48z"></path>`
		} else if (apps === "maintenance") {
			notification += `<path fill="currentColor" d="M487.998 463.959L474.623 463.96L294.455 11.498C291.705 4.623 284.954 -0.001 277.454 0L234.454 0.004C226.954 0.005 220.205 4.63 217.455 11.505L37.373 464.001L23.998 464.002C10.743 464.003 -0.001 474.749 0 488.003V488.003C0.001 501.258 10.747 512.001 24.002 512L488.002 511.956C501.257 511.955 512.001 501.21 512 487.955V487.955C511.999 474.701 501.253 463.957 487.998 463.959ZM365.609 319.977L146.359 319.997L190.849 207.998L321.099 207.986L365.609 319.977ZM256.001 48.004L301.969 159.99L209.969 159.999L256.001 48.004ZM127.239 367.997L384.739 367.973L422.998 463.965L88.998 463.996L127.239 367.997Z"></path>`
		} else if (apps === "misc") {
			notification += `<path fill="currentColor" d="M570.69 236.28L512 184.45V48a16 16 0 0 0-16-16h-64a16 16 0 0 0-16 16v51.69L314.75 10.31a39.85 39.85 0 0 0-53.45 0l-256 226a16 16 0 0 0-1.21 22.6L25.5 282.7a16 16 0 0 0 22.6 1.21L277.42 81.63a16 16 0 0 1 21.17 0L527.91 283.9a16 16 0 0 0 22.6-1.21l21.4-23.82a16 16 0 0 0-1.22-22.59zM288 115L69.47 307.71c-1.62 1.46-3.69 2.14-5.47 3.35V496a16 16 0 0 0 16 16h128a16 16 0 0 0 16-16V368a16 16 0 0 1 16-16h96a16 16 0 0 1 16 16v128a16 16 0 0 0 16 16h128a16 16 0 0 0 16-16V311.1c-1.7-1.16-3.72-1.82-5.26-3.2z"></path>`
		}
		notification += `</svg>
					</div>
					<div class="name">
						<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary w-name" style="word-break: break-word;">${truncateString(item.Title, 15)}</p>
					</div>
						<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">just now</p>
				</div>
				<div class="content">
					<div class="text">
						<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary" style="word-break: break-word;">${item.Ndata} </p>
					</div>
					<div class="actions">
			
					</div>
				</div>
			</div>`

		const reverseNotif = (Notif) => {
			entries = entries + 1
			timeout = timeout + 3000
			setTimeout(() => {
				var removeds = $(".notification-container").filter(`[data-id="${Id}"]`);
				for (i = 0; i < removeds.length; i++) {
					removeds[i].style.animation = "cometopaparevers 0.5s";
					setTimeout(function () {
						for (i = 0; i < removeds.length; i++) {
							removeds[i].innerHTML = "";
							removeds[i].remove();
							count = count + 1
							setTimeout(() => {
								kevin()
							}, 300);
						}
					}, 499)
				}
			}, timeout);
		}
		reverseNotif(Notif)

		$(document).ready(function () {
			$(document).on("click", ".notification-container", function () {
				var removed = $(".notification-container").filter(`[data-id="${Id}"]`);
				for (i = 0; i < removed.length; i++) {
					removed[i].style.animation = "cometopaparevers 0.5s";
					setTimeout(function () {
						for (i = 0; i < removed.length; i++) {
							removed[i].innerHTML = "";
							removed[i].remove();
						}
					}, 499)
				}
			});
		})

	}
	$('.top-notifications-wrapper').append(notification)

}

function movePhone(pValue, pNotification) {

	if (pValue == "close") {
		$(".jss13").animate({ bottom: "-1000px" }, 100)
		$(".phone-screen").animate({ bottom: "-1000px" }, 100)
		return
	} else if (pValue == "notification") {
		$(".calculator").css('display', 'none');
		$("#main-app-container").css("bottom", "-60vh")
		$("#main-app-container").css("display", "block");
		$("#main-app-container").animate({ bottom: "-39vh" }, 10, function () {
			setTimeout(() => {
				$("#main-app-container").animate({ bottom: "-60vh" }, 100, function () {
					$("#main-app-container").css("display", "block");
				})
			}, 2500);
		})
		return
	} else if (pValue == "notify") {
		callNot = true
		globalyhide()
		$(".calculator").css('display', 'none');
		$('.delete-yp').css('display', 'none');
		$('#advert').css('display', 'none');
		$('.jss2278').css('display', 'none');
		$(".jss13").removeClass("slideout").addClass('slidein').show().css("bottom", "-553px").add($('.jss13')).fadeIn();
		$(".phone-screen").removeClass("slideout").addClass('slidein').show().css("bottom", "-533px").add($('.phone-screen')).fadeIn();
		$(".phone-app").removeClass("slideout").addClass('slidein').show().css("bottom", "-553px").add($('.phone-screen')).fadeIn();
		return
	} else if (pValue == "jobnotify") {
		callNot = true
		$(".calculator").css('display', 'none');
		$('.delete-yp').css('display', 'none');
		$('#advert').css('display', 'none');
		$('.jss2278').css('display', 'none');
		$(".jss13").show().css("bottom", "-553px").add($('.jss13')).show();
		$(".phone-screen").show().css("bottom", "-533px").add($('.phone-screen')).show();
		$(".phone-app").show().css("bottom", "-553px").add($('.phone-screen')).show();
		return
	}

	return

}

var callNotiID = 0

function createNotifyCall(title, detail, num) {

	var htmlse = "";

	callNotiID = createNotiID()

	htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${callNotiID}">
			<div class="app-bar">
			<div class="icon" style="background-color: rgb(0, 150, 136); color: white;">
			<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="phone" class="svg-inline--fa fa-phone fa-w-16 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
			<path fill="currentColor" d="M493.4 24.6l-104-24c-11.3-2.6-22.9 3.3-27.5 13.9l-48 112c-4.2 9.8-1.4 21.3 6.9 28l60.6 49.6c-36 76.7-98.9 140.5-177.2 177.2l-49.6-60.6c-6.8-8.3-18.2-11.1-28-6.9l-112 48C3.9 366.5-2 378.1.6 389.4l24 104C27.1 504.2 36.7 512 48 512c256.1 0 464-207.5 464-464 0-11.2-7.7-20.9-18.6-23.4z">
			</path>
			</svg>
			</div>
				<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
					style="word-break: break-word;">${title}</p>
				</div>
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
				<div class="text">
					<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary call-div2">${detail}</p>
					<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary timer-sc"
					style="word-break: break-word;"><span class="timer-sc-min"></span><span class="timer-dot"></span><span class="timer-sc-sec"></span></p>
				</div>
				<div class="action-button">
							<div class="action action-reject not-but" data-tippy-content="Hang Up">
							<svg aria-hidden="true" focusable="false"
							data-prefix="fas" data-icon="times-circle" class="svg-inline--fa fa-times-circle fa-w-16 fa-fw "
							role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
							<path fill="currentColor"
							d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z">
							</path>
						</svg>
						</div>
					</div>
			</div>
			</div>`

	$(document).ready(function () {
        tippy('.not-but', {
            theme: 'nopixel',
			inertia: true,
          })
		$(document).on('click', '.not-but', function () {
			endCallNow()
			btnHangUp()
			$('.action-reject').hide();
		});
	})
	return htmlse;
};

var incomingNotiID = 0

function incomingCall(name, numbers) {

	if (pPhoneOpen === false) {
		movePhone("notify")
	}

	incomingNotiID = createNotiID()

	numer = numbers.toString()
	var detailSlice = '(' + numer.slice(0, 3) + ') ' + (numer.slice(3, 6)) + '-' + numer.slice(6, 10);
	var detailFormat = name ? name : detailSlice;
	var htmlse = "";
	htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${incomingNotiID}">
			<div class="app-bar">
			<div class="icon" style="background-color: rgb(0, 150, 136); color: white;">
			<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="phone" class="svg-inline--fa fa-phone fa-w-16 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
			<path fill="currentColor" d="M493.4 24.6l-104-24c-11.3-2.6-22.9 3.3-27.5 13.9l-48 112c-4.2 9.8-1.4 21.3 6.9 28l60.6 49.6c-36 76.7-98.9 140.5-177.2 177.2l-49.6-60.6c-6.8-8.3-18.2-11.1-28-6.9l-112 48C3.9 366.5-2 378.1.6 389.4l24 104C27.1 504.2 36.7 512 48 512c256.1 0 464-207.5 464-464 0-11.2-7.7-20.9-18.6-23.4z">
			</path>
			</svg>
			</div>
			<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">${detailFormat}</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary call-div2">Incoming Call...</p>
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary timer-sc"
				style="word-break: break-word;"><span class="timer-sc-min"></span><span class="timer-dot"></span><span class="timer-sc-sec"></span></p>
			</div>
				<div class="action-button">
						<div class="action action-reject incomingCall-Hangup" data-tippy-content="Hang Up">
							<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" class="svg-inline--fa fa-times-circle fa-w-16 fa-fw " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
								<path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z">
								</path>
							</svg>
						</div>
						
				</div>
				<div class="action-button">
						<div class="action action-accept accept-call" data-tippy-content="Accept" style="padding-left: 5px;">
							<svg style="color: #93eb73" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="svg-inline--fa fa-check-circle fa-w-16 fa-1x">
								<path fill="currentColor" d="M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z" class="">
								</path>
							</svg>
						</div>
				</div>
			</div>
		</div>`
	$(document).ready(function () {
        tippy('.incomingCall-Hangup', {
            theme: 'nopixel',
			inertia: true,
          })
          tippy('.accept-call', {
            theme: 'nopixel',
			inertia: true,
          })

		$(document).on('click', '.accept-call', function () {
			btnAnswer()
		})
		$(document).on('click', '.incomingCall-Hangup', function () {
			endCallNow()
			btnHangUp()
		})
	})
	$('.top-notifications-wrapper-mounted').prepend(htmlse)

};

function endCallNow() {
	$('.call-div2').remove()
	$('.timer-sc').html("Disconnected")
	$('.action-reject').hide();
	$('.action-accept').hide();
	setTimeout(() => {
		var removeFromCall = document.getElementsByClassName("notification-container")
		for (i = 0; i < removeFromCall.length; i++) {
			removeFromCall[i].style.animation = "cometopaparevers 0.5s";
			setTimeout(function () {
				for (i = 0; i < removeFromCall.length; i++) {
					removeFromCall[i].innerHTML = "";
					removeFromCall[i].remove();
					removeNotiID(incomingNotiID)
					removeNotiID(callNotiID)
					setTimeout(() => {
						kevin()
					}, 300);
				}
			}, 499)
		}
	}, 2000);
}

function acceptcall(data) {

	$('.timer-sc-min').html('00')
	$('.timer-dot').html(':')
	var milisecond = 00;
	var seconds = 00;
	var minutes = 00;
	$('.app-bar .name .call-div-name').text(data.name)
	$('.call-div2').remove()
	var appendMin = $('.content .timer-sc-min');
	var appendSecond = $('.content .timer-sc-sec')
	var Interval;
	clearInterval(Interval);
	Interval = setInterval(startTimer, 17);

	function startTimer() {
		milisecond++;
		if (seconds <= 9) {
			appendSecond.html("0" + seconds);
		}
		if (seconds > 9) {
			appendSecond.html(seconds);
		}
		if (milisecond > 60) {
			seconds++;
			if (seconds >= 10) {
				appendSecond.html(seconds);
			} else {
				appendSecond.html("0" + seconds);
			}
			milisecond = 0;
		}
		if (seconds > 59) {
			minutes++;
			if (minutes >= 10) {
				appendMin.html(minutes);
			} else {
				appendMin.html("0" + minutes);
			}
			seconds = 0;
			appendSecond.html("0" + 0);
		}
		if (minutes > 9) {
			appendMin.html(minutes);
		}
	}

}

var pingNotiID = 0

function createPing(name) {
	if (pPhoneOpen === false) {
		movePhone("notify")
	}

	if (pingNotiID == 0) {
		pingNotiID = createNotiID()
	} else {
		pingNotiID = pingNotiID
	}

	var seconds = 30;
	var milisecond = 30;
	var Interval;
	clearInterval(Interval);
	Interval = setInterval(startTimer, 17);
	var appendSecond = $('.app-bar .timerSec')
	let timers = 0;
	function startTimer() {
		milisecond++;

		if (milisecond > 60) {
			seconds--;
			if (seconds <= 9) {
				timers = seconds
				$('.content .timerSec').html("00:0" + seconds);
			} else {
				$('.content .timerSec').html("00:" + seconds);
				appendSecond.html("0" + seconds);
			}
			if (seconds == 0) {
				var deleteCallNot = $(".notification-container").filter(`[data-id="${pingNotiID}"]`);
				for (i = 0; i < deleteCallNot.length; i++) {
					deleteCallNot[i].style.animation = "cometopaparevers 0.5s";
					setTimeout(function () {
						for (i = 0; i < deleteCallNot.length; i++) {
							deleteCallNot[i].innerHTML = "";
							deleteCallNot[i].remove();
							removeNotiID(pingNotiID)
							setTimeout(() => {
								kevin()
							}, 300);
						}
					}, 499)
				}
				pingReject()
			}
			milisecond = 0;
		}
	}
	var htmlse = "";
	htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${pingNotiID}">
			<div class="app-bar">
			<div class="icon" style="background-color: rgb(251, 156, 104); color: white;">
			<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="phone" class="svg-inline--fa fa-phone fa-w-16 fa-fw fa-sm " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" style="margin-left: 2px;">
			<path fill="currentColor" d="M320 144C320 223.5 255.5 288 176 288C96.47 288 32 223.5 32 144C32 64.47 96.47 0 176 0C255.5 0 320 64.47 320 144zM192 64C192 55.16 184.8 48 176 48C122.1 48 80 90.98 80 144C80 152.8 87.16 160 96 160C104.8 160 112 152.8 112 144C112 108.7 140.7 80 176 80C184.8 80 192 72.84 192 64zM144 480V317.1C154.4 319 165.1 319.1 176 319.1C186.9 319.1 197.6 319 208 317.1V480C208 497.7 193.7 512 176 512C158.3 512 144 497.7 144 480z">
			</path>
			</svg>
			</div>
			<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">${name}</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary" style="word-break: break-word;">just now</p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary timerSec">00:30</p>
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary timer-sc"
				style="word-break: break-word;"><span class="timer-sc-min"></span><span class="timer-dot"></span><span class="timer-sc-sec"></span></p>
			</div>
			<div class="action-button">
						<div class="action action-reject ping-Decline" data-tippy-content="Decline">
							<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" class="svg-inline--fa fa-times-circle fa-w-16 fa-fw " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
								<path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z">
								</path>
							</svg>
						</div>
						
				</div>
				<div class="action-button">
						<div class="action action-accept ping-Accept" data-tippy-content="Accept" style="padding-left: 5px;">
							<svg style="color: #93eb73" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="svg-inline--fa fa-check-circle fa-w-16 fa-1x">
								<path fill="currentColor" d="M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z" class="">
								</path>
							</svg>
						</div>
				</div>
			</div>
		</div>`
	$(document).ready(function () {
        tippy('.ping-Decline', {
          theme: 'nopixel',
		  inertia: true,
        })
        tippy('.ping-Accept', {
          theme: 'nopixel',
		  inertia: true,
        })
		$(document).on('click', '.ping-Decline', function () {
			var deleteCallNot = $(".notification-container").filter(`[data-id="${pingNotiID}"]`);
			for (i = 0; i < deleteCallNot.length; i++) {
				deleteCallNot[i].style.animation = "cometopaparevers 0.5s";
				setTimeout(function () {
					for (i = 0; i < deleteCallNot.length; i++) {
						deleteCallNot[i].innerHTML = "";
						deleteCallNot[i].remove();
						removeNotiID(pingNotiID)
					}
				}, 499)
			}
			pingReject()
		});

		$(document).on('click', '.ping-Accept', function () {
			var deleteCallNot = $(".notification-container").filter(`[data-id="${pingNotiID}"]`);
			for (i = 0; i < deleteCallNot.length; i++) {
				deleteCallNot[i].style.animation = "cometopaparevers 0.5s";
				setTimeout(function () {
					for (i = 0; i < deleteCallNot.length; i++) {
						deleteCallNot[i].innerHTML = "";
						deleteCallNot[i].remove();
						removeNotiID(pingNotiID)
					}
				}, 499)
			}
			pingAccept()
		})
	})
	$('.top-notifications-wrapper-mounted').prepend(htmlse)
};


var GasInterval;
var gasNotiID = 0
var GasSeconds = 30;
var gasType;
var companyName;
var companyID;
var chargeAMT;
var targetID;
var senderIDX;
var documentIDIDX;

var bankBusterGroupID;
var bankBusterTargetID;
var bankBusterSenderID;
var bankBusterTargetCID;

var amount;
var sellerIDc;

function createGasBill(gasinfo) {

	if (pPhoneOpen === false) {
		movePhone("notify")
		clearInterval(GasInterval);
		htmlse = ""
	}


	if (gasinfo.data.amount != null) {
		amount = gasinfo.data.amount;
	}

	if (gasinfo.data.sellerID != null) {
		sellerIDc = gasinfo.data.sellerID;
	}

	if (gasinfo.data.bankBusterGroupID != null) {
		bankBusterGroupID = gasinfo.data.bankBusterGroupID;
	}

	if (gasinfo.data.bankBusterTargetID != null) {
		bankBusterTargetID = gasinfo.data.bankBusterTargetID;
	}

	if (gasinfo.data.bankBusterSenderID != null) {
		bankBusterSenderID = gasinfo.data.bankBusterSenderID;
	}

	if (gasinfo.data.bankBusterTargetCID != null) {
		bankBusterTargetCID = gasinfo.data.bankBusterTargetCID;
	}

	if(gasinfo.data.companyName != null) {
		companyName = gasinfo.data.companyName;
	}

	if (gasinfo.data.companyID != null) {
		companyID = gasinfo.data.companyID;
	}

	if (gasinfo.data.targetCID != null) {
		targetID = gasinfo.data.targetCID;
	}

	if (gasinfo.data.senderID != null) {
		senderIDX = gasinfo.data.senderID;
	} 

	if (gasinfo.data.documentID != null) {
		documentIDIDX = gasinfo.data.documentID
	}

	chargeAMT = gasinfo.data.amount;


	gasNotiID = createNotiID()
	gasType = gasinfo.icon;

	GasInterval = setInterval(startGasTimer, 1000);

	function startGasTimer() {
		GasSeconds--;

		if (GasSeconds > 9) {
			$('.content .gastimerSec').html("00:" + GasSeconds);
		}
		
		if (GasSeconds <= 9) {
			$('.content .gastimerSec').html("00:0" + GasSeconds);
		}
		//$('.content .gastimerSec').html("00:" + GasSeconds);
		if (GasSeconds == 0) {
			clearInterval(GasInterval);
			btnGasDecline(gasNotiID)
		}
	}

	//d="M326.7 403.7C304.7 411.6 280.8 416 256 416C231.2 416 207.3 411.6 185.3 403.7C184.1 403.6 184.7 403.5 184.5 403.4C154.4 392.4 127.6 374.6 105.9 352C70.04 314.6 48 263.9 48 208C48 93.12 141.1 0 256 0C370.9 0 464 93.12 464 208C464 263.9 441.1 314.6 406.1 352C405.1 353 404.1 354.1 403.1 355.1C381.7 376.4 355.7 393.2 326.7 403.7L326.7 403.7zM235.9 111.1V118C230.3 119.2 224.1 120.9 220 123.1C205.1 129.9 192.1 142.5 188.9 160.8C187.1 171 188.1 180.9 192.3 189.8C196.5 198.6 203 204.8 209.6 209.3C221.2 217.2 236.5 221.8 248.2 225.3L250.4 225.9C264.4 230.2 273.8 233.3 279.7 237.6C282.2 239.4 283.1 240.8 283.4 241.7C283.8 242.5 284.4 244.3 283.7 248.3C283.1 251.8 281.2 254.8 275.7 257.1C269.6 259.7 259.7 261 246.9 259C240.9 258 230.2 254.4 220.7 251.2C218.5 250.4 216.3 249.7 214.3 249C203.8 245.5 192.5 251.2 189 261.7C185.5 272.2 191.2 283.5 201.7 286.1C202.9 287.4 204.4 287.9 206.1 288.5C213.1 291.2 226.4 295.4 235.9 297.6V304C235.9 315.1 244.9 324.1 255.1 324.1C267.1 324.1 276.1 315.1 276.1 304V298.5C281.4 297.5 286.6 295.1 291.4 293.9C307.2 287.2 319.8 274.2 323.1 255.2C324.9 244.8 324.1 234.8 320.1 225.7C316.2 216.7 309.9 210.1 303.2 205.3C291.1 196.4 274.9 191.6 262.8 187.9L261.1 187.7C247.8 183.4 238.2 180.4 232.1 176.2C229.5 174.4 228.7 173.2 228.5 172.7C228.3 172.3 227.7 171.1 228.3 167.7C228.7 165.7 230.2 162.4 236.5 159.6C242.1 156.7 252.9 155.1 265.1 156.1C269.5 157.7 283 160.3 286.9 161.3C297.5 164.2 308.5 157.8 311.3 147.1C314.2 136.5 307.8 125.5 297.1 122.7C292.7 121.5 282.7 119.5 276.1 118.3V112C276.1 100.9 267.1 91.9 256 91.9C244.9 91.9 235.9 100.9 235.9 112V111.1zM48 352H63.98C83.43 377.9 108 399.7 136.2 416H64V448H448V416H375.8C403.1 399.7 428.6 377.9 448 352H464C490.5 352 512 373.5 512 400V464C512 490.5 490.5 512 464 512H48C21.49 512 0 490.5 0 464V400C0 373.5 21.49 352 48 352H48z"

	var htmlse = "";
	if (gasinfo.icon == "gas") {
		htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
			<div class="app-bar">
			<div class="icon"  style="background-color: rgb(38, 50, 56); color: white; font-size: 17px; width: 25px; height: 23px">
			<svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 412 512">
			<path d="M32 64C32 28.65 60.65 0 96 0H256C291.3 0 320 28.65 320 64V256H328C376.6 256 416 295.4 416 344V376C416 389.3 426.7 400 440 400C453.3 400 464 389.3 464 376V221.1C436.4 214.9 416 189.8 416 160V96L384 64C375.2 55.16 375.2 40.84 384 32C392.8 23.16 407.2 23.16 416 32L493.3 109.3C505.3 121.3 512 137.5 512 154.5V376C512 415.8 479.8 448 440 448C400.2 448 368 415.8 368 376V344C368 321.9 350.1 303.1 328 303.1H320V448C337.7 448 352 462.3 352 480C352 497.7 337.7 512 320 512H32C14.33 512 0 497.7 0 480C0 462.3 14.33 448 32 448V64zM96 176C96 184.8 103.2 192 112 192H240C248.8 192 256 184.8 256 176V80C256 71.16 248.8 64 240 64H112C103.2 64 96 71.16 96 80V176z"/></svg>
		</div>
		<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">${gasinfo.title}</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - $${gasinfo.data.amount}.00</p>
			</div>`
	} else if (gasinfo.icon == "home") {
		htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
			<div class="app-bar">
			<div class="icon"  style="background-color: rgb(38, 50, 56); color: white; font-size: 17px; width: 25px; height: 23px">
			<svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 412 512">
			<path d="M570.24 215.42l-58.35-47.95V72a8 8 0 0 0-8-8h-32a8 8 0 0 0-7.89 7.71v56.41L323.87 13a56 56 0 0 0-71.74 0L5.76 215.42a16 16 0 0 0-2 22.54L14 250.26a16 16 0 0 0 22.53 2L64 229.71V288h-.31v208a16.13 16.13 0 0 0 16.1 16H496a16 16 0 0 0 16-16V229.71l27.5 22.59a16 16 0 0 0 22.53-2l10.26-12.3a16 16 0 0 0-2.05-22.58zM464 224h-.21v240H352V320a32 32 0 0 0-32-32h-64a32 32 0 0 0-32 32v144H111.69V194.48l.31-.25v-4L288 45.65l176 144.62z"/></svg>
		</div>
		<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">${gasinfo.title}</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - $${gasinfo.data.amount}.00</p>
			</div>`
	} else if (gasinfo.icon == "charge") {
		htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
			<div class="app-bar">
			<div class="icon"  style="background-color: rgb(38, 50, 56); color: white; font-size: 17px; width: 25px; height: 23px">
			<svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 412 512">
			<path d="M326.7 403.7C304.7 411.6 280.8 416 256 416C231.2 416 207.3 411.6 185.3 403.7C184.1 403.6 184.7 403.5 184.5 403.4C154.4 392.4 127.6 374.6 105.9 352C70.04 314.6 48 263.9 48 208C48 93.12 141.1 0 256 0C370.9 0 464 93.12 464 208C464 263.9 441.1 314.6 406.1 352C405.1 353 404.1 354.1 403.1 355.1C381.7 376.4 355.7 393.2 326.7 403.7L326.7 403.7zM235.9 111.1V118C230.3 119.2 224.1 120.9 220 123.1C205.1 129.9 192.1 142.5 188.9 160.8C187.1 171 188.1 180.9 192.3 189.8C196.5 198.6 203 204.8 209.6 209.3C221.2 217.2 236.5 221.8 248.2 225.3L250.4 225.9C264.4 230.2 273.8 233.3 279.7 237.6C282.2 239.4 283.1 240.8 283.4 241.7C283.8 242.5 284.4 244.3 283.7 248.3C283.1 251.8 281.2 254.8 275.7 257.1C269.6 259.7 259.7 261 246.9 259C240.9 258 230.2 254.4 220.7 251.2C218.5 250.4 216.3 249.7 214.3 249C203.8 245.5 192.5 251.2 189 261.7C185.5 272.2 191.2 283.5 201.7 286.1C202.9 287.4 204.4 287.9 206.1 288.5C213.1 291.2 226.4 295.4 235.9 297.6V304C235.9 315.1 244.9 324.1 255.1 324.1C267.1 324.1 276.1 315.1 276.1 304V298.5C281.4 297.5 286.6 295.1 291.4 293.9C307.2 287.2 319.8 274.2 323.1 255.2C324.9 244.8 324.1 234.8 320.1 225.7C316.2 216.7 309.9 210.1 303.2 205.3C291.1 196.4 274.9 191.6 262.8 187.9L261.1 187.7C247.8 183.4 238.2 180.4 232.1 176.2C229.5 174.4 228.7 173.2 228.5 172.7C228.3 172.3 227.7 171.1 228.3 167.7C228.7 165.7 230.2 162.4 236.5 159.6C242.1 156.7 252.9 155.1 265.1 156.1C269.5 157.7 283 160.3 286.9 161.3C297.5 164.2 308.5 157.8 311.3 147.1C314.2 136.5 307.8 125.5 297.1 122.7C292.7 121.5 282.7 119.5 276.1 118.3V112C276.1 100.9 267.1 91.9 256 91.9C244.9 91.9 235.9 100.9 235.9 112V111.1zM48 352H63.98C83.43 377.9 108 399.7 136.2 416H64V448H448V416H375.8C403.1 399.7 428.6 377.9 448 352H464C490.5 352 512 373.5 512 400V464C512 490.5 490.5 512 464 512H48C21.49 512 0 490.5 0 464V400C0 373.5 21.49 352 48 352H48z"/></svg>
		</div>
		<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">SERVICES CHARGE</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - $${gasinfo.data.amount}.00 incl tax - ${gasinfo.data.companyName}</p>
			</div>`
	}else if (gasinfo.icon == "joboffertowing") {
		htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
			<div class="app-bar">
			<div class="icon"  style="background-color: rgb(144, 202, 249); color: white; font-size: 17px; width: 25px; height: 23px">
			<svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 550 512"><path d="M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"">
			<path d="M511.8 287.6L512.5 447.7C512.5 450.5 512.3 453.1 512 455.8V472C512 494.1 494.1 512 472 512H456C454.9 512 453.8 511.1 452.7 511.9C451.3 511.1 449.9 512 448.5 512H392C369.9 512 352 494.1 352 472V384C352 366.3 337.7 352 320 352H256C238.3 352 224 366.3 224 384V472C224 494.1 206.1 512 184 512H128.1C126.6 512 125.1 511.9 123.6 511.8C122.4 511.9 121.2 512 120 512H104C81.91 512 64 494.1 64 472V360C64 359.1 64.03 358.1 64.09 357.2V287.6H32.05C14.02 287.6 0 273.5 0 255.5C0 246.5 3.004 238.5 10.01 231.5L266.4 8.016C273.4 1.002 281.4 0 288.4 0C295.4 0 303.4 2.004 309.5 7.014L416 100.7V64C416 46.33 430.3 32 448 32H480C497.7 32 512 46.33 512 64V185L564.8 231.5C572.8 238.5 576.9 246.5 575.8 255.5C575.8 273.5 560.8 287.6 543.8 287.6L511.8 287.6z"/></svg>
		</div>
		<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">${gasinfo.title}</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - ${gasinfo.data.amount}</p>
			</div>`
	}else if (gasinfo.icon == "jobofferdelivery") {
		htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
			<div class="app-bar">
			<div class="icon"  style="background-color: rgb(144, 202, 249); color: white; font-size: 17px; width: 25px; height: 23px">
			<svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 550 512"><path d="M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"">
			<path d="M511.8 287.6L512.5 447.7C512.5 450.5 512.3 453.1 512 455.8V472C512 494.1 494.1 512 472 512H456C454.9 512 453.8 511.1 452.7 511.9C451.3 511.1 449.9 512 448.5 512H392C369.9 512 352 494.1 352 472V384C352 366.3 337.7 352 320 352H256C238.3 352 224 366.3 224 384V472C224 494.1 206.1 512 184 512H128.1C126.6 512 125.1 511.9 123.6 511.8C122.4 511.9 121.2 512 120 512H104C81.91 512 64 494.1 64 472V360C64 359.1 64.03 358.1 64.09 357.2V287.6H32.05C14.02 287.6 0 273.5 0 255.5C0 246.5 3.004 238.5 10.01 231.5L266.4 8.016C273.4 1.002 281.4 0 288.4 0C295.4 0 303.4 2.004 309.5 7.014L416 100.7V64C416 46.33 430.3 32 448 32H480C497.7 32 512 46.33 512 64V185L564.8 231.5C572.8 238.5 576.9 246.5 575.8 255.5C575.8 273.5 560.8 287.6 543.8 287.6L511.8 287.6z"/></svg>
		</div>
		<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">${gasinfo.title}</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - ${gasinfo.data.amount}</p>
			</div>`
	}else if (gasinfo.icon == "jobofferfishing") {
		htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
			<div class="app-bar">
			<div class="icon"  style="background-color: rgb(144, 202, 249); color: white; font-size: 17px; width: 25px; height: 23px">
			<svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 550 512"><path d="M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"">
			<path d="M511.8 287.6L512.5 447.7C512.5 450.5 512.3 453.1 512 455.8V472C512 494.1 494.1 512 472 512H456C454.9 512 453.8 511.1 452.7 511.9C451.3 511.1 449.9 512 448.5 512H392C369.9 512 352 494.1 352 472V384C352 366.3 337.7 352 320 352H256C238.3 352 224 366.3 224 384V472C224 494.1 206.1 512 184 512H128.1C126.6 512 125.1 511.9 123.6 511.8C122.4 511.9 121.2 512 120 512H104C81.91 512 64 494.1 64 472V360C64 359.1 64.03 358.1 64.09 357.2V287.6H32.05C14.02 287.6 0 273.5 0 255.5C0 246.5 3.004 238.5 10.01 231.5L266.4 8.016C273.4 1.002 281.4 0 288.4 0C295.4 0 303.4 2.004 309.5 7.014L416 100.7V64C416 46.33 430.3 32 448 32H480C497.7 32 512 46.33 512 64V185L564.8 231.5C572.8 238.5 576.9 246.5 575.8 255.5C575.8 273.5 560.8 287.6 543.8 287.6L511.8 287.6z"/></svg>
		</div>
		<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">${gasinfo.title}</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - ${gasinfo.data.amount}</p>
			</div>`
	}else if (gasinfo.icon == "joboffergarbage") {
		htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
			<div class="app-bar">
			<div class="icon"  style="background-color: rgb(144, 202, 249); color: white; font-size: 17px; width: 25px; height: 23px">
			<svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 550 512"><path d="M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"">
			<path d="M511.8 287.6L512.5 447.7C512.5 450.5 512.3 453.1 512 455.8V472C512 494.1 494.1 512 472 512H456C454.9 512 453.8 511.1 452.7 511.9C451.3 511.1 449.9 512 448.5 512H392C369.9 512 352 494.1 352 472V384C352 366.3 337.7 352 320 352H256C238.3 352 224 366.3 224 384V472C224 494.1 206.1 512 184 512H128.1C126.6 512 125.1 511.9 123.6 511.8C122.4 511.9 121.2 512 120 512H104C81.91 512 64 494.1 64 472V360C64 359.1 64.03 358.1 64.09 357.2V287.6H32.05C14.02 287.6 0 273.5 0 255.5C0 246.5 3.004 238.5 10.01 231.5L266.4 8.016C273.4 1.002 281.4 0 288.4 0C295.4 0 303.4 2.004 309.5 7.014L416 100.7V64C416 46.33 430.3 32 448 32H480C497.7 32 512 46.33 512 64V185L564.8 231.5C572.8 238.5 576.9 246.5 575.8 255.5C575.8 273.5 560.8 287.6 543.8 287.6L511.8 287.6z"/></svg>
		</div>
		<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">${gasinfo.title}</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - ${gasinfo.data.amount}</p>
			</div>`
    }else if (gasinfo.icon == "jobofferdodo") {
        htmlse +=
        `<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
            <div class="app-bar">
            <div class="icon"  style="background-color: rgb(144, 202, 249); color: white; font-size: 17px; width: 25px; height: 23px">
            <svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 550 512"><path d="M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"">
            <path d="M511.8 287.6L512.5 447.7C512.5 450.5 512.3 453.1 512 455.8V472C512 494.1 494.1 512 472 512H456C454.9 512 453.8 511.1 452.7 511.9C451.3 511.1 449.9 512 448.5 512H392C369.9 512 352 494.1 352 472V384C352 366.3 337.7 352 320 352H256C238.3 352 224 366.3 224 384V472C224 494.1 206.1 512 184 512H128.1C126.6 512 125.1 511.9 123.6 511.8C122.4 511.9 121.2 512 120 512H104C81.91 512 64 494.1 64 472V360C64 359.1 64.03 358.1 64.09 357.2V287.6H32.05C14.02 287.6 0 273.5 0 255.5C0 246.5 3.004 238.5 10.01 231.5L266.4 8.016C273.4 1.002 281.4 0 288.4 0C295.4 0 303.4 2.004 309.5 7.014L416 100.7V64C416 46.33 430.3 32 448 32H480C497.7 32 512 46.33 512 64V185L564.8 231.5C572.8 238.5 576.9 246.5 575.8 255.5C575.8 273.5 560.8 287.6 543.8 287.6L511.8 287.6z"/></svg>
        </div>
        <div class="name">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
                style="word-break: break-word;">${gasinfo.title}</p>
            </div>
            <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                style="word-break: break-word;"></p>
            </div>
            <div class="content">
            <div class="text">
                <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - ${gasinfo.data.amount}</p>
            </div>`
        }else if (gasinfo.icon == "house_robbery") {
            htmlse +=
            `<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
                <div class="app-bar">
                <div class="icon"  style="background-color: rgb(144, 202, 249); color: white; font-size: 17px; width: 25px; height: 23px">
                <svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 550 512"><path d="M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"">
                <path d="M511.8 287.6L512.5 447.7C512.5 450.5 512.3 453.1 512 455.8V472C512 494.1 494.1 512 472 512H456C454.9 512 453.8 511.1 452.7 511.9C451.3 511.1 449.9 512 448.5 512H392C369.9 512 352 494.1 352 472V384C352 366.3 337.7 352 320 352H256C238.3 352 224 366.3 224 384V472C224 494.1 206.1 512 184 512H128.1C126.6 512 125.1 511.9 123.6 511.8C122.4 511.9 121.2 512 120 512H104C81.91 512 64 494.1 64 472V360C64 359.1 64.03 358.1 64.09 357.2V287.6H32.05C14.02 287.6 0 273.5 0 255.5C0 246.5 3.004 238.5 10.01 231.5L266.4 8.016C273.4 1.002 281.4 0 288.4 0C295.4 0 303.4 2.004 309.5 7.014L416 100.7V64C416 46.33 430.3 32 448 32H480C497.7 32 512 46.33 512 64V185L564.8 231.5C572.8 238.5 576.9 246.5 575.8 255.5C575.8 273.5 560.8 287.6 543.8 287.6L511.8 287.6z"/></svg>
            </div>
            <div class="name">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
                    style="word-break: break-word;">${gasinfo.title}</p>
                </div>
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word;"></p>
                </div>
                <div class="content">
                <div class="text">
                    <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - ${gasinfo.data.amount}</p>
                </div>`
        }else if (gasinfo.icon == "jobofferoxy") {
            htmlse +=
            `<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
                <div class="app-bar">
                <div class="icon"  style="background-color: rgb(144, 202, 249); color: white; font-size: 17px; width: 25px; height: 23px">
                <svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 550 512"><path d="M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"">
                <path d="M511.8 287.6L512.5 447.7C512.5 450.5 512.3 453.1 512 455.8V472C512 494.1 494.1 512 472 512H456C454.9 512 453.8 511.1 452.7 511.9C451.3 511.1 449.9 512 448.5 512H392C369.9 512 352 494.1 352 472V384C352 366.3 337.7 352 320 352H256C238.3 352 224 366.3 224 384V472C224 494.1 206.1 512 184 512H128.1C126.6 512 125.1 511.9 123.6 511.8C122.4 511.9 121.2 512 120 512H104C81.91 512 64 494.1 64 472V360C64 359.1 64.03 358.1 64.09 357.2V287.6H32.05C14.02 287.6 0 273.5 0 255.5C0 246.5 3.004 238.5 10.01 231.5L266.4 8.016C273.4 1.002 281.4 0 288.4 0C295.4 0 303.4 2.004 309.5 7.014L416 100.7V64C416 46.33 430.3 32 448 32H480C497.7 32 512 46.33 512 64V185L564.8 231.5C572.8 238.5 576.9 246.5 575.8 255.5C575.8 273.5 560.8 287.6 543.8 287.6L511.8 287.6z"/></svg>
            </div>
            <div class="name">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
                    style="word-break: break-word;">${gasinfo.title}</p>
                </div>
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word;"></p>
                </div>
                <div class="content">
                <div class="text">
                    <p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - ${gasinfo.data.amount}</p>
                </div>`
		}else if (gasinfo.icon == "jobofferchop") {
			htmlse +=
			`<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
				<div class="app-bar">
				<div class="icon"  style="background-color: rgb(144, 202, 249); color: white; font-size: 17px; width: 25px; height: 23px">
				<svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 550 512"><path d="M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"">
				<path d="M511.8 287.6L512.5 447.7C512.5 450.5 512.3 453.1 512 455.8V472C512 494.1 494.1 512 472 512H456C454.9 512 453.8 511.1 452.7 511.9C451.3 511.1 449.9 512 448.5 512H392C369.9 512 352 494.1 352 472V384C352 366.3 337.7 352 320 352H256C238.3 352 224 366.3 224 384V472C224 494.1 206.1 512 184 512H128.1C126.6 512 125.1 511.9 123.6 511.8C122.4 511.9 121.2 512 120 512H104C81.91 512 64 494.1 64 472V360C64 359.1 64.03 358.1 64.09 357.2V287.6H32.05C14.02 287.6 0 273.5 0 255.5C0 246.5 3.004 238.5 10.01 231.5L266.4 8.016C273.4 1.002 281.4 0 288.4 0C295.4 0 303.4 2.004 309.5 7.014L416 100.7V64C416 46.33 430.3 32 448 32H480C497.7 32 512 46.33 512 64V185L564.8 231.5C572.8 238.5 576.9 246.5 575.8 255.5C575.8 273.5 560.8 287.6 543.8 287.6L511.8 287.6z"/></svg>
			</div>
			<div class="name">
					<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
					style="word-break: break-word;">${gasinfo.title}</p>
				</div>
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
					style="word-break: break-word;"></p>
				</div>
				<div class="content">
				<div class="text">
					<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - ${gasinfo.data.amount}</p>
				</div>`
	}else if (gasinfo.icon == "documents") {
		htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
			<div class="app-bar">
			<div class="icon"  style="background-color: rgb(38, 50, 56); color: white; font-size: 17px; width: 25px; height: 23px">
			<svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 284 512">
			<path d="M384 128h-128V0L384 128zM256 160H384v304c0 26.51-21.49 48-48 48h-288C21.49 512 0 490.5 0 464v-416C0 21.49 21.49 0 48 0H224l.0039 128C224 145.7 238.3 160 256 160zM255 295L216 334.1V232c0-13.25-10.75-24-24-24S168 218.8 168 232v102.1L128.1 295C124.3 290.3 118.2 288 112 288S99.72 290.3 95.03 295c-9.375 9.375-9.375 24.56 0 33.94l80 80c9.375 9.375 24.56 9.375 33.94 0l80-80c9.375-9.375 9.375-24.56 0-33.94S264.4 285.7 255 295z"/></svg>
		</div>
		<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">DOCUMENTS</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - Accept to preview this document.</p>
			</div>`
} else {
		htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${gasNotiID}">
			<div class="app-bar">
			<div class="icon"  style="background-color: rgb(38, 50, 56); color: white; font-size: 17px; width: 25px; height: 23px">
			<svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 412 512">
			<path d="M511.8 287.6L512.5 447.7C512.5 450.5 512.3 453.1 512 455.8V472C512 494.1 494.1 512 472 512H456C454.9 512 453.8 511.1 452.7 511.9C451.3 511.1 449.9 512 448.5 512H392C369.9 512 352 494.1 352 472V384C352 366.3 337.7 352 320 352H256C238.3 352 224 366.3 224 384V472C224 494.1 206.1 512 184 512H128.1C126.6 512 125.1 511.9 123.6 511.8C122.4 511.9 121.2 512 120 512H104C81.91 512 64 494.1 64 472V360C64 359.1 64.03 358.1 64.09 357.2V287.6H32.05C14.02 287.6 0 273.5 0 255.5C0 246.5 3.004 238.5 10.01 231.5L266.4 8.016C273.4 1.002 281.4 0 288.4 0C295.4 0 303.4 2.004 309.5 7.014L416 100.7V64C416 46.33 430.3 32 448 32H480C497.7 32 512 46.33 512 64V185L564.8 231.5C572.8 238.5 576.9 246.5 575.8 255.5C575.8 273.5 560.8 287.6 543.8 287.6L511.8 287.6z"/></svg>
		</div>
		<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">${gasinfo.title}</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="gastimerSec">00:30</span> - ${gasinfo.data.amount}.00</p>
			</div>`
	}
	htmlse +=
			`<div class="action-button">
			<div class="action action-reject decline-gasBill" data-tippy-content="Decline">
				<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" class="svg-inline--fa fa-times-circle fa-w-16 fa-fw " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
				<path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z">
				</path>
				</svg>
			</div>
			
			</div>
			<div class="action-button">
					<div class="action action-accept accept-gasBill" data-tippy-content="Accept" style="padding-left: 5px;">
					<svg style="color: #93eb73" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="svg-inline--fa fa-check-circle fa-w-16 fa-1x">
						<path fill="currentColor" d="M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z" class="">
						</path>
					</svg>
				</div>
			</div>
			</div>
		</div>`
	$('.top-notifications-wrapper-mounted').prepend(htmlse)
	tippy('.decline-gasBill', {
		theme: 'nopixel',
		inertia: true,
	})
	
	tippy('.accept-gasBill', {
		theme: 'nopixel',
		inertia: true,
	})
};

$(document).ready(function () {
	$(document).on('click', '.decline-gasBill', function () {
		clearInterval(GasInterval);
		btnGasDecline(gasNotiID)
	});

	$(document).on('click', '.accept-gasBill', function () {
		clearInterval(GasInterval);
		$('.action-button').hide()
		$('.text').html('<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary">Confirming...</p>')
		setTimeout(() => {
			$('.text').html('<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary">Confirmed !</p>')
			setTimeout(() => {
				btnGasAccept()
				kevin();
			}, 100);
		}, 2000);
	})
})

btnGasAccept = () => {
    setTimeout(() => {
        var removeGasNoti = $(".notification-container").filter(`[data-id="${gasNotiID}"]`);
        for (i = 0; i < 1; i++) {
            removeGasNoti[0].style.animation = "cometopaparevers 0.5s";
            setTimeout(function () {
                for (i = 0; i < removeGasNoti.length; i++) {
                    removeGasNoti[0].innerHTML = "";
                    removeGasNoti[0].remove();
					removeNotiID(gasNotiID)
					if (pPhoneOpen === false) {
						movePhone('close')
					}
                }
            }, 499)
        }
    }, 3000)
	if (gasType == "gas") { 
		$.post("https://fa-phone/purchase_gas", JSON.stringify({}))
	} else if (gasType == "charge") {
		$.post("https://fa-phone/acceptBusinessCharge", JSON.stringify({
			pAmount: chargeAMT,
			pBID: companyID,
			pTargetID: targetID,
			pSenderID: senderIDX
		}))

	} else if (gasType == "carsale") {
		$.post("https://fa-phone/purchaseCar", JSON.stringify({
			//plate: plate,
			amount: amount,
			senderID: sellerIDc,
		}))

	} else if (gasType == "joboffertowing") {
        $.post("https://fa-phone/accept_tow_job", JSON.stringify({}))
    } else if (gasType == "jobofferdelivery") {
        $.post("https://fa-phone/accept_delivery_job", JSON.stringify({}))
	} else if (gasType == "jobofferfishing") {
        $.post("https://fa-phone/accept_fishing_job", JSON.stringify({}))
    } else if (gasType == "jobofferdodo") {
        $.post("https://fa-phone/accept_dodo_job", JSON.stringify({}))
    } else if (gasType == "house_robbery") {
        $.post("https://fa-phone/accept_house_robbery", JSON.stringify({}))
    } else if (gasType == "jobofferoxy") {
        $.post("https://fa-phone/accept_oxy_run", JSON.stringify({}))
	} else if (gasType == "jobofferchop") {
        $.post("https://fa-phone/accept_chop_shop", JSON.stringify({}))
	} else if (gasType == "joboffergarbage") {
        $.post("https://fa-phone/accept_garbage_job", JSON.stringify({}))
	} else if (gasType == "documents") {
		$.post("https://fa-phone/acceptDocumentReceiveRequest", JSON.stringify({
			documentID: documentIDIDX
		}))
	} else if (gasType == "documents") {
		$.post("https://fa-phone/acceptDocumentReceiveRequest", JSON.stringify({
			documentID: documentIDIDX
		}))
	} else if (gasType == "bankbusters") {
		$.post("https://fa-phone/onPlayerJoinBankBusters", JSON.stringify({
			targetCID: bankBusterTargetCID,
			senderID: bankBusterSenderID, 
			groupID: bankBusterGroupID
		}))
	}
}

btnGasDecline = (gasNotiID) => {
    GasSeconds = 30;
    var removeGasNoti = $(".notification-container").filter(`[data-id="${gasNotiID}"]`);
    for (i = 0; i < removeGasNoti.length; i++) {
        removeGasNoti[i].style.animation = "cometopaparevers 0.5s";
        setTimeout(function () {
            for (i = 0; i < removeGasNoti.length; i++) {
                removeGasNoti[i].innerHTML = "";
                removeGasNoti[i].remove();
				removeNotiID(gasNotiID)
				if (pPhoneOpen === false) {
					movePhone('close')
				}
            }
        }, 499)
    }
}






















// Job Offer

var JobInterval;
var jobOfferNotiID = 0

function createJobOffer(jobinfo) {
	var JobSeconds = 30;

	if (pPhoneOpen === false) {
		movePhone("notify")
		clearInterval(JobInterval);
		htmlse = ""
	}

	JobInterval = setInterval(startJobTimer, 1000);

	jobOfferNotiID = createNotiID()

	function startJobTimer() {
		JobSeconds--;

		$('.content .jobtimerSec').html("00:" + JobSeconds);
		if (JobSeconds == 0) {
			var deleteCallNot = $(".notification-container").filter(`[data-id="${jobOfferNotiID}"]`);
			for (i = 0; i < deleteCallNot.length; i++) {
				deleteCallNot[i].style.animation = "cometopaparevers 0.5s";
				setTimeout(function () {
					for (i = 0; i < deleteCallNot.length; i++) {
						deleteCallNot[i].innerHTML = "";
						deleteCallNot[i].remove();
						removeNotiID(jobOfferNotiID)
						setTimeout(() => {
							kevin()
							clearInterval(JobInterval);
						}, 300);
					}
				}, 499)
			}
			btnJobDecline()
		}
	}

	var htmlse = "";
	htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${jobOfferNotiID}">
			<div class="app-bar">
			<div class="icon"  style="background-color: rgb(144, 202, 249); color: white; font-size: 17px; width: 25px; height: 23px">
			<svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 550 512"><path d="M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"/></svg>
			</div>
			<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">Job Center</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="jobtimerSec">00:30</span> - ${jobinfo}</p>
			</div>
			<div class="action-button">
			<div class="action action-reject decline-jobDecline" data-tippy-content="Decline">
				<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" class="svg-inline--fa fa-times-circle fa-w-16 fa-fw " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
				<path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z">
				</path>
				</svg>
			</div>
			
			</div>
			<div class="action-button">
					<div class="action action-accept accept-jobAccept" data-tippy-content="Accept" style="padding-left: 5px;">
					<svg style="color: #93eb73" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="svg-inline--fa fa-check-circle fa-w-16 fa-1x">
						<path fill="currentColor" d="M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z" class="">
						</path>
					</svg>
				</div>
			</div>
			</div>
		</div>`
        tippy('[data-tippy-content]', {
            theme: 'nopixel',
			inertia: true,
          })
	$('.top-notifications-wrapper-mounted').prepend(htmlse)
};

$(document).ready(function () {
	$(document).on('click', '.decline-jobDecline', function () {
		clearInterval(JobInterval);
		btnJobDecline()
	});

	$(document).on('click', '.accept-jobAccept', function () {
		clearInterval(JobInterval);
		$('.action-button').hide()
		$('.text').html('<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary">Confirming...</p>')
		setTimeout(() => {
			$('.text').html('<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary">Confirmation Successful!</p>')
			setTimeout(() => {
				btnJobAccept()
			}, 100);
		}, 2000);
	})
})

btnJobAccept = () => {
    setTimeout(() => {
        var deleteCallNot = $(".notification-container").filter(`[data-id="${jobOfferNotiID}"]`);
        for (i = 0; i < 1; i++) {
            deleteCallNot[0].style.animation = "cometopaparevers 0.5s";
            setTimeout(function () {
                for (i = 0; i < deleteCallNot.length; i++) {
                    deleteCallNot[0].innerHTML = "";
                    deleteCallNot[0].remove();
					removeNotiID(jobOfferNotiID)
					if (pPhoneOpen === false) {
						movePhone('close')
					}
                }
            }, 499)
        }
    }, 3000)
	$.post("https://fa-phone/jobOfferAccepted", JSON.stringify({
	}))
}

btnJobDecline = () => {
    var deleteCallNot = $(".notification-container").filter(`[data-id="${jobOfferNotiID}"]`);
    for (i = 0; i < deleteCallNot.length; i++) {
        deleteCallNot[i].style.animation = "cometopaparevers 0.5s";
        setTimeout(function () {
            for (i = 0; i < deleteCallNot.length; i++) {
                deleteCallNot[i].innerHTML = "";
                deleteCallNot[i].remove();
				removeNotiID(jobOfferNotiID)
				if (pPhoneOpen === false) {
					movePhone('close')
				}
            }
        }, 499)
    }
}

var jobNotiID = 0
var showingNotiJob = false

jobNotification = (jobstatus, jobinfo = false) => {
    if (!pPhoneOpen)
	movePhone("notify")

	if (showingNotiJob) {
		$(".notification-text").empty()
		$(".notification-text").append(jobinfo);
	} else {
		showingNotiJob = true
		jobNotiID = createNotiID()

		let htmlel = ""
		htmlel =
		`<div class="job-center-noti-container job-center-noti" data-id="${jobNotiID}">
			<div class="app-bar">
			<div class="icon" style="background-color: rgb(144, 202, 249); color: white; font-size: 18px; width: 25px; height: 24px">
			<svg  fill="currentColor" aria-hidden="true" focusable="false" data-prefix="fa" data-icon="people-grou" class="svg-inline--fa-solid fa-people-group fa-w-16 fa-fw fa-sm "xmlns="http://www.w3.org/2000/svg" viewBox="0 0 610 512">
			<path d="M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"/>
			</svg>
			</div>
			<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">${jobstatus}</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="job-text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary notification-text" style="font-size: 12px">${jobinfo}</p>
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary timer-sc"
				style="word-break: break-word;"><span class="timer-sc-min"></span><span class="timer-dot"></span><span class="timer-sc-sec"></span></p>
		</div>`
		$('.top-notifications-wrapper-mounted').prepend(htmlel)
	}

	$(document).ready(function () {
		$(document).on("click", ".job-center-noti", function () {
			$('.job-center-noti').hide()
			showingNotiJob = false

			var removeds = $(".job-center-noti-container").filter(`[data-id="${jobNotiID}"]`);
			for (i = 0; i < removeds.length; i++) {
				removeds[i].remove();
			}
		});
	})
}

jobNotificationStable = (jobstatus, jobinfo = false) => {
    if (!pPhoneOpen)
        movePhone("jobnotify")

	jobNotiID = createNotiID()

    let htmlel = ""
    htmlel = `<div class="job-center-noti-container arama-notify-check" style="-webkit-animation-duration: .0s; animation-duration: .0s; -webkit-animation-iteration-count: 0; animation-iteration-count: 0;" data-id="${jobNotiID}">
			<div class="app-bar">
			<div class="icon" style="background-color: rgb(144, 202, 249); color: white; font-size: 18px; width: 25px; height: 24px">
			<svg  fill="currentColor" aria-hidden="true" focusable="false" data-prefix="fa" data-icon="people-grou" class="svg-inline--fa-solid fa-people-group fa-w-16 fa-fw fa-sm "xmlns="http://www.w3.org/2000/svg" viewBox="0 0 610 512">
			<path d="M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"/>
			</svg>
			</div>
			<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">${jobstatus}</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="job-text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary call-div2" style="font-size: 12px">${jobinfo}</p>
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary timer-sc"
				style="word-break: break-word;"><span class="timer-sc-min"></span><span class="timer-dot"></span><span class="timer-sc-sec"></span></p>
			</div>`
    $('.top-notifications-wrapper-mounted').prepend(htmlel)
}

jobNotificationNotFullyClose = () => {
	$('.job-center-noti').hide()
	showingNotiJob = false
	var removeds = $(".job-center-noti-container").filter(`[data-id="${jobNotiID}"]`);
	for (i = 0; i < removeds.length; i++) {
		removeds[i].remove();
	}
	removeNotiID(jobNotiID)
}

jobNotificationClose = () => {
    var removeJobNoti = $(".job-center-noti-container").filter(`[data-id="${jobNotiID}"]`);
    for (i = 0; i < removeJobNoti.length; i++) {
		$('.job-center-noti').hide()
		showingNotiJob = false

        removeJobNoti[i].style.animation = "cometopaparevers 0.5s";
        setTimeout(function () {
            for (i = 0; i < removeJobNoti.length; i++) {
                removeJobNoti[i].innerHTML = "";
                removeJobNoti[i].remove();
				removeNotiID(jobNotiID)
				if (pPhoneOpen === false) {
					movePhone('close')
				}
            }
        }, 499)
    }
}


var JobInviteInterval;
var jobRequestNotiID = 0

function createGroupRequest(jobheader, jobinfo) {
	var JobInviteSeconds = 30;

	if (pPhoneOpen === false) {
		movePhone("notify")
		clearInterval(JobInviteInterval);
		htmlse = ""
	}

	JobInviteInterval = setInterval(startJobInviteTimer, 1000);

	jobRequestNotiID = createNotiID()

	function startJobInviteTimer() {
		JobInviteSeconds--;

		$('.content .jobtimerSec').html("00:" + JobInviteSeconds);
		if (JobInviteSeconds == 0) {
			btnRequestGroupDecline()
		}
	}

	var htmlse = "";
	htmlse +=
		`<div class="notification-container arama-notify-check" data-id="${jobRequestNotiID}">
			<div class="app-bar">
			<div class="icon"  style="background-color: rgb(144, 202, 249); color: white; font-size: 17px; width: 25px; height: 23px">
			<svg fill="currentColor" aria-hidden="true" focusable="false" class="svg-inline--fa fa-twitter fa-w-16 fa-fw fa-sm " xmlns="http://www.w3.org/2000/svg" viewBox="0 0 550 512"><path d="M184 88C184 118.9 158.9 144 128 144C97.07 144 72 118.9 72 88C72 57.07 97.07 32 128 32C158.9 32 184 57.07 184 88zM208.4 196.3C178.7 222.7 160 261.2 160 304C160 338.3 171.1 369.8 192 394.5V416C192 433.7 177.7 448 160 448H96C78.33 448 64 433.7 64 416V389.2C26.16 371.2 0 332.7 0 288C0 226.1 50.14 176 112 176H144C167.1 176 190.2 183.5 208.4 196.3V196.3zM64 245.7C54.04 256.9 48 271.8 48 288C48 304.2 54.04 319.1 64 330.3V245.7zM448 416V394.5C468 369.8 480 338.3 480 304C480 261.2 461.3 222.7 431.6 196.3C449.8 183.5 472 176 496 176H528C589.9 176 640 226.1 640 288C640 332.7 613.8 371.2 576 389.2V416C576 433.7 561.7 448 544 448H480C462.3 448 448 433.7 448 416zM576 330.3C585.1 319.1 592 304.2 592 288C592 271.8 585.1 256.9 576 245.7V330.3zM568 88C568 118.9 542.9 144 512 144C481.1 144 456 118.9 456 88C456 57.07 481.1 32 512 32C542.9 32 568 57.07 568 88zM256 96C256 60.65 284.7 32 320 32C355.3 32 384 60.65 384 96C384 131.3 355.3 160 320 160C284.7 160 256 131.3 256 96zM448 304C448 348.7 421.8 387.2 384 405.2V448C384 465.7 369.7 480 352 480H288C270.3 480 256 465.7 256 448V405.2C218.2 387.2 192 348.7 192 304C192 242.1 242.1 192 304 192H336C397.9 192 448 242.1 448 304zM256 346.3V261.7C246 272.9 240 287.8 240 304C240 320.2 246 335.1 256 346.3zM384 261.7V346.3C393.1 335 400 320.2 400 304C400 287.8 393.1 272.9 384 261.7z"/></svg>
			</div>
			<div class="name">
				<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary call-div-name"
				style="word-break: break-word;">${jobheader}</p>
			</div>
			<p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
				style="word-break: break-word;"></p>
			</div>
			<div class="content">
			<div class="text">
				<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary"><span class="jobtimerSec">00:30</span> - ${jobinfo}</p>
			</div>
			<div class="action-button">
			<div class="action action-reject decline-inviteDecline" aria-label="Decline">
				<svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="times-circle" class="svg-inline--fa fa-times-circle fa-w-16 fa-fw " role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512">
				<path fill="currentColor" d="M256 8C119 8 8 119 8 256s111 248 248 248 248-111 248-248S393 8 256 8zm121.6 313.1c4.7 4.7 4.7 12.3 0 17L338 377.6c-4.7 4.7-12.3 4.7-17 0L256 312l-65.1 65.6c-4.7 4.7-12.3 4.7-17 0L134.4 338c-4.7-4.7-4.7-12.3 0-17l65.6-65-65.6-65.1c-4.7-4.7-4.7-12.3 0-17l39.6-39.6c4.7-4.7 12.3-4.7 17 0l65 65.7 65.1-65.6c4.7-4.7 12.3-4.7 17 0l39.6 39.6c4.7 4.7 4.7 12.3 0 17L312 256l65.6 65.1z">
				</path>
				</svg>
			</div>
			
			</div>
			<div class="action-button">
					<div class="action action-accept accept-inviteAccept" aria-label="Accept" style="padding-left: 5px;">
					<svg style="color: #93eb73" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="check-circle" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" class="svg-inline--fa fa-check-circle fa-w-16 fa-1x">
						<path fill="currentColor" d="M504 256c0 136.967-111.033 248-248 248S8 392.967 8 256 119.033 8 256 8s248 111.033 248 248zM227.314 387.314l184-184c6.248-6.248 6.248-16.379 0-22.627l-22.627-22.627c-6.248-6.249-16.379-6.249-22.628 0L216 308.118l-70.059-70.059c-6.248-6.248-16.379-6.248-22.628 0l-22.627 22.627c-6.248 6.248-6.248 16.379 0 22.627l104 104c6.249 6.249 16.379 6.249 22.628.001z" class="">
						</path>
					</svg>
				</div>
			</div>
			</div>
		</div>`
	$('.top-notifications-wrapper-mounted').prepend(htmlse)
};

$(document).ready(function () {
	$(document).on('click', '.decline-inviteDecline', function () {
		clearInterval(JobInviteInterval);
		btnRequestGroupDecline()
	});

	$(document).on('click', '.accept-inviteAccept', function () {
		clearInterval(JobInviteInterval);
		$('.action-button').hide()
		$('.text').html('<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary">Confirming...</p>')
		setTimeout(() => {
			$('.text').html('<p class="MuiTypography-root MuiTypography-body1 MuiTypography-colorTextPrimary">Confirmation Successful!</p>')
			setTimeout(() => {
				btnRequestGroupAccept()
			}, 100);
		}, 2000);
	})
})

btnRequestGroupAccept = () => {
	clearInterval(JobInviteInterval);
    setTimeout(() => {
        var deleteCallNot = $(".notification-container").filter(`[data-id="${jobRequestNotiID}"]`);
        for (i = 0; i < 1; i++) {
            deleteCallNot[0].style.animation = "cometopaparevers 0.5s";
            setTimeout(function () {
                for (i = 0; i < deleteCallNot.length; i++) {
                    deleteCallNot[0].innerHTML = "";
                    deleteCallNot[0].remove();
					removeNotiID(jobRequestNotiID)
					if (pPhoneOpen === false) {
						movePhone('close')
					}
                }
            }, 499)
        }
    }, 3000)
	$.post("https://fa-phone/jobInviteAccepted", JSON.stringify({
	}))
}

btnRequestGroupDecline = () => {
	clearInterval(JobInviteInterval);
    var deleteCallNot = $(".notification-container").filter(`[data-id="${jobRequestNotiID}"]`);
    for (i = 0; i < deleteCallNot.length; i++) {
        deleteCallNot[i].style.animation = "cometopaparevers 0.5s";
        setTimeout(function () {
            for (i = 0; i < deleteCallNot.length; i++) {
                deleteCallNot[i].innerHTML = "";
                deleteCallNot[i].remove();
				removeNotiID(jobRequestNotiID)
				if (pPhoneOpen === false) {
					movePhone('close')
				}
            }
        }, 499)
    }
	$.post("https://fa-phone/jobInviteDecline", JSON.stringify({
	}))
}