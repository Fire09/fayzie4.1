fx_version "cerulean"
games { "gta5" }

ui_page "client/html/index.html"

files {
    "client/html/*.html",
    "client/html/*.js",
    "client/html/*.css",
    "client/html/webfonts/*.eot",
    "client/html/webfonts/*.svg",
    "client/html/webfonts/*.ttf",
    "client/html/webfonts/*.woff",
    "client/html/webfonts/*.woff2",
    "client/html/css/*",
}

shared_scripts {
    "@fa-lib/shared/sh_util.lua",
    "@fa-lib/shared/sh_ids.lua",
}
 
server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "@fa-lib/server/sv_rpc.lua",
    "server/sv_*.lua",
}

client_scripts {

    '@fa-lib/client/cl_ui.lua',
    '@fa-lib/client/cl_interface.lua',
    "@fa-lib/client/cl_rpc.lua",
    "@fa-lib/client/cl_state.lua",
    "client/cl_tattooshop.lua",
    "client/cl_*.lua",
}

export "CreateHashList"
export "GetTatCategs"
export "GetCustomSkins"