-- *************************************************
-- ****            FREE fa-FIBER 2.1            ****
-- *** Author: Seter#0909 | Project: NoPicks 3.5 ***
-- ****      https://discord.gg/QZ4XAPUVps      ****
-- *************************************************

fx_version "cerulean"

games { "gta5" }

author "Seter#0909"
description "NoPicks 3.5 Fiber"
url "https://discord.gg/QZ4XAPUVps"

version "2.1.0"

ui_page 'nui/index.html'

files {
    'nui/**/*',
}

client_script "@fyx/client/lib.js"

server_script "@fyx/server/lib.js"

server_scripts {
    "server/sv_*.js",
}

client_scripts {
    "client/cl_*.js",
}