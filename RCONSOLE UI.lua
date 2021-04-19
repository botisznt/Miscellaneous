local function Count(tbl)
    local c = 0
    for i, v in pairs(tbl) do
        c = c + 1
    end
    return c
end

local options = {
    ["AIMBOT"] = {
        ["ENABLED"] = false,
        ["Type"] = "Toggle"
    },
    ["FOV"] = {
        ["ENABLED"] = false,
        ["Type"] = "Toggle"
    },
    ["FOV SIZE"] = {
        ["VALUE"] = 50,
        ["Type"] = "InputBox",
        ["Min"] = -50,
        ["Max"] = 50
    },
    ["FOV PART"] = {
        ["OPTIONS"] = {"Mouse", "Character"},
        ["Type"] = "Dropdown",
        ["Selected"] = 1
    }
}

local n = Count(options)

local selected = 1

local function Reset()
    rconsoleclear()
    rconsoleprint('@@LIGHT_RED@@')
    rconsoleprint('Welcome to RCONSOLE')
    rconsoleprint('@@WHITE@@')
    rconsoleprint('\nInfo:\nPress the arrows to navigate and press ENTER\nto modify it!\n\nOptions:')
    local c = 0
    for i, v in pairs(options) do
        c = c + 1
        if selected == c then
            rconsoleprint('@@CYAN@@')
            rconsoleprint('\n' .. tostring(i) .. ": ")
        else
            rconsoleprint('@@WHITE@@')
            rconsoleprint('\n' .. tostring(i) .. ": ")
        end

        if v["Type"] == "Toggle" then
            if v["ENABLED"] == true then
                rconsoleprint('@@LIGHT_GREEN@@')
                rconsoleprint(tostring(v["ENABLED"]))
            else
                rconsoleprint('@@LIGHT_RED@@')
                rconsoleprint(tostring(v["ENABLED"]))
            end
        elseif v["Type"] == "InputBox" then
            rconsoleprint('@@LIGHT_RED@@')
            rconsoleprint(v["VALUE"])
            rconsoleprint('@@WHITE@@')
        elseif v["Type"] == "Dropdown" then
            local c2 = 0
            for u, x in pairs(v["OPTIONS"]) do
                c2 = c2 + 1
                if c2 == v["Selected"] then
                    rconsoleprint('@@LIGHT_RED@@')
                    rconsoleprint(x .. " ")
                    rconsoleprint('@@WHITE@@')
                else
                    rconsoleprint('@@WHITE@@')
                    rconsoleprint(x .. " ")
                end
            end
        end
        if c == n then
            rconsoleprint('\n')
        end
    end
    wait()
end

print("Step: 5")
Reset()
if n ~= 0 then
    local UIS = game:GetService("UserInputService")

    UIS.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Keyboard then
            if input.KeyCode == Enum.KeyCode.Up then
                selected = math.clamp(selected - 1, 1, n)
                Reset()
            end
            if input.KeyCode == Enum.KeyCode.Down then
                selected = math.clamp(selected + 1, 1, n)
                Reset()
            end
            if input.KeyCode == Enum.KeyCode.Return then
                local c1 = 0
                for i, v in pairs(options) do
                    c1 = c1 + 1
                    if c1 == selected then
                        if v["Type"] == "Toggle" then
                            v["ENABLED"] = not v["ENABLED"]
                            Reset()
                            print("---")
                            for i, v in pairs(options) do
                                print(i .. ": " .. tostring(v["ENABLED"]))
                            end
                        elseif v["Type"] == "InputBox" then
                            local prev = v["VALUE"]
                            rconsoleprint('@@WHITE@@')
                            local in_p = rconsoleinput()
                            if tonumber(in_p) then
                                v["VALUE"] = math.clamp(in_p, v["Min"], v["Max"])
                            else
                                v["VALUE"] = prev
                            end
                            Reset()
                        elseif v["Type"] == "Dropdown" then
                            local num = #v["OPTIONS"]
                            local prev = v["Selected"]
                            local cycle = prev + 1
                            if cycle > num then
                                cycle = 1
                            end
                            v["Selected"] = cycle
                            Reset()
                        end
                        break
                    end
                end
            end
        end
    end)
end
