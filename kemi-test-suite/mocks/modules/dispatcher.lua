return {
    ds_is_from_list_uri = function(set, flags, uri)
        KAMAILIO_CRASH_CHECK(debug.getinfo(1), 3, set, flags, uri)
        if variables.dispatcher_is_from_list_uri ~= nil then
            if type(variables.dispatcher_is_from_list_uri) == 'boolean' then
                return variables.dispatcher_is_from_list_uri and 1 or -1
            end
            return variables.dispatcher_is_from_list_uri
        end
        return -1
    end
}
