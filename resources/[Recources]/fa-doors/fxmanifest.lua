





fx_version 'cerulean'

games {
    'gta5',
    'rdr3'
}

client_scripts {
  '@fa-lib/client/cl_rpc.lua',
  '@fa-lib/client/cl_ui.lua',
  '@fa-lib/client/cl_interface.lua',
  '@fa-lib/client/cl_polyhooks.lua',
	'client/cl_*.lua'
}

shared_scripts {
  '@fa-lib/shared/sh_util.lua',
	"shared/*.lua"
}

server_scripts {
  '@fa-lib/server/sv_rpc.lua',
  '@fa-lib/server/sv_sql.lua',
	'server/*.lua'
}