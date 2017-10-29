-- mapget, map downloader implemented in Lua
-- Copyright (C) 2015 Pavel Dolgov
-- See the LICENSE file for terms of use.

local mapget = {}

function mapget.getTile(socket, options)
    local subdomain = ''
    if options.map_type == 'map' then
        subdomain = 'vec'
    else
        subdomain = 'sat'
    end
    local url_frame = "https://%s01.maps.yandex.net/tiles?l=%s&v" ..
                      "=%s&x=%s&y=%s&z=%s&scale=%s&lang=%s"
    local url = url_frame:format(
        subdomain,
        options.map_type,
        options.v,
        options.x,
        options.y,
        options.z,
        options.scale,
        options.lang
    )
    local data, inf, spec = socket.request(url)
    return data
end

return mapget
