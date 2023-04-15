fx_version 'cerulean'

games { 'gta5' }
shared_script {
  "@fa-lib/server/sv_rpc.lua",
  "@fa-lib/server/sv_sql.lua",
  "@fa-lib/server/sv_asyncExports.lua"
}

client_scripts {
  "@fa-sync/client/lib.lua",
  '@fa-lib/client/cl_interface.lua',
  "@fa-lib/client/cl_polyhooks.lua",
  "@fa-locales/client/lib.lua",
  "@fa-lib/client/cl_rpc.lua",
  'client/cl_*.lua',
  "@PolyZone/client.lua",
}

server_scripts {
  "@fa-lib/server/sv_rpc.lua",
  'server/sv_*.lua',
  'server/sv_*.js',
  'build-server/sv_*.js',
}
  