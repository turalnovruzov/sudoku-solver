local class = require "lib/middleclass"

Board = class("Board")

function Board:initialize(x, y)
    self.x = x
    self.y = y
    self.width = 460
    -- Divide by 9 while leaving gaps for 10 lines
    self.cellWidth = (self.width - 10) / 9

    local Cell = require "cell"
    self.cells = {}

    -- Draw the cells while leaving gaps in between for lines
    local y_, x_
    y_ = self.y + 1
    for i=1,9 do
        self.cells[i] = {}
        x_ = self.x + 1

        for j=1,9 do
            self.cells[i][j] = Cell:new(x_, y_, self.cellWidth, 0)
            x_ = x_ + self.cellWidth + 1
        end

        y_ = y_ + self.cellWidth + 1
    end

    self.states = {
        normal = 0
    }

    self.state = self.states.normal
end

function Board:update()

end

function Board:draw()
    -- Draw cells
    for i, row in ipairs(self.cells) do
        for j, cell in ipairs(row) do
            cell:draw()
        end
    end
end

return Board
