-- mapget, map downloader implemented in Lua
-- Copyright (C) 2015 Pavel Dolgov
-- See the LICENSE file for terms of use.

local mapget = {}

-- TODO: check headers order!

local headers_frame = {}
headers_frame['User-Agent'] = 'Mozilla/5.0 (Windows NT 6.1; rv:52.0) Gecko/20100101 Firefox/52.0'
headers_frame['Accept'] = '*/*'
headers_frame['Accept-Language'] = 'en-US,en;q=0.5'
headers_frame['Accept-Encoding'] = 'gzip, deflate, br'
headers_frame['Referer'] = 'blablabla'
headers_frame['Connection'] = 'keep-alive'

function mapget.getTile(options)
    local http = require('socket.http')
    local ltn12 = require('ltn12')
    local subdomain = ''
    if options.map_type == 'map' then
        subdomain = 'vec'
    else
        subdomain = 'sat'
    end
    headers_frame['Host'] = subdomain .. '01.maps.yandex.net'
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
    local data = {}
    http.request{
        url = url,
        sink = ltn12.sink.table(data),
        headers = headers_frame
    }
    return table.concat(data)
end

return mapget
