local GCI = 0;
local SF = 0;
local PCC = 0;
local ALH = 0;

local GCRegister = function(C)
    if tostring(C) == 'hookfunction' then
        ALH = ALH + 1
        if ALH >= 3 then
            game:GetService("Players").LocalPlayer:Kick("Fuck you")
        end
    end
end

while true do
    GCI = GCI + 1
    if getgc()[GCI] == nil then break; end
    local GCF = getgc()[GCI]
    local FC = false;
    if is_synapse_function(GCF) then
        SF = SF + 1
        local CPC = pcall(function() getconstants(GCF) end)
        local CPCD = pcall(function() debug.getconstants(GCF) end)
        if CPC or CPCD then
            PCC = PCC + 1
            local GCC = 0;
            while true do
                if #getconstants(GCF) == GCC or #getconstants(GCF) == GCC then break; end
                GCC = GCC + 1
                local C = CPC and getconstants(GCF)[GCC] or debug.getconstants(GCF)[GCC]
                GCRegister(C)
            end
        end
    end
end

if SF < 300 or GCI < 2000 or PCC < 100 or ALH >= 3 then
    game:GetService("Players"):Kick("Fuck you")
end
