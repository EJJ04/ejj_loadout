fx_version 'cerulean'
game 'gta5'

author 'EJJ_04'
description 'Loadout for FiveM'
version '1.0.0'
lua54 'yes'

files {
    'locales/*.json'
}

client_scripts {
    'config.lua',
    'client.lua',
}

server_scripts {
    'config.lua',
    'server.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
}
