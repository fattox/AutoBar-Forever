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
        print("AutoBar Forever: " .. #AutoBar.warning_log .. " warnings; type /abfwarnings to show them in chat")
    end
end

SLASH_AUTOBARFOREVERWARNINGS1 = "/abfwarnings"
SlashCmdList.AUTOBARFOREVERWARNINGS = function(message)
    local warnings = AutoBar and AutoBar.warning_log
    if not warnings or #warnings == 0 then
        print("AutoBar Forever: no warnings")
        return
    end

    local page_size = 5
    local pages = math.ceil(#warnings / page_size)
    local page = tonumber(message) or 1
    page = math.floor(page)
    if page < 1 or page > pages then
        print("AutoBar Forever: choose a page from 1 to " .. pages)
        return
    end

    print("AutoBar Forever: warnings page " .. page .. "/" .. pages)
    local first = (page - 1) * page_size + 1
    for i = first, math.min(first + page_size - 1, #warnings) do
        print(i .. ": " .. tostring(warnings[i]))
    end
    if page < pages then
        print("AutoBar Forever: type /abfwarnings " .. (page + 1) .. " for the next page")
    end
end
