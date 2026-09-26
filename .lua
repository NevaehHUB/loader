local config = {
    [16732694052] = "https://api.jnkie.com/api/v1/luascripts/public/5ad011b0e9815baf20cb915494d9bbbfa03ccb625fd76538f370491bf2bf118c/download", -- Main fisch
    [131716211654599] = "https://api.jnkie.com/api/v1/luascripts/public/5ad011b0e9815baf20cb915494d9bbbfa03ccb625fd76538f370491bf2bf118c/download", -- Fisch for new players
    [113290951185459] = "https://api.jnkie.com/api/v1/luascripts/public/62356c6cce48f2dfbc26a274f6a76e6d2b0136d4da6b69c22ee18377790a25e1/download", -- Anime Dice
}

repeat task.wait() until game:IsLoaded()

local scriptUrl = config[game.PlaceId]

if scriptUrl then
    pcall(function()
        loadstring(game:HttpGet(scriptUrl))()
    end)
end
