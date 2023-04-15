fx_version "cerulean"

description "Newcastle - Config"
author "cool"
version '0.0.1'

game "gta5"

server_script '@fa-lib/server/sv_sql.js'
server_script '@fa-lib/server/sv_rpc.js'
server_script 'server/*.js'

client_script '@fa-lib/client/cl_rpc.js'
client_script 'client/*.js'