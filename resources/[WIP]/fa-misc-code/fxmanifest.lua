fx_version 'cerulean'
games { 'gta5' }

dependencies {
  "mka-lasers"
}

files {
  'shared/*.json',
}

client_scripts {
  '@fa-errorlog/client/cl_errorlog.lua',
  '@fa-sync/client/lib.lua',
  '@fa-lib/client/cl_rpc.lua',
  '@fa-lib/client/cl_ui.lua',
  '@fa-lib/client/cl_animTask.lua',
  '@PolyZone/client.lua',
  '@PolyZone/BoxZone.lua',
  '@PolyZone/ComboZone.lua',
  '@mka-lasers/client/client.lua',
  '@mka-grapple/client.lua',
  'client/cl_*.lua',
  'client/cl_*.js',
  'client/**/cl_*.lua',
  'client/**/cl_*.js',
}

shared_script {
  '@fa-lib/shared/sh_util.lua',
  'shared/sh_*.*',
  'shared/**/sh_*.*',
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  'config.lua',
  '@fa-lib/server/sv_rpc.lua',
  '@fa-lib/server/sv_sql.lua',
  '@fa-lib/server/sv_sql.js',
  '@fa-lib/server/sv_asyncExports.js',
  '@fa-lib/server/sv_asyncExports.lua',
  'server/sv_*.lua',
  'server/sv_*.js',
  'server/**/sv_*.lua',
  'server/**/sv_*.js',
}
