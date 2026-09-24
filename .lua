local config = {

    [16732694052] = "https://api.jnkie.com/api/v1/luascripts/public/5ad011b0e9815baf20cb915494d9bbbfa03ccb625fd76538f370491bf2bf118c/download",
    [100539151525414] = "https://api.jnkie.com/api/v1/luascripts/public/5ad011b0e9815baf20cb915494d9bbbfa03ccb625fd76538f370491bf2bf118c/download",

}

repeat task.wait() until game:IsLoaded()

local scriptUrl = config[game.PlaceId]

if scriptUrl then
    pcall(function()
        loadstring(game:HttpGet(scriptUrl))()
    end)
end
