fx_version 'adamant'

game 'gta5'

description 'Test WarMenu'

version 'legacy'

shared_script '@es_extended/imports.lua'

client_scripts {
    'src/RageUI.lua',
    'src/Menu.lua',
    'src/MenuController.lua',
    'src/components/*.lua',
    'src/elements/*.lua',
    'src/items/*.lua',

    'client.lua',
    'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'server.lua'
}