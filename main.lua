function love.load()
    local Gamestate = require("lib.hump.gamestate")

    MainMenu = require("src.states.menu")
    Endless = require("src.states.endless")

    Gamestate.registerEvents()
    Gamestate.switch(MainMenu)
end
