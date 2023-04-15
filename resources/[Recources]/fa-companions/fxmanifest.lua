fx_version "cerulean"
games { "gta5" }

shared_scripts {
    "shared/*",
}

server_scripts {
    "@fa-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
    "@fa-lib/client/cl_rpc.lua",
    "@fa-lib/client/cl_ui.lua",
    "client/*",
}