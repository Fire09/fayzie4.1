fx_version 'cerulean'
game 'gta5'

client_script "@fa-errorlog/client/cl_errorlog.lua"
client_script '@fa-lib/client/cl_interface.lua'
client_script "client/cl_duty.lua"
client_script "client/cl_hire.lua"
server_script "@fa-lib/server/sv_sql.lua"
server_script "server/sv_duty.lua"
server_script "server/sv_hire.lua"


exports {
	'LawAmount'
}