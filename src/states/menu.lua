local Gamestate = require("lib.hump.gamestate")
local GUI = require("lib.Quickie")

local PlayMenu = {
    enter = function (self, from)
        self.draw = from.draw
        self.keypressed = from.keypressed
    end,

    update = function (self, dt)
        GUI.group.push{ grow = "down" }

        if GUI.Button{ text = "Endless" } then
            Gamestate.switch(Endless)
        end

        GUI.Button{ text = "Tutorial" }

        GUI.Button{ text = "Versus" }

        if GUI.Button{ text = "Back" } then
            Gamestate.pop()
        end

        GUI.group.pop()
    end,
}

local MainMenu = {
    init = function (self)
        self.fonts = {
            [12] = love.graphics.newFont(12),
        }
        love.graphics.setFont(self.fonts[12])
    end,

    enter = function (self, from)
    end,

    update = function (self, dt)
        GUI.group.push{ grow = "down" }

        if GUI.Button{ text = "Play" } then
            Gamestate.push(PlayMenu)
        end

        GUI.Button{ text = "Options" }

        if GUI.Button{ text = "Exit" } then
            love.event.quit()
        end

        GUI.group.pop()
    end,

    draw = function (self)
        GUI.core.draw()
    end,

    keypressed = function (self, key, code)
        GUI.keyboard.pressed(key, code)
    end,
}

return MainMenu
