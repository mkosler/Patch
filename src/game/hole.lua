local Class = require("lib.hump.class")
local Vector = require("lib.hump.vector")

local Hole = Class{
    init = function (self, x, y, rows, columns)
        self.position = Vector(x, y)
        self.rows = rows + 2
        self.columns = columns + 2
        self.tilesize = 20

        self._holes = {}
        for r = 1, self.rows do
            self._holes[r] = {}

            local dc = love.math.random(-1, 1)
            print(dc)
            for c = 1, self.columns do
                self._holes[r][c] = (1 - dc <= c and c <= (self.columns - 1) - dc)
            end
        end
    end,

    draw = function (self)
        local color = { love.graphics.getColor() }

        love.graphics.push()

        love.graphics.translate(self.position:unpack())

        for r = 1, self.rows do
            for c = 1, self.columns do
                if self._holes[r][c] then
                    love.graphics.setColor(255, 255, 255)
                else
                    love.graphics.setColor(0, 0, 0)
                end

                love.graphics.rectangle("fill", (c - 1) * self.tilesize, (r - 1) * self.tilesize, self.tilesize, self.tilesize)
            end
        end

        love.graphics.pop()

        love.graphics.setColor(color)
    end,
}



return Hole
