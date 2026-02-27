return {
    is_ip_rfc1918 = function(ip)
        KAMAILIO_CRASH_CHECK(debug.getinfo(1), 1, ip)
        if variables.ipops_is_ip_rfc1918 ~= nil then
            if type(variables.ipops_is_ip_rfc1918) == 'boolean' then
                return variables.ipops_is_ip_rfc1918 and 1 or -1
            end
            return variables.ipops_is_ip_rfc1918
        end
        return -1
    end
}
