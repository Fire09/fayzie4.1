fx_version 'cerulean'
games { 'gta5' }

client_script "@fyx/client/lib.js"
server_script "@fyx/server/lib.js"
shared_script "@fyx/shared/lib.lua"

client_script "@fa-sync/client/lib.lua"
client_script "@fa-lib/client/cl_ui.lua"

client_scripts {
  '@fa-lib/client/cl_rpc.lua',
  'client/cl_*.lua',
  'client/cl_*.js',
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
	'@fa-lib/server/sv_rpc.lua',
	'@fa-lib/server/sv_sqlother.lua',
  'server/sv_*.lua',
  'server/sv_*.js',
}
