fx_version 'cerulean'
games {'gta5'}

client_script '@fa-lib/client/cl_rpc.lua'
client_script 'respawn.lua'

server_script 'sv_main.lua'

exports {
    'GetDeathStatus',
}