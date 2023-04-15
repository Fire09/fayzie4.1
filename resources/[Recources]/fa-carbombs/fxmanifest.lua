fx_version "cerulean"
games {"gta5"}

author 'loleris'
description "lol-carbombs"

version "1.0.0"

client_scripts {
    "@fa-lib/client/cl_rpc.lua",
    "@fa-lib/client/cl_interface.lua",
    "client/*.lua"
}

server_scripts {
    "@fa-lib/server/sv_rpc.lua",
    "server/*.lua"
}