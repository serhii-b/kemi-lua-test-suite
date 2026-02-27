local function connect(host, port)
    KAMAILIO_CRASH_CHECK(debug.getinfo(1),2,host,port)
    if variables.redis_connect_result == false then
        error(variables.redis_connect_error or "Connection refused")
    end
    return {
        ping = function()
            return true
        end
    }
end

return {
    connect = connect
}
