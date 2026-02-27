return {
    is_request = function()
        if variables["$rs"] then
            return -1
        end
        return 1
    end,
    is_reply = function()
        if variables["$rs"] then
            return 1
        end
        return -1
    end,
    has_totag = function()
        if variables["$tt"] then
            return 1
        end
        return -1
    end,
    add_uri_param = function(param)
        KAMAILIO_CRASH_CHECK(debug.getinfo(1),1,param)
        if not variables["$var"].uri_params then
            variables["$var"].uri_params = {}
        end
        table.insert(variables["$var"].uri_params, param)
        return 1
    end
}
