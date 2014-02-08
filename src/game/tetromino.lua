local Class = require("lib.hump.class")
local bit32 = require("bit")
local Vector = require("lib.hump.vector")

local Tetromino = Class{
    init = function (self. position, blocks, color)
        self.position = position
        self.blocks = blocks
        self.color = color
        self.current = 1
        self.tilesize = 20
    end,

    each = function (self)
        local function each_it(block, bit)
            local v = bit32.band(block, bit) ~= 0

            if bit > 0 then
                bit = bit32.rshift(bit, 1)

                return bit, v
            else
                return nil
            end
        end

        return each_it, self.blocks[self.current], 0x8000
    end,

    draw = function (self)
        local color = { love.graphics.getColor() }
        love.graphics.setColor(self.color)

        for _,b in self.each() do
        end

        love.graphics.setColor(color)
    end,
}

local I = Class{
    __includes = Tetromino,
    init = function (self, position)
        Tetromino.init(self, position, { 0xF000, 0x8888 }, { 0, 255, 255 })
    end,
}

local J = Class{
    __includes = Tetromino,
    init = function (self, position)
        Tetromino.init(self, position, { 0xE200, 0x44C0, 0x8E00, 0xC880 }, { 0, 0, 255 })
    end,
}

local L = Class{
    __includes = Tetromino,
    init = function (self, position)
        Tetromino.init(self, position, { 0xE800, 0xC440, 0x2E00, 0x88C0 }, { 255, 165, 0 })
    end,
}

local O = Class{
    __includes = Tetromino,
    init = function (self, position)
        Tetromino.init(self, position, { 0xCC00 }, { 255, 255, 0 })
    end,
}

local S = Class{
    __includes = Tetromino,
    init = function (self, position)
        Tetromino.init(self, position, { 0x6C00, 0x8C40 }, { 50, 205, 50 })
    end,
}

local T = Class{
    __includes = Tetromino,
    init = function (self, position)
        Tetromino.init(self, position, { 0xE400, 0x4C40, 0x4E00, 0x8C80 }, { 148, 0, 211 })
    end,
}

local Z = Class{
    __includes = Tetromino,
    init = function (self, position)
        Tetromino.init(self, position, { 0xC600, 0x4C80 }, { 255, 0, 0 })
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
