fx_version 'cerulean'
games { 'rdr3', 'gta5' }

-- --[[ dependencies {
--   "fa-lib",
--   "fa-ui"
-- } ]]--

server_scripts {
  '@fa-lib/server/sv_rpc.lua',
  '@fa-lib/server/sv_sql.lua',
  'server/config.lua',
  'server/sv_*.lua',
}

lua54 'yes'