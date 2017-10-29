-- mapget, map downloader implemented in Lua
-- Copyright (C) 2015 Pavel Dolgov
-- See the LICENSE file for terms of use.

describe("mapget", function()

    it("requires main module", function()
        local mapget = assert(require 'mapget')
    end)

    it("downloads tile", function()
        local mapget = assert(require 'mapget')
        local options = {
            map_type = 'map',
            v = '4.40.1',
            x = '55',
            y = '79',
            z = '7',
            scale = '1',
            lang = 'ru_RU',
        }
        local data = assert(mapget.getTile(options))
    end)

    it("downloads tile correctly", function()
        local mapget = assert(require 'mapget')
        local magick = assert(require 'magick')
        local options = {
            map_type = 'map',
            v = '4.40.1',
            x = '55',
            y = '79',
            z = '7',
            scale = '1',
            lang = 'ru_RU',
        }
        local data = assert(mapget.getTile(options))
        local output = io.open("data", "w")
        output:write(data)
        output:close()
        local img = assert(magick.load_image("data"))
        for x = 0, img:get_width() do
            for y = 0, img:get_height() do
                local r, g, b, a = img:get_pixel(x, y)
                -- ocean: must be blue
                assert(
                    (r >= 0.65 and r <= 0.67) and
                    (g >= 0.81 and g <= 0.83) and
                    (b >= 0.90 and b <= 0.91)
                )
            end
        end
        img:destroy()
    end)

end)
