fx_version 'cerulean'
game 'gta5'
version '1.0.0'

client_script "@fyx/client/lib.js"
client_script "@fa-lib/client/cl_ui.js"
client_script "build/client.js"

server_script "@fyx/server/lib.js"
server_script '@fa-lib/server/sv_sql.js'
server_script "build/server.js"
server_script "@fa-lib/server/sv_asyncExports.js"
server_script "@fa-lib/server/sv_fyx.js"
