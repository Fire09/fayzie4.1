game 'gta5'
fx_version 'adamant'
lua54 'yes'


server_script '@fa-lib/server/sv_rpc.lua'
server_script 'sv_main.lua'
client_script "@fa-lib/client/cl_interface.lua"

client_script {
    '@fa-lib/client/cl_rpc.lua',
    '@fa-lib/client/cl_ui.lua',
    'cl_main.lua',
    'config.lua'
}
