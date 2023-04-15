fx_version "cerulean"

version '0.0.1'

lua54 'yes'

game "gta5"

ui_page 'web/build/index.html'

client_scripts {
  "@fa-lib/client/cl_rpc.lua",
  "client/cl_*.lua"
}

server_scripts {
  "@fa-lib/server/sv_rpc.lua",
  "@fa-lib/server/sv_sql.lua",
  "server/sv_*.lua"
}

files {
  'web/build/index.html',
  'web/build/**/*'
}