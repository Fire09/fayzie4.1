fx_version 'cerulean'
games { 'rdr3', 'gta5' }

client_scripts {
    "@fa-lib/client/cl_rpc.lua",
    "@fa-lib/client/cl_interface.lua",
    'client/*.lua'
}

server_scripts {
    "@fa-lib/server/sv_rpc.lua",
    'server/*.lua'
}
 