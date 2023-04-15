fx_version 'bodacious'
games {'gta5'}

description 'NoProblem Mechanics'
version '1.0.0'

client_scripts {
    "@fyx/client/lib.js",
    "@fa-lib/client/cl_ui.js",
    "@fa-lib/client/cl_ui.lua",
    "@fa-lib/client/cl_rpc.js",
    "@fa-lib/client/cl_rpc.lua",
    'client/cl_*.js',
    'client/cl_*.lua',
}

shared_scripts {
    "shared/sh_*.lua",
}

server_scripts {
    "@fyx/server/lib.js",
    "@fa-lib/server/sv_rpc.js",
    "@fa-lib/server/sv_rpc.lua",
    'server/sv_*.js',
    'server/sv_*.lua',
}