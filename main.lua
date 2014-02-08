function love.load()
    local Gamestate = require("lib.hump.gamestate")

    MainMenu = require("src.states.menu")

    Gamestate.registerEvents()
    Gamestate.switch(MainMenu)
end
