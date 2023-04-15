fx_version 'cerulean'
games {'gta5'}


--[[ dependencies {
    "PolyZone"
} ]]--

client_script "@fa-errorlog/client/cl_errorlog.lua"
client_script "@PolyZone/client.lua"

ui_page 'nui/ui.html'

files {
  "nui/ui.html",
  "nui/pricedown.ttf",
  "nui/default.png",
  "nui/background.png",
  "nui/weight-hanging-solid.png",
  "nui/hand-holding-solid.png",
  "nui/search-solid.png",
  "nui/invbg.png",
  "nui/styles.css",
  "nui/scripts.js",
  "nui/debounce.min.js",
  "nui/loading.gif",
  "nui/loading.svg",
  "nui/icons/*"
}

shared_script 'shared_list.js'
shared_script '@fa-lib/shared/sh_cacheable.js'

client_scripts {
  "@fa-sync/client/lib.lua",
  "@fa-lib/client/cl_ui.lua",
  "@fa-lib/client/cl_rpc.js",
  "@fa-lib/client/cl_rpc.lua",
  'client.js',
  'functions.lua',
  'cl_vehicleweights.js',
  'cl_craftingspots.js',
  'cl_attach.lua',
  'cl_actionbar.lua',
}

server_scripts {
  '@fa-lib/server/sv_asyncExports.js',
  "@fa-lib/server/sv_fyx.js",
  "@fa-lib/server/sv_rpc.js",
  "sv_config.js",
  "sv_clean.js",
  'server_degradation.js',
  'server_shops.js',
  'server.js',
  "sv_functions.js",
  'sv_craftingspots.js',
  'server.lua',
}

exports{
  'getFreeSpace',
  'hasEnoughOfItem',
  'getQuantity',
  'GetCurrentWeapons',
  'GetItemInfo',
  'GetInfoForFirstItemOfName',
  'getFullItemList',
}

-- dependency 'fa-lib'
