fx_version 'cerulean'
game 'gta5'
 
lua54 'yes' -- Add in case you want to use lua 5.4 (https://www.lua.org/manual/5.4/manual.html)
 
client_script "@fa-errorlog/client/cl_errorlog.lua"
client_script "@fyx/client/lib.js"
server_script "@fyx/server/lib.js"
shared_script "@fyx/shared/lib.lua"
client_script "@fa-lib/client/cl_ui.lua"

client_scripts {
    "@fa-lib/client/cl_rpc.lua",
    "@fa-lib/client/cl_state.lua",
    '@fa-lib/client/cl_ui.lua',
    '@PolyZone/client.lua',
	'@PolyZone/CircleZone.lua',
    'game/dist/index.js',
    "client/names.json",
    "client/customfunctions.js",
    'client/*.lua', -- Globbing method for multiple files
}

shared_script "config.lua"

server_scripts {
    "@fa-lib/server/sv_rpc.lua",
    "client/names.json",
    'server.lua', -- Globbing method for multiple files
    '@oxmysql/lib/MySQL.lua',
    'sv_menu.lua' -- Globbing method for multiple files
}

ui_page 'web/build/index.html'
 
files {
    'web/build/index.html',
    'web/build/**/*',
    'peds.json',
}

escrow_ignore {
    'config.lua',
}