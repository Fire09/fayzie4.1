fx_version "cerulean"

description "NoProblem - Hud"
author "sharlock"
version '0.0.1'

lua54 'yes'

game "gta5"

ui_page 'web/build/index.html'

client_scripts {
  "@fa-lib/client/cl_rpc.lua",
  "client/cl_exports.lua",
  "client/cl_main.lua",
  "client/cl_utils.lua",
  "client/model/cl_*.lua"
}

server_scripts {
  "@oxmysql/lib/MySQL.lua",
  "@fa-lib/server/sv_rpc.lua",
  "@fa-lib/server/sv_sql.lua",
  "server/sv_*.lua"
}

files {
  'web/build/index.html',
  'web/build/**/*'
}

exports {
	'BuffIntel',
	'BuffStress',
	'BuffLuck',
	'BuffHunger',
  'BuffThirst',
	'BuffAlert',
}