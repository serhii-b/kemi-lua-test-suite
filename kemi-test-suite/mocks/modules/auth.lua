local auth = {
    auth_challenge = function(realm, flags)
        KAMAILIO_CRASH_CHECK(debug.getinfo(1),2,realm,flags)
        variables["$var"].auth_challenge = {
            realm = realm,
            flags = flags
        }
        return 1
    end,
    consume_credentials = function()
        KAMAILIO_CRASH_CHECK(debug.getinfo(1),0)
        variables["$var"].consumed = true
        return 1
    end
}

return auth
