fx_version "cerulean"

games {"gta5"}

description "NPCs Handler"

version "0.1.0"

client_script "@fa-lib/client/cl_flags.lua"
client_script '@fa-lib/client/cl_main.lua'
server_script '@fa-lib/server/sv_main.lua'

client_scripts {
  "client/classes/*.lua",
  "client/*.lua"
}

shared_scripts {
  "@fa-lib/shared/sh_util.lua",
  "shared/sh_*.lua"
}

server_scripts {
  "server/sv_*.lua"
}
