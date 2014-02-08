local Gamestate = require("lib.hump.gamestate")
local Hole = require("src.game.hole")
local Tetromino = require("src.game.tetromino")

local Endless = {
    init = function (self)
    end,

    enter = function (self, from)
        self.hole = Hole(0, 0, 10, 10)
        self.test = Tetromino.I(0, 0)
    end,

    leave = function (self)
    end,

    update = function (self, dt)
    end,

    draw = function (self)
        self.hole:draw()
        self.test:draw()
    end,

    keypressed = function (self, key, code)
        self.test:keypressed(key, code)
    end,
}

return Endless
