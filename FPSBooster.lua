-- // MADE BY Blissful#4992 / CornCatCornDog on v3rmillion // --

local Space = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

local savedStates = {}

local workspaceAdded
local lightingAdded

function _G.FPS_Boost(bool)
    if (bool) then
        local SETTINGS = _G.Settings
        savedStates = {}

        if SETTINGS.Change_Graphics then
            savedStates["Technology"] = gethiddenproperty(Lighting, "Technology")
            sethiddenproperty(Lighting, "Technology", "Compatibility")
        end
        if SETTINGS.No_Shadows then
            savedStates["Shadows"] = Lighting.GlobalShadows
            Lighting.GlobalShadows = false
        end

        -- WORKSPACE
        local Objs = Space:GetDescendants()
        for i = 1, #Objs do
            local v = Objs[i]
            if SETTINGS.Change_Materials and v:IsA("BasePart") then
                savedStates[v:GetFullName()] = {Material = v.Material}
                v.Material = Enum.Material.SmoothPlastic
            end

            if SETTINGS.Hide_Decals and (v:IsA("Decal") or v:IsA("Texture")) then
                savedStates[v:GetFullName()] = {Transparency = v.Transparency}
                v.Transparency = 1
            end
        end

        if workspaceAdded then workspaceAdded:Disconnect() end
        workspaceAdded = Space.DescendantAdded:Connect(function(v)
            if SETTINGS.Change_Materials and v:IsA("BasePart") then
                savedStates[v:GetFullName()] = {Material = v.Material}
                v.Material = Enum.Material.SmoothPlastic
            end

            if SETTINGS.Hide_Decals and (v:IsA("Decal") or v:IsA("Texture")) then
                savedStates[v:GetFullName()] = {Transparency = v.Transparency}
                v.Transparency = 1
            end
        end)

        -- LIGHTING
        if lightingAdded then lightingAdded:Disconnect() end
        if SETTINGS.Worse_Lighting then
            local LightObjs = Lighting:GetDescendants()
            for i = 1, #LightObjs do
                local v = LightObjs[i]
                if v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect") then
                    savedStates[v:GetFullName()] = {Enabled = v.Enabled}
                    v.Enabled = 0
                end
            end

            lightingAdded = Lighting.DescendantAdded:Connect(function(v)
                if v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect") then
                    savedStates[v:GetFullName()] = {Enabled = v.Enabled}
                    v.Enabled = 0
                end
            end)
        end
    else
        if workspaceAdded then workspaceAdded:Disconnect() end
        if lightingAdded then lightingAdded:Disconnect() end

        if savedStates["Technology"] ~= nil then
            sethiddenproperty(Lighting, "Technology", savedStates["Technology"])
        end
        if savedStates["Shadows"] ~= nil then
            Lighting.GlobalShadows = savedStates["Shadows"]
        end

        -- WORKSPACE
        local Objs = Space:GetDescendants()
        for i = 1, #Objs do
            local v = Objs[i]
            if v:IsA("BasePart") then
                local saved = savedStates[v:GetFullName()]
                if saved ~= nil then 
                    v.Material = saved.Material
                end
            end

            if v:IsA("Decal") or v:IsA("Texture") then
                local saved = savedStates[v:GetFullName()]
                if saved ~= nil then 
                    v.Transparency = saved.Transparency
                end
            end
        end

        -- LIGHTING
        local LightObjs = Lighting:GetDescendants()
        for i = 1, #LightObjs do
            local v = LightObjs[i]
            if v:IsA("BlurEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("SunRaysEffect") then
                local saved = savedStates[v:GetFullName()]
                if saved ~= nil then 
                    v.Enabled = saved.Enabled
                end
            end
        end

        savedStates = {}
    end
end
