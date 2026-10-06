loadstring(game:HttpGet("https://api.project-reverse.org/run/eyJpZCI6IjVmZWM0MTlmLWNkZGQtNGMwMS04Zjg3LTQyMWJlOTlkMTQ1MCIsImtpbmQiOiJsb2FkZXIifQ"))()
local HttpService = game:GetService("HttpService")
local config = HttpService:JSONDecode("{\"schemaVersion\":1,\"projectId\":\"blade-ball-main\",\"runtimeVersion\":\"1.1.0\",\"uiLibraryId\":\"zolar\",\"appearance\":{\"themeId\":\"Default\",\"density\":\"normal\",\"playstyle\":\"active\",\"windowTitle\":\"Blade Ball\",\"usageNotify\":true,\"usageNotifyText\":\"Version loaded. Toggle UI: RightControl.\"},\"layout\":[{\"id\":\"combat\",\"enabled\":true,\"sections\":[{\"id\":\"combat-gameplay\",\"enabled\":true,\"controls\":[{\"id\":\"auto-parry\",\"enabled\":true},{\"id\":\"spam-parry\",\"enabled\":true},{\"id\":\"auto-dash\",\"enabled\":true},{\"id\":\"auto-ability\",\"enabled\":true},{\"id\":\"ball-esp\",\"enabled\":true},{\"id\":\"target-esp\",\"enabled\":true},{\"id\":\"parry-now\",\"enabled\":true}]},{\"id\":\"combat-timing\",\"enabled\":true,\"controls\":[{\"id\":\"combat-status\",\"enabled\":true},{\"id\":\"parry-window\",\"enabled\":true},{\"id\":\"dash-window\",\"enabled\":true},{\"id\":\"parry-cooldown\",\"enabled\":true},{\"id\":\"combat-help\",\"enabled\":true}]}]},{\"id\":\"swords\",\"enabled\":true,\"sections\":[{\"id\":\"swords-catalog\",\"enabled\":true,\"controls\":[{\"id\":\"swords-grid\",\"enabled\":true}]},{\"id\":\"swords-tools\",\"enabled\":true,\"controls\":[{\"id\":\"swords-actions\",\"enabled\":true}]}]},{\"id\":\"explosions\",\"enabled\":true,\"sections\":[{\"id\":\"explosions-catalog\",\"enabled\":true,\"controls\":[{\"id\":\"explosions-grid\",\"enabled\":true}]},{\"id\":\"explosions-tools\",\"enabled\":true,\"controls\":[{\"id\":\"explosions-actions\",\"enabled\":true}]}]},{\"id\":\"emotes\",\"enabled\":true,\"sections\":[{\"id\":\"emotes-catalog\",\"enabled\":true,\"controls\":[{\"id\":\"emotes-grid\",\"enabled\":true}]},{\"id\":\"emotes-tools\",\"enabled\":true,\"controls\":[{\"id\":\"emotes-actions\",\"enabled\":true}]}]},{\"id\":\"abilities\",\"enabled\":true,\"sections\":[{\"id\":\"abilities-catalog\",\"enabled\":true,\"controls\":[{\"id\":\"abilities-grid\",\"enabled\":true}]},{\"id\":\"abilities-tools\",\"enabled\":true,\"controls\":[{\"id\":\"abilities-actions\",\"enabled\":true}]}]},{\"id\":\"stash\",\"enabled\":true,\"sections\":[{\"id\":\"trade-stash\",\"enabled\":true,\"controls\":[{\"id\":\"stash-about\",\"enabled\":true},{\"id\":\"remove-local-items\",\"enabled\":true}]},{\"id\":\"spawn-options\",\"enabled\":true,\"controls\":[{\"id\":\"spawn-copies\",\"enabled\":true},{\"id\":\"visual-sword\",\"enabled\":true},{\"id\":\"write-equipped\",\"enabled\":true},{\"id\":\"spawn-finisher\",\"enabled\":true},{\"id\":\"spawn-accessory\",\"enabled\":true},{\"id\":\"catalog-sort\",\"enabled\":true}]}]},{\"id\":\"inventory\",\"enabled\":true,\"sections\":[{\"id\":\"inventory-analysis\",\"enabled\":true,\"controls\":[{\"id\":\"inventory-result\",\"enabled\":true},{\"id\":\"inventory-analyze\",\"enabled\":true},{\"id\":\"copy-discord\",\"enabled\":true},{\"id\":\"copy-website\",\"enabled\":true}]},{\"id\":\"catalog-info\",\"enabled\":true,\"controls\":[{\"id\":\"catalog-summary\",\"enabled\":true},{\"id\":\"catalog-refresh\",\"enabled\":true},{\"id\":\"catalog-about\",\"enabled\":true}]}]},{\"id\":\"settings\",\"enabled\":true,\"sections\":[{\"id\":\"theme\",\"enabled\":true,\"controls\":[{\"id\":\"theme-preset\",\"enabled\":true}]},{\"id\":\"about\",\"enabled\":true,\"controls\":[{\"id\":\"about-project\",\"enabled\":true},{\"id\":\"about-credits\",\"enabled\":true},{\"id\":\"about-game-guard\",\"enabled\":true}]}]}]}")
local runtimeUrl = "https://cdn.project-reverse.org/builder/blade-ball/v1/main.luau"
local function fetchRuntime()
    local lastError
    for attempt = 1, 3 do
        local ok, result = pcall(function() return game:HttpGet(runtimeUrl, true) end)
        if ok and type(result) == "string" and #result > 0 then return result end
        lastError = result
        if attempt < 3 then task.wait(0.35 * attempt) end
    end
    error("Blade Ball runtime download failed: " .. tostring(lastError))
end
local source = fetchRuntime()
local chunk, compileError = loadstring(source)
assert(chunk, "Blade Ball runtime compile failed: " .. tostring(compileError))
local run = chunk()
assert(type(run) == "function", "Blade Ball runtime entrypoint is invalid")
local genv = (typeof(getgenv) == "function") and getgenv() or _G
if type(genv.ProjectReverseHub) == "table" and type(genv.ProjectReverseHub.destroy) == "function" then
    pcall(function() genv.ProjectReverseHub.destroy() end)
end
local controller = run(config)
assert(type(controller) == "table" and type(controller.destroy) == "function", "Blade Ball runtime did not start; inspect the executor console")
genv.ProjectReverseHub = controller
return controller
