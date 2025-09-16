fx_version 'cerulean'
game 'gta5'

author 'Nucleus Framework'
description 'Nucleus Framework - A basic FiveM framework'
version '1.0.0'

shared_scripts {
    'shared/config.lua',
    'shared/main.lua'
}

client_scripts {
    'client/main.lua',
    'client/events.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'startup.lua',
    'server/main.lua',
    'server/events.lua',
    'server/player.lua',
    'test_framework.lua'
}

dependencies {
    'oxmysql'
}

lua54 'yes'
