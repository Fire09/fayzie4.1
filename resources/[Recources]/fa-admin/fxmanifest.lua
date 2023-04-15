fx_version "cerulean"
games { "gta5" }

shared_script {
    "@fa-lib/shared/sh_util.lua",
    "@fa-lib/shared/sh_cacheable.js",
}

server_scripts {
    "@fa-lib/server/sv_fyx.js",
    "@fa-lib/server/sv_rpc.js",
    "@fa-lib/server/sv_rpc.lua",
    "@fa-lib/server/sv_sql.lua",
    "@fyx/server/lib.js",
    "server/*",
}

client_scripts {
    "@fyx/client/lib.js",
    "@fa-lib/client/cl_rpc.js",
    "client/*",
}
