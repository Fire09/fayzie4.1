fx_version 'cerulean'
games {'gta5'}

client_script {
    '@fa-lib/client/cl_rpc.lua',
    'respawn.lua',
    'cl_health.lua',
}

server_script '@fyx/server/lib.js'
client_script '@fyx/client/lib.js'
shared_script '@fyx/shared/lib.lua'

server_script {
    "@oxmysql/lib/MySQL.lua",
    "@fa-lib/server/sv_rpc.lua",
    'server.lua',
    'sv_health.lua',
}
