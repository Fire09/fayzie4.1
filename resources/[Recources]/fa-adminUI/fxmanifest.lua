games {'gta5'}

fx_version 'cerulean'

description "NoProblem AdminUI"

author "Sharlock"

client_scripts{
  "client/events.js",
  "client/events.lua"
}

server_scripts {
  "server/server.js",
}

ui_page 'nui/dist/index.html'

files {
  'nui/dist/index.html',
  'nui/dist/js/app.js',
  'nui/dist/css/app.css',
  'nui/dist/img/tablet.png'
}