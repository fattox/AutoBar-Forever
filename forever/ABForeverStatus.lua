-- Minimal status command for the first Forever test builds.
SLASH_AUTOBARFOREVERSTATUS1 = "/abfstatus"
SlashCmdList.AUTOBARFOREVERSTATUS = function()
    local data = AutoBarGlobalDataObject
    local bars = 0
    if AutoBar and AutoBar.barList then
        for _ in pairs(AutoBar.barList) do
            bars = bars + 1
        end
    end
    print("AutoBar Forever: project " .. tostring(WOW_PROJECT_ID)
        .. ", Forever marker " .. tostring(data and data.is_forever_wow)
        .. ", modern API path " .. tostring(data and data.is_mainline_wow))
    print("AutoBar Forever: initialized " .. tostring(AutoBar and AutoBar.initialized)
        .. ", bars " .. tostring(bars))
    if AutoBar and AutoBar.warning_log then
        print("AutoBar Forever: " .. #AutoBar.warning_log .. " warnings; type /run AutoBar:DumpWarningLog() to show them in chat")
    end
end
