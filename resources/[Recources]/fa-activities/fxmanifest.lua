fx_version 'cerulean'
games { 'gta5' }

client_script {
    '@fa-lib/client/cl_rpc.lua',
	'@fa-lib/client/cl_ui.lua',
	'@fa-lib/client/cl_interface.lua',
    '@fa-lib/client/cl_ui.js',
    'client/cl_*.lua'
}

server_script {
    '@fa-lib/server/sv_rpc.lua',
    'server/sv_*.lua'
}

exports {
    'canHandOffPackages',
    'canEnterHouse',
    'canStartChop'
}