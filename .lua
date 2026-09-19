local config = {
    [107778070777162] = "https://api.jnkie.com/api/v1/luascripts/public/ad1854a7dd4b1db76a97ef722c59b35b35aa90eed1780d9fba4aef65c8c6b2e2/download",

}

repeat task.wait() until game:IsLoaded()

local scriptUrl = config[game.PlaceId]

if scriptUrl then
    pcall(function()
        loadstring(game:HttpGet(scriptUrl))()
    end)
end
