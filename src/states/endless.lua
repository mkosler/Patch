local Gamestate = require("lib.hump.gamestate")
local Hole = require("src.game.hole")
local Tetromino = require("src.game.tetromino")

local generateTetromino = function (x, y)
    local types = { "I", "J", "L", "O", "S", "T", "Z" }

    return Tetromino[types[love.math.random(#types)]](x, y)
end

local Endless = {
    enter = function (self, from)
        self.hole = Hole(0, 0, 10, 10)
        self.tetromino = generateTetromino(0, 0)
    end,

    draw = function (self)
        self.hole:draw()
        self.tetromino:draw()
    end,

    keypressed = function (self, key, code)
        if key == "a" then
            if self.hole:apply(self.tetromino) then
                self.tetromino = generateTetromino(0, 0)
            end
        end

        self.tetromino:keypressed(key, code)
    end,
}

return Endless
