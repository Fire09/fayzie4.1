fx_version 'cerulean'
games { 'gta5' }

shared_script "@mka-array/Array.lua"

client_scripts {
    '@fa-lib/client/cl_rpc.lua',
    '@fa-lib/client/cl_ui.lua',
	'@fa-lib/client/cl_interface.lua',
    '@fa-errorlog/client/cl_errorlog.lua',
    'client/cl_*.lua',
}

shared_script {
    '@fa-lib/shared/sh_util.lua',
}

server_scripts {
    '@fa-lib/server/sv_rpc.lua',
    '@fa-lib/server/sv_sql.lua',
    'server/sv_*.lua',
}