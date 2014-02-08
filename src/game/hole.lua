local Class = require("lib.hump.class")
local Vector = require("lib.hump.vector")

local Hole = Class{
    init = function (self, x, y, rows, columns)
        self.position = Vector(x, y)
        self.rows = rows + 2
        self.columns = columns + 2
        self.tilesize = 20
        self.colors = {
            wall = { 0, 0, 0 },
            empty = { 255, 255, 255 },
        }

        self._holes = {}
        self.gridOverlay = love.graphics.newCanvas(self.columns * self.tilesize, self.rows * self.tilesize)
        love.graphics.setCanvas(self.gridOverlay)
        love.graphics.setColor(100, 100, 100)
        for r = 1, self.rows do
            self._holes[r] = {}

            local dc = love.math.random(-1, 1)
            for c = 1, self.columns do
                love.graphics.rectangle("line", (c - 1) * self.tilesize, (r - 1) * self.tilesize, self.tilesize, self.tilesize)

                if 1 - dc <= c and c <= (self.columns - 1) - dc then
                    self._holes[r][c] = self.colors.empty
                else
                    self._holes[r][c] = self.colors.wall
                end
            end
        end
        love.graphics.setCanvas()
    end,

    draw = function (self)
        local color = { love.graphics.getColor() }

        love.graphics.push()

        love.graphics.translate(self.position:unpack())

        for r = 1, self.rows do
            for c = 1, self.columns do
                love.graphics.setColor(self._holes[r][c])
                love.graphics.rectangle("fill", (c - 1) * self.tilesize, (r - 1) * self.tilesize, self.tilesize, self.tilesize)
            end
        end

        love.graphics.pop()

        love.graphics.setColor(255, 255, 255)
        love.graphics.draw(self.gridOverlay, self.position:unpack())

        love.graphics.setColor(color)
    end,

    apply = function (self, tetromino)
        local rect = tetromino:getBoundingBox()
        if not (self.position.x <= rect.left and rect.right <= self.position.x + self.columns * self.tilesize and self.position.y <= rect.top and rect.bottom <= self.position.y + self.rows * self.tilesize) then
            return false
        end

        for _,b,r,c in tetromino:each() do
            if b then
                local x, y = tetromino.position.x + c * tetromino.tilesize, tetromino.position.y + r * tetromino.tilesize
                local mr, mc = math.floor((y - self.position.y) / self.tilesize) + 1, math.floor((x - self.position.x) / self.tilesize) + 1

                self._holes[mr][mc] = tetromino.color
            end
        end

        return true
    end,
}



return Hole
