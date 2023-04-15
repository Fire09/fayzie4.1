





fx_version 'cerulean'
games { 'gta5' }

client_script "@fa-lib/client/cl_interface.lua"

client_scripts {
  "@fa-lib/shared/sh_util.lua"
}

shared_scripts {
  "shared/sh_*.lua"
}

client_scripts {
  "@fa-locales/client/lib.lua",
  "client/cl_*.lua",
  "client/entries/cl_*.lua"
}

ui_page "html/ui.html"

files {
  "html/ui.html",
  "html/js/*.js",
  'html/css/*.css',
  'html/webfonts/*.eot',
  'html/webfonts/*.svg',
  'html/webfonts/*.ttf',
  'html/webfonts/*.woff',
  'html/webfonts/*.woff2'
}
