-- mapget, map downloader implemented in Lua
-- Copyright (C) 2015 Pavel Dolgov
-- See the LICENSE file for terms of use.

local function mapget(socket, options)
    local URL = "https://vec04.maps.yandex.net/tiles?l=%s&v" ..
                "=%s&x=%s&y=%s&z=%s&scale=%s&lang=%s"
    URL:format(options.kind, options.v, options.x, options.y,
               options.z, options.scale, options.lang)
    local data, inf, spec = socket.request(URL)
    return data
end

return {
    mapget = 'mapget',
}
