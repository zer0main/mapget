-- mapget, map downloader implemented in Lua
-- Copyright (C) 2015 Pavel Dolgov
-- See the LICENSE file for terms of use.

package = "mapget"
version = "dev-1"
source = {
    url = "git@github.com:zer0main/mapget.git",
}
description = {
    summary = "Map downloader implemented in Lua",
    homepage = "https://github.com/zer0main/mapget",
    license = "MIT",
}
dependencies = {
    "lua >= 5.1",
}
build = {
    type = "builtin",
    modules = {
        ['mapget'] = 'src/mapget/mapget.lua',
    },
}
