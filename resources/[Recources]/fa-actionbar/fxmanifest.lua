





fx_version 'cerulean'
games {"gta5"}

description "actionbar"

client_scripts {
  "@fa-errorlog/client/cl_errorlog.lua",
  '@fa-lib/client/cl_rpc.lua',
  "client.lua",
}

shared_script {
  '@fa-lib/shared/sh_util.lua'
}

server_scripts {
  '@fa-lib/server/sv_rpc.lua',
  '@fa-lib/server/sv_sql.lua',
}