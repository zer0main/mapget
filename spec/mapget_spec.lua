-- mapget, map downloader implemented in Lua
-- Copyright (C) 2015 Pavel Dolgov
-- See the LICENSE file for terms of use.

describe("mapget", function()

    it("requires main module", function()
        local mapget = assert(require 'mapget')
    end)

    it("downloads tile", function()
        local mapget = assert(require 'mapget')
        local socket = assert(require 'socket.http')
        local options = {}
        options.kind = map
        options.v = '4.40.1'
        options.x = '55'
        options.y = '79'
        options.z = '7'
        options.scale = '1'
        options.lang = 'ru_RU'
        local data = assert(mapget.mapget(socket, options))
    end)

    it("downloads tile correctly", function()
        local mapget = assert(require 'mapget')
        local magick = assert(require 'magick')
        local socket = assert(require 'socket.http')
        local options = {}
        options.kind = map
        options.v = '4.40.1'
        options.x = '55'
        options.y = '79'
        options.z = '7'
        options.scale = '1'
        options.lang = 'ru_RU'
        local data = assert(mapget.mapget(socket, options))
        local output = io.open("data.png", "w")
        output:write(data)
        output:close()
        local img = assert(magick.load_image("data.png"))
        for x = 0, img:get_width() do
            for y = 0, img:get_height() do
                local r, g, b, a = img:get_pixel(x, y)
                assert (r >= 144 and r <= 184) and
                       (g >= 170 and g <= 210) and
                       (b >= 200 and b <= 240)
            end
        end
        img:destroy()
    end)

end)
