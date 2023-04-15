fx_version 'cerulean'
games {'gta5'}


shared_script "@mka-array/Array.lua"
shared_script "@fa-lib/shared/sh_cacheable.lua"

server_script {
	"@fa-lib/server/sv_infinity.lua",
	'@fa-lib/server/sv_rpc.lua',
	'server/sr_autoKick.lua',
	'server/carhud_server.lua',
}

client_script {
	"@fa-errorlog/client/cl_errorlog.lua",
	"@fa-lib/client/cl_infinity.lua",
	'@fa-lib/client/cl_rpc.lua',
	'client/newsStands.lua',
	'client/cl_playerbuffs.lua',
	'client/carhud.lua',
}

exports {
	"playerLocation",
	"playerZone"
}

