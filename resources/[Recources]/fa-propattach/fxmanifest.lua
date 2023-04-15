fx_version 'cerulean'
games {'gta5'}

client_scripts {
  "cl_*.lua"
}

server_scripts {
  '@fa-lib/server/sv_rpc.lua',
  'server.lua'
}

export "canPullWeaponHoldingEntity"