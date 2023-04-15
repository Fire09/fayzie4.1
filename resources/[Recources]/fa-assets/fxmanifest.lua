





fx_version 'adamant'
games { 'gta5' }

ui_page 'html/index.html'

client_script "@fa-lib/client/cl_interface.lua"


client_scripts {
    'client/cl_*.lua',
}

server_scripts {
    'server/sv_*.lua'
}

files {
	'html/index.html',
	'html/jquery.js',
	'html/init.js'
}
