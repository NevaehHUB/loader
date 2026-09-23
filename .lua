local config = {

    [142823291] = "",

}

repeat task.wait() until game:IsLoaded()

local scriptUrl = config[game.PlaceId]

if scriptUrl then
    pcall(function()
        loadstring(game:HttpGet(scriptUrl))()
    end)
end
