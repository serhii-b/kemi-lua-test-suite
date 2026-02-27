local myPath = "kemi-test-suite.mocks.modules."

local modules = {
    "auth",
    "auth_db",
    "corex",
    "dispatcher",
    "tm",
    "dialplan",
    "hdr",
    "http_async_client",
    "http_client",
    "jsonrpcs",
    "kx",
    "maxfwd",
    "nathelper",
    "ipops",
    "permissions",
    "pv",
    "registrar",
    "rtpengine",
    "sanity",
    "sdpops",
    "siputils",
    "sl",
    "sqlops",
    "statsd",
    "tcpops",
    "textops",
    "uac",
    "textopsx",
    "xhttp",
}

local function generate(modules) 
    local init = {}
    for i in ipairs(modules) do
        init[modules[i]] = require(myPath..modules[i])
    end
    return init
end 

return generate(modules)