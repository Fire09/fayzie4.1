fx_version "cerulean"

games { "gta5" }

description "NoProblem Gang System"

version "0.1.0"

server_script "@fyx/server/lib.js"
server_script "@fa-lib7/server/sv_asyncExports.js"

client_script "@fyx/client/lib.js"
client_script "@fa-lib7/client/cl_ui.js"

server_scripts {
    "build/server/sv_*.js",
}

client_scripts {
    "build/client/cl_*.js",
}
