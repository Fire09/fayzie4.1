





resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

--resource_type 'gametype' { name = 'Hot Putsuit' }
client_script "@fa-errorlog/client/cl_errorlog.lua"

-- server_script "@fa-fml/server/lib.lua"
client_script "@fa-infinity/client/cl_lib.lua"
server_script "@fa-infinity/server/sv_lib.lua"

server_script "server.lua"
client_script "client.lua"
