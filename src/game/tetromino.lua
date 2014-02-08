local Class = require("lib.hump.class")
local bit32 = require("bit")
local Vector = require("lib.hump.vector")

local Tetromino = Class{
    init = function (self, x, y, blocks, color)
        self.position = Vector(x, y)
        self.blocks = blocks
        self.color = color
        self.current = 1
        self.tilesize = 20
    end,

    each = function (self)
        local r, c = 0, 0

        local function each_it(block, bit)
            local v = bit32.band(block, bit) ~= 0

            if bit > 0 then
                local retc, retr = c, r

                c = c + 1
                if c == 4 then
                    c = 0
                    r = r + 1
                end

                bit = bit32.rshift(bit, 1)
                return bit, v, retr, retc
            else
                return nil
            end
        end

        return each_it, self.blocks[self.current], 0x8000
    end,

    draw = function (self)
        local color = { love.graphics.getColor() }
        love.graphics.setColor(self.color)

        love.graphics.push()

        love.graphics.translate(self.position:unpack())

        for _,b,r,c in self:each() do
            if b then
                love.graphics.rectangle("fill", c * self.tilesize, r * self.tilesize, self.tilesize, self.tilesize)
            end
        end

        love.graphics.pop()

        love.graphics.setColor(color)
    end,

    keypressed = function (self, key, code)
        if key == " " then
            self.current = self.current < #self.blocks and self.current + 1 or 1
        elseif key == "left" then
            self:move(-self.tilesize, 0)
        elseif key == "right" then
            self:move(self.tilesize, 0)
        elseif key == "up" then
            self:move(0, -self.tilesize)
        elseif key == "down" then
            self:move(0, self.tilesize)
        end
    end,

    move = function (self, dx, dy)
        self.position = self.position + Vector(dx, dy)
    end,
}

local I = Class{
    __includes = Tetromino,
    init = function (self, x, y)
        Tetromino.init(self, x, y, { 0xF000, 0x8888 }, { 0, 255, 255 })
    end,
}

local J = Class{
    __includes = Tetromino,
    init = function (self, x, y)
        Tetromino.init(self, x, y, { 0xE200, 0x44C0, 0x8E00, 0xC880 }, { 0, 0, 255 })
    end,
}

local L = Class{
    __includes = Tetromino,
    init = function (self, x, y)
        Tetromino.init(self, x, y, { 0xE800, 0xC440, 0x2E00, 0x88C0 }, { 255, 165, 0 })
    end,
}

local O = Class{
    __includes = Tetromino,
    init = function (self, x, y)
        Tetromino.init(self, x, y, { 0xCC00 }, { 255, 255, 0 })
    end,
}

local S = Class{
    __includes = Tetromino,
    init = function (self, x, y)
        Tetromino.init(self, x, y, { 0x6C00, 0x8C40 }, { 50, 205, 50 })
    end,
}

local T = Class{
    __includes = Tetromino,
    init = function (self, x, y)
        Tetromino.init(self, x, y, { 0xE400, 0x4C40, 0x4E00, 0x8C80 }, { 148, 0, 211 })
    end,
}

local Z = Class{
    __includes = Tetromino,
    init = function (self, x, y)
        Tetromino.init(self, x, y, { 0xC600, 0x4C80 }, { 255, 0, 0 })
    end,
}

return {
    I = I,
    J = J,
    L = L,
    O = O,
    S = S,
    T = T,
    Z = Z,
}
