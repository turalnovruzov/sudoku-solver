local class = require "lib/middleclass"

Board = class("Board")

function Board:initialize(x, y)
    self.x = x
    self.y = y
    self.width = 460
    -- Divide by 9 while leaving gaps for 10 lines
    self.cellWidth = (self.width - 10) / 9

    -- Cells
    local Cell = require "cell"
    self.cells = {}

    -- Draw the cells while leaving gaps in between for lines
    local y_, x_
    y_ = self.y + 1
    for i=1,9 do
        self.cells[i] = {}
        x_ = self.x + 1

        for j=1,9 do
            self.cells[i][j] = Cell:new(x_, y_, self.cellWidth, 1)
            x_ = x_ + self.cellWidth + 1
        end

        y_ = y_ + self.cellWidth + 1
    end

    -- Colors
    -- 189, 199, 212
    self.lineColor = {189 / 255, 199 / 255, 212 / 255}

    -- 52, 72, 97
    self.boldLineColor = {52 / 255, 72 / 255, 97 / 255}

    self.states = {
        normal = 0
    }

    self.state = self.states.normal
end

function Board:update()

end

function Board:draw()
    -- Normal state
    if self.state == self.states.normal then

        -- Draw cells
        for i, row in ipairs(self.cells) do
            for j, cell in ipairs(row) do
                cell:draw()
            end
        end

        -- Draw lines
        love.graphics.setColor(self.lineColor)
        for x_ = self.x + self.cellWidth + 1, self.x + (self.width - self.cellWidth + 1), self.cellWidth + 1 do
            love.graphics.line(x_, self.y, x_, self.y + self.width - 1)
        end

        for y_ = self.y + self.cellWidth + 1, self.y + (self.width - self.cellWidth + 1), self.cellWidth + 1 do
            love.graphics.line(self.x, y_, self.x + self.width - 1, y_)
        end

        love.graphics.setColor(self.boldLineColor)
        for x_ = self.x, self.x + self.width, 3 * (self.cellWidth + 1) do
            love.graphics.line(x_, self.y, x_, self.y + self.width - 1)
        end

        for y_ = self.y, self.y + self.width, 3 * (self.cellWidth + 1) do
            love.graphics.line(self.x, y_, self.x + self.width - 1, y_)
        end
    end
end

return Board
