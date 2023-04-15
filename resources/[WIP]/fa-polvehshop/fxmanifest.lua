fx_version 'cerulean'
games { 'gta5' }

--[[ dependencies {
  "fa-polyzone",
  "fa-lib",
  "fa-ui"
} ]]--

shared_script "shared/zones.lua"

client_script "@fa-lib/client/cl_ui.lua"

client_scripts {
  '@fa-lib/client/cl_rpc.lua',
  'client/cl_*.lua',
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  '@fa-lib/server/sv_asyncExports.lua',
  '@fa-lib/server/sv_rpc.lua',
  'server/sv_*.lua',
}
