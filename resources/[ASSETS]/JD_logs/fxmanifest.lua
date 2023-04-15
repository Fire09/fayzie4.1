--[[
    #####################################################################
    #                _____           __          _                      #
    #               |  __ \         / _|        | |                     #
    #               | |__) | __ ___| |_ ___  ___| |__                   #
    #               |  ___/ '__/ _ \  _/ _ \/ __| '_ \                  #
    #               | |   | | |  __/ ||  __/ (__| | | |                 #
    #               |_|   |_|  \___|_| \___|\___|_| |_|                 #
    #                                                                   #
    #                 JD_logs By Prefech 01-11-2021                     #
    #                         www.prefech.com                           #
    #                                                                   #
    #####################################################################
]]


version '2.1.7.12b'
author 'Prefech'
description 'FXServer logs to Discord (https://prefech.com/)'
repository 'https://github.com/prefech/JD_logs'

-- Server Scripts
server_scripts {
    'server/server.lua',
    'server/functions.lua',
    'server/explotions.lua',
    'server/serverAC.lua',
    'config/notifications.lua'
}

--Client Scripts
client_scripts {
    'client/client.lua',
    'client/functions.lua',
    'client/weapons.lua',
    'client/clientAC.lua'
}

files {
    'config/eventLogs.json',
    'config/config.json',
    'locals/*.json'
}

lua54 'yes'
game 'gta5'
fx_version 'cerulean'
