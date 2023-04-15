fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'faye'
description 'Boosting Script'
version '1.2.0'
lua54 'yes'

shared_scripts {
  'config/config.lua',
  'client/cl_utils.lua',
}

client_scripts {
  'client/cl_*.lua',
  'config/client_config.lua',
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  --'@mysql-async/lib/MySQL.lua',    --UNCOMMENT ONLY IF YOU USE MYSQL-ASYNC
  'config/server_config.lua',
  'server/sv_*.lua'
}

ui_page 'build/index.html'

files {
  'build/index.html',
  'build/static/js/*.js',
  'build/static/css/*.css',
  'build/static/media/*.svg',
  'build/static/media/*.mp3',
}

escrow_ignore { 
  'config/*.lua'
}

exports {
  'pCanUseLaptop',
  'pCanFinishScratch'
}