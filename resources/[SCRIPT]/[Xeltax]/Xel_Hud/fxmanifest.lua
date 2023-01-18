fx_version 'adamant'

game 'gta5'

description 'Xel_Hud'

version 'legacy'

lua54 'yes'

ui_page 'html/index.html'

files {
	'html/index.html',
	'html/style.css',
	'html/script.js'
}

shared_script '@es_extended/imports.lua'

server_scripts {
	'server.lua'
}

client_scripts {
	'client.lua',
}
