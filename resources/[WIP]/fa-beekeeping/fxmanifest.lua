fx_version 'cerulean'
games { 'gta5' }

client_script "@fa-sync/client/lib.lua"
client_script "@fa-lib/client/cl_ui.lua"
client_script "@fa-lib/client/cl_polyhooks.lua"

client_scripts {
  '@fa-lib/client/cl_main.lua',
  'client/cl_*.lua',
  "@PolyZone/client.lua",
}

shared_script {
  '@fa-lib/shared/sh_util.lua',
  'shared/sh_*.*',
}

server_scripts {
  '@fa-lib/server/sv_main.lua',
  '@fa-lib/server/sv_sql.lua',
  '@fa-lib/server/sv_asyncExports.lua',
  'server/sv_*.lua',
}
