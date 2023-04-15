fx_version "cerulean"
games { "gta5" }

client_script "@fa-lib/client/cl_interface.lua"

shared_scripts {
	"@fa-lib/shared/sh_util.lua",
	"shared/*",
}

server_scripts {
	"@oxmysql/lib/MySQL.lua",
	"@fa-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
	'@fa-lib/client/cl_ui.lua',
	"@fa-lib/client/cl_rpc.lua",
	"client/*",
}