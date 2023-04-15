fx_version "cerulean"
games { "gta5" }

shared_script {
    "@fa-lib/shared/sh_util.lua",
    "shared/*",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "@fa-lib/server/sv_rpc.lua",
    "server/*",
}

client_scripts {
    "@fa-lib/client/cl_rpc.lua",
    "@fa-lib/client/cl_interface.lua",
    "@fa-sync/client/lib.lua",
    "@fa-lib/client/cl_polyhooks.lua",
    "@fa-locales/client/lib.lua",
    "client/*",
}