fx_version 'bodacious'
game 'gta5'
description 'fa-phone'

client_script "@fa-errorlog/client/cl_errorlog.lua"

files {
	'html/css/balloon.min.css',
	'html/css/mui.css',
	'html/css/all.min.css',
	'html/ui.html',
	'html/css/materialize.min.css',
	'html/css/*.css',
	'html/js/phone/*.js',
	'html/images/*.png',
	'html/images/*.jpg',
	'html/images/*.svg',
	'html/wallpapers/*.png',
	'html/wallpapers/*.jpg',
	'html/wallpapers/*.svg',
	'html/images/cursor.png',
	'html/images/background.png',	
	'html/images/phone-shell.png',
	'html/images/phone-background.jpg',
	'html/images/gurgle.png',
	'html/images/pager2.png',
	'html/webfonts/fa-brands-400.eot',
	'html/webfonts/fa-brands-400.svg',
	'html/webfonts/fa-brands-400.ttf',
	'html/webfonts/fa-brands-400.woff',
	'html/webfonts/fa-brands-400.woff2',
	'html/webfonts/fa-regular-400.eot',
	'html/webfonts/fa-regular-400.svg',
	'html/webfonts/fa-regular-400.ttf',
	'html/webfonts/fa-regular-400.woff',
	'html/webfonts/fa-regular-400.woff2',
	'html/webfonts/fa-solid-900.eot',
	'html/webfonts/fa-solid-900.svg',
	'html/webfonts/fa-solid-900.ttf',
	'html/webfonts/fa-solid-900.woff',
	'html/webfonts/fa-solid-900.woff2',
}

ui_page 'html/ui.html'

shared_scripts {
	"@fa-lib/client/cl_interface.lua",
	"@fa-lib/shared/sh_util.lua",
	"module/lol_config.lua"
}

client_scripts {
	"@fa-lib/client/cl_ui.lua",
	"@fa-lib/client/cl_interface.lua",
	'@fa-lib/client/cl_rpc.lua',
	'client/cl_assistance.lua',
	'client/cl_account.lua',
	'client/cl_bankbusters.lua',
	'client/cl_burner.lua',
	'client/cl_drop_documents.lua',
	'client/cl_stocks.lua',
	'client/cl_payphone.lua',
	'client/cl_camera.lua',
	'client/cl_main.lua',
	'client/cl_license.lua',
	'client/cl_license.lua',
	'client/cl_notification.lua',
	'client/cl_business.lua',
	'client/cl_calculadora.lua',
	'client/cl_call.lua',
	'client/cl_contacts.lua',
	'client/cl_debt.lua',
	'client/cl_epinger.lua',
	'client/cl_init.lua',
	'client/cl_jobcenter.lua',
	'client/cl_messages.lua',
	'client/cl_racing.lua',
	'client/cl_twat.lua',
	'client/cl_wenmo.lua',
	'client/cl_yellowpages.lua',
	'client/cl_diamondsports.lua',
	'client/cl_documents.lua',
	'client/cl_housing.lua',
	'module/*.lua',
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	'@fa-lib/server/sv_rpc.lua',
	'@fa-lib/server/sv_sqlother.lua',
	"server/main.lua",
	"server/sv_*.lua",
	--"server/license.lua",
}

export "pOpen"
export "phasPhone"
export "pNotify"