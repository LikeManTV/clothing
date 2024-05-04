fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'LikeManTV'
description 'Metadata-based clothing system.'
version '1.0.1'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
    'shared/locale.lua',
    'locales/*.lua'
}

client_scripts {
    "bridge/**/**/**/client.lua",
    'client/cl_class.lua',
    'client/cl_clothing.lua',
    'client/cl_gear.lua'
}

server_scripts {
    "bridge/**/**/**/server.lua",
    'server/sv_clothing.lua'
}

files {
    'data/arms.json',
    'data/gloves.json',
    'data/torso_male.json',
    'data/torso_female.json'
}