local auth_db = {
     auth_check = function(realm, db_table, flags)
         KAMAILIO_CRASH_CHECK(debug.getinfo(1), 3, realm, db_table, flags)

	 if variables.auth_check_result ~= nil then
             if type(variables.auth_check_result) == "boolean" then
                 return variables.auth_check_result and 1 or -1
             end
             return tonumber(variables.auth_check_result) or variables.auth_check_result
         end

         return 1
     end
}

return auth_db
