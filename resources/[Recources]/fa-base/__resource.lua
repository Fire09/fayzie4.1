





resource_manifest_version "44febabe-d386-4d18-afbe-5e627f4af937"

dependency "ghmattimysql"



--client_script "@fa-errorlog/client/cl_errorlog.lua"
--[[=====JOBS=====]]--
server_script "server/sv_jobmanager.lua"
client_script "client/cl_jobmanager.lua"
server_script "shared/*.lua"
client_script "shared/*.lua"
shared_script "shared/*.lua"


-- INIT --
server_script "sh_init.lua"
client_script "sh_init.lua"

--[[=====EVENTS=====]]--
server_script "events/sv_events.lua"
client_script "events/cl_events.lua"

--[[=====CORE=====]]--
server_script "core/sh_core.lua"
server_script "core/sh_enums.lua"
-- utility
server_script "utility/sh_util.lua"
-- database
server_script "database/sv_db.lua"
server_script "core/sv_core.lua"
server_script "core/sv_characters.lua"

client_script "core/sh_core.lua"
client_script "core/sh_enums.lua"
-- utility
client_script "utility/sh_util.lua"
client_script "utility/cl_util.lua"

client_script "core/cl_core.lua"

--[[=====SPAWNMANAGER=====]]--
client_script "spawnmanager/cl_spawnmanager.lua"
server_script "spawnmanager/sv_spawnmanager.lua"

--[[=====PLAYER=====]]--
server_script "player/sv_player.lua"
server_script "player/sv_controls.lua"
server_script "player/sv_settings.lua"
server_script "player/sv_variables.lua"

client_script "player/cl_player.lua"
client_script "player/cl_controls.lua"
client_script "player/cl_settings.lua"
client_script "player/cl_variables.lua"

--[[=====BLIPMANAGER=====]]--
client_script "blipmanager/cl_blipmanager.lua"
client_script "blipmanager/cl_blips.lua"

--[[=====GAMEPLAY=====]]--
client_script "gameplay/cl_gameplay.lua"

--[[=====COMMANDS=====]]--
client_script "commands/cl_commands.lua"
server_script "commands/sv_commands.lua"

--[[=====INFINITY=====]]--
--client_script "@cn-lib/client/cl_infinity.lua"
--server_script "@cn-lib/server/sv_infinity.lua"

export "getModule"
export "addModule"
server_export "getChar"
server_export "getModule"
server_export "addModule"
