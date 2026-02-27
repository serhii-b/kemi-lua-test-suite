local json = require "cjson.safe"
local colors = require "kemi-test-suite.colors"

local internalLogging = false

local function splitString (inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function KAMAILIO_CRASH_CHECK(...) 
    local args={...}
    if not args[1] and not args[2] then
        print(colors("\n%{bright yellow}KAMAILIO_CRASH_CHECK(...) %{white}has to receive at least 2 params:\n - arg[1]:   debug.getinfo(1)\n - arg[2]:   number of KSR.module.function params\n - arg[2+x]: params passed into function\n"))
        os.exit()
    end
    local funcDetails=args[1]
    local numOfParams=args[2]
    if numOfParams > 0 then
        for i=3,(2+numOfParams) do
            if not args[i] then
                local moduleName = string.match(funcDetails.short_src,"/([%w_]+).lua")
                print(colors("\n%{bright red}Call of the %{reset}%{blue}KSR.%{magenta}"..moduleName..".%{yellow}"..funcDetails.name.."(%{red}<here_is_your_params>%{white}) %{bright red} will cause crash of the kamailio during runTime.\n It wil happend because some of the params wasn't passed.\n Fix the script, read the docks and come back again\n"))
                os.exit()
            end
        end
    end
end

local METHODS = {
    "INVITE",
    "PRACK",
    "ACK",
    "BYE",
    "UPDATE",
    "CANCEL",
    "REFER",
    "MESSAGE",
    "PUBLISH",
    "NOTIFY",
    "SUBSCRIBE",
    "REGISTER",
    "OPTIONS",
    "INFO",
    "GET",
    "POST",
    "PUT",
    "DELETE"
}

local defaults = require("kemi-test-suite.mocks.variables")

local mockModules = require("kemi-test-suite.mocks.modules.init")
local mockRedis = require("kemi-test-suite.mocks.redis")

local function init(testData,mocks)
   
    variables = defaults(testData)
    
    -- fill user defined variables that not in a list
    for k,v in pairs(testData) do
        if not variables[k] then
            variables[k] = v
        end
    end
    -- changed variables that should be affected AFTER all packet handing script done
    local changed = {}

    internalLogging = testData.internalLogging or false
  
    local force_rport = function ()
        return
    end

    local isdsturiset = function ()
        if not variables["$du"] then
            return false
        end
        return true
    end

    local is_method_in = function(str)
        KAMAILIO_CRASH_CHECK(debug.getinfo(1),1,str)
        local method = variables["$rm"]
        if not method then
            return false
        end
        local map = {
            I = "INVITE",
            R = "REGISTER",
            S = "SUBSCRIBE",
            M = "MESSAGE"
        }
        for i = 1, #str do
            local flag = str:sub(i,i)
            if map[flag] == method then
                return true
            end
        end
        return false
    end

    local forward = function ()
        return
    end

    local x = {
        exit = function()
            variables.exit_called = true
            if variables and variables.disable_exit then
                return true
            end
            --@TODO: os.exit is bad solution, replace with something that not destroys script
            os.exit()
        end
    }

    local printLog = function (...)
        if internalLogging then
            print(...)
        end
    end


    --  >= 5.0
    local modules = {
        log             = printLog,
        info            = printLog,
        dbg             = printLog,
        warn            = printLog,
        err             = printLog,
        changed         = changed,
        force_rport     = force_rport,
        isdsturiset     = isdsturiset,
        is_method_in    = is_method_in,    
        forward         = forward,
        x               = x
    }

    for i=1,#METHODS do
        modules["is_"..METHODS[i]] = function() 
            if variables["$rm"] == METHODS[i] then
                return true
            end
            return false
        end
    end

    for k,v in pairs(mockModules) do
        modules[k] = v
    end

    package.loaded["KSR"] = modules
    package.loaded["redis"] = mockRedis

    _G["KSR"] = package.loaded["KSR"]
    _G["redis"] = package.loaded["redis"]
    
    return internalLogging
end

return {
    init = init
}
