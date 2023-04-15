fx_version "cerulean"
games { "gta5" }

ui_page "html/index.html"

files {
    "html/*.html",
	"html/*.css",
    "html/*.js",
    "html/fonts/*.ttf",
    "imgs/*.png",
	"imgs/brands/*.png",
}

shared_scripts {
    "@fa-lib/shared/sh_util.lua",
    "shared/sh_*.lua",
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "@fa-lib/server/sv_rpc.lua",
    "server/sv_*.lua",
}

client_scripts {
    "@fa-sync/client/lib.lua",
    "@fa-lib/client/cl_rpc.lua",
    "@fa-lib/client/cl_ui.lua",
    "client/cl_*.lua",
}