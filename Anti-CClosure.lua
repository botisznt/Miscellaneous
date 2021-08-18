local pass = 0;
local RS1 = ""
while true do
    if pass > 500 then
        break
    end
    if pass == 89 then
        RS1 = tostring(function() end)
    end
    tostring(function() end)
    pass = pass + 1
end

local FunctionList = { -- Table containing all function possibilities
    [0] = {
        f = pcall,
        r = "missing argument #1",
        c = true,
        s = false
    },
    [1] = {
        f = xpcall,
        r = "missing argument #2 to 'xpcall' (function expected)",
        c = true,
        s = false
    },
    [2] = {
        f = pcall,
        r = "attempt to call a boolean value",
        c = true,
        s = false,
        a = {function() end}
    },
    [3] = {
        f = xpcall,
        r = "attempt to call a boolean value",
        c = true,
        s = false,
        a = {function() end, function() end}
    },
	[4] = {
		f = syn.request,
		r = "bad argument #1 to '?' (table expected, got no value)",
		c = true,
		s = false
    },
    [5] = {
        f = getconstants,
        r = "bad argument #1 to '?' (function or number expected)",
        c = true,
        s = false
    },
    [6] = {
        f = getconstants,
        r = "attempt to call a table value",
        c = true,
        s = false,
        a = {function() end}
    },
    [7] = {
        f = getconstants,
        r = "attempt to call a table value",
        c = true,
        s = false,
        a = {1}
    },
    [8] = {
        f = string.byte,
        r = "missing argument #1 to 'byte' (string expected)",
        c = true,
        s = false
    },
    [9] = {
        f = function() end,
        r = nil,
        c = false,
        s = true
    },
    [10] = {
        f = function() return RS1 end,
        r = RS1,
        c = false,
        s = true
    },
    [11] = {
        f = function() return false end,
        r = false,
        c = false,
        s = true
    },
    [12] = {
        f = function() return true end,
        r = true,
        c = false,
        s = true
    }
} -- End of table

local FunctionIncrement = 0;
local LocalEnv = getfenv()
local allChecksPassed = false; -- Determine if the function increment == x then return true
while true do -- Prevent "pairs()" hooking
    if not FunctionList[FunctionIncrement] and (FunctionIncrement == #FunctionList + 1) then -- Determine if there's another function to be "tested", and determine if the increment is +1 to the FunctionList entries
        allChecksPassed = true
		break; -- Break the loop, non-continuous
	end
	local Function = FunctionList[FunctionIncrement]["f"]
	local Return = FunctionList[FunctionIncrement]["r"]
	local toBeCalled = FunctionList[FunctionIncrement]["c"]
	local willBeSuccessful = FunctionList[FunctionIncrement]["s"]
    local Args = FunctionList[FunctionIncrement]["a"]

    if Args then
        local functionCalled = false;
        setfenv(0, {tostring = function() while true do end end})
        xpcall(Function(unpack(Args)), function(s) -- Get the Closure of the function
            functionCalled = true
			if s and s ~= Return then -- Determine if the function is a CCLosure or an SClosure
				while true do
				end
			end
        end)
        setfenv(0, LocalEnv)
        if not functionCalled and toBeCalled then -- Determine is the xpcall is being tampered with
			while true do
			end
        end
        functionCalled = false
        setfenv(0, {tostring = function() while true do end end})
		local Success, Data = pcall(Function(unpack(Args))) -- Get the CCLosure of the function in Data, and whether the function successfully ran in a protected call (Success)
		if (not willBeSuccessful == Success) or willBeSuccessful ~= Success then -- Determine is all values were returned correctly
			while true do
			end
		end
        setfenv(0, LocalEnv)
		if Data ~= Return then -- Determine if the function is a CCLosure or an LClosure, as well as some sanity checks
			while true do
			end
        end
    else
        -- Same thing but without aruments
		local functionCalled = false;
        setfenv(0, {tostring = function() while true do end end})
		xpcall(Function, function(s)
			functionCalled = true
			if s and s ~= Return then
				while true do
				end
			end
		end)
        setfenv(0, LocalEnv)
		if not functionCalled and toBeCalled then
			while true do
			end
		end
		functionCalled = false
        setfenv(0, {tostring = function() while true do end end})
		local Success, Data = pcall(Function)
		if (not willBeSuccessful == Success) or willBeSuccessful ~= Success then
			while true do
			end
		end
        setfenv(0, LocalEnv)
		if Data ~= Return then
			while true do
			end
		end
	end
	FunctionIncrement = FunctionIncrement + 1 -- Increase the increment
end

if not allChecksPassed then -- Determine if any OPCode hooking occured
    while true do end
end
					
-- made by octo
