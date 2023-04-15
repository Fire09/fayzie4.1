fx_version "cerulean"

description "NoProblem - Vehicles"
author "Sharlock"
version '0.0.1'

game "gta5"

server_script {
    '@fyx/server/lib.js',
    '@fa-lib/server/sv_rpc.js',
    '@fa-lib/server/sv_sql.js',
    '@fa-lib/server/sv_rpc.lua',
    'dist/server/**/*.js',
    'server/sv_*.lua',
}

client_script {
    '@fyx/client/lib.js',
    '@fa-lib/client/cl_rpc.js',
    '@fa-lib/client/cl_ui.js',
    '@fa-lib/client/cl_rpc.lua',
    '@fa-lib/client/cl_ui.lua',
    'client/cl_*.lua',
    'dist/client/**/*.js',
}