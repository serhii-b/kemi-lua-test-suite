return {

    sanity_check = function(flag1, flag2)
        KAMAILIO_CRASH_CHECK(debug.getinfo(1),2,flag1,flag2)
        if variables.sanity_check_result ~= nil then
            if type(variables.sanity_check_result) == "boolean" then
                return variables.sanity_check_result and 1 or -1
            end
            return tonumber(variables.sanity_check_result) or variables.sanity_check_result
        end
        return 1
    end

}
