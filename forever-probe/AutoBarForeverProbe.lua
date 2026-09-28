local addonName = ...
local frame = CreateFrame("Frame")
local report = {}

local function add(label, value)
    report[#report + 1] = label .. ": " .. tostring(value)
end

local function check(label, fn)
    local ok, value = pcall(fn)
    if ok then
        add(label, value)
    else
        add(label, "ERROR: " .. tostring(value))
    end
end

local function collect()
    report = {}
    local version, build, date, interface = GetBuildInfo()
    add("Client", version .. " (build " .. tostring(build) .. ", " .. tostring(date) .. ")")
    add("Interface", interface)
    add("Project ID", WOW_PROJECT_ID)
    add("Mainline project", WOW_PROJECT_MAINLINE)
    add("Classic project", WOW_PROJECT_CLASSIC)
    add("loadstring_untainted", type(loadstring_untainted))
    add("SecureHandlerWrapScript", type(SecureHandlerWrapScript))
    add("C_RestrictedActions", type(C_RestrictedActions))
    check("Addon restriction active", function()
        if not C_RestrictedActions or not C_RestrictedActions.IsAddOnRestrictionActive then
            return "API unavailable"
        end
        return C_RestrictedActions.IsAddOnRestrictionActive()
    end)
    add("C_Container.GetContainerNumSlots", type(C_Container and C_Container.GetContainerNumSlots))
    add("C_Container.GetContainerItemID", type(C_Container and C_Container.GetContainerItemID))
    add("C_Item.GetItemCount", type(C_Item and C_Item.GetItemCount))
    add("C_Spell.GetSpellInfo", type(C_Spell and C_Spell.GetSpellInfo))
    add("C_AddOns.GetAddOnMetadata", type(C_AddOns and C_AddOns.GetAddOnMetadata))
    check("Backpack slots", function()
        return C_Container.GetContainerNumSlots(0)
    end)
    check("Hearthstone count", function()
        return C_Item.GetItemCount(6948)
    end)

    -- AutoBar uses SecureHandlerStateTemplate for its bars and Execute for popups.
    -- Keep this frame hidden and avoid protected changes during combat.
    if InCombatLockdown() then
        add("Secure snippet", "skipped in combat; retry /abforever out of combat")
    else
        check("Secure snippet", function()
            local secureFrame = CreateFrame("Frame", nil, UIParent, "SecureHandlerStateTemplate")
            secureFrame:Hide()
            local result = secureFrame:Execute("return 42")
            return result == 42 and "works" or ("unexpected result: " .. tostring(result))
        end)
    end
end

local function show()
    collect()
    print("|cff00d5ffAutoBar Forever Probe|r (" .. addonName .. ")")
    for _, line in ipairs(report) do
        print("  " .. line)
    end
end

SLASH_AUTOBARFOREVERPROBE1 = "/abforever"
SlashCmdList.AUTOBARFOREVERPROBE = show

frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function()
    print("|cff00d5ffAutoBar Forever Probe loaded.|r Type /abforever out of combat, then copy the report or send a screenshot.")
end)
