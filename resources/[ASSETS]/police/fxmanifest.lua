fx_version "cerulean"
games { "gta5" }

client_script "@fa-errorlog/client/cl_errorlog.lua"
client_script "@fa-lib/client/cl_ui.lua"
client_script "@fa-lib/client/cl_interface.lua"

client_script "@fa-lib/client/cl_polyhooks.lua"
--[[ dependencies {
  'fa-lib'
} ]]--

-- General
client_scripts {
  '@fa-lib/client/cl_rpc.lua',
  'client.lua',
  'client_trunk.lua',
  'evidence.lua',
  'client/beatmode.lua',
  'client/cl_*.lua'
}


server_scripts {
  "@fa-lib/server/sv_asyncExports.lua",
  '@fa-lib/server/sv_rpc.lua',
  '@fa-lib/server/sv_sql.lua',
  'server.lua',
  'server/beatmode.lua',
  'server/sv_vehicle.lua'
}

exports {
	'getIsInService',
	'getIsCop',
	'getIsCuffed',
} 