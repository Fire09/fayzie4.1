fx_version "cerulean"

games { "gta5" }

description "NoProblem Boilerplate"

version "0.1.0"


shared_script "@fa-lib/shared/sh_cacheable.js"
shared_script "@fa-lib/shared/sh_cacheable.lua"

server_script "@fyx/server/lib.js"
server_script "@fa-lib/server/sv_asyncExports.js"

client_script "@fyx/client/lib.js"
client_script "@fa-lib/client/cl_ui.js"

server_scripts {
    "build/server/*.js",
}

client_scripts {
    "build/client/*.js",
}
