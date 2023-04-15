fx_version 'bodacious'
game 'gta5'

resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

client_script "@fa-lib/client/cl_ui.lua"
client_script "@fa-lib/client/cl_interface.lua"
client_script "@fa-lib/client/cl_rpc.lua"

client_scripts {
  '@fa-lib/client/cl_rpc.lua',
  'client/*.lua',
}

server_script "@fa-lib/server/sv_rpc.lua"
server_script "@fa-lib/server/sv_sql.lua"
server_scripts {
  'server/*.lua',
}