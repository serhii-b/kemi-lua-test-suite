local function uac_replace_from(display, uri)
    KAMAILIO_CRASH_CHECK(debug.getinfo(1), 2, display, uri)
    variables['$var'].uac_replace_from = { display = display, uri = uri }
    return 1
end

local function uac_replace_from_uri(uri)
    KAMAILIO_CRASH_CHECK(debug.getinfo(1), 1, uri)
    variables['$var'].uac_replace_from_uri = uri
    return 1
end

local function uac_replace_to_uri(uri)
    KAMAILIO_CRASH_CHECK(debug.getinfo(1), 1, uri)
    variables['$var'].uac_replace_to_uri = uri
    return 1
end

return {
    uac_replace_from = uac_replace_from,
    uac_replace_from_uri = uac_replace_from_uri,
    uac_replace_to_uri = uac_replace_to_uri
}
