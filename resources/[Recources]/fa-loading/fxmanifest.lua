fx_version 'cerulean'

description 'Newcastle - Loading'
author 'cool'
version '0.0.1'

lua54 'yes'

game 'gta5'

loadscreen 'web/build/index.html'
loadscreen_manual_shutdown 'yes'
loadscreen_cursor 'yes'
client_script 'client/client.js'
client_script 'client/client.lua'

files {
    'web/build/**/*',
}