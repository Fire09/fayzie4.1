





fx_version "adamant"

games {"gta5"}

description "Infinity Helper"

version "1.0.0"


client_script '@fa-lib/client/cl_rpc.lua'
server_script '@fa-lib/server/sv_rpc.lua'

client_scripts {
    "client/classes/*.lua",
    "client/cl_*.lua"
}

server_scripts {
    "server/sv_*.lua"
}

server_script "tests/sv_*.lua"
client_script "tests/cl_*.lua"
