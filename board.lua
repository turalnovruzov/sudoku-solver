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
            self.cells[i][j] = Cell:new(x_, y_, self.cellWidth, 0)
            x_ = x_ + self.cellWidth + 1
        end

        y_ = y_ + self.cellWidth + 1
    end

    local squares = { {
            ["x"] = 0,
            ["y"] = 4,
            value = 2
        }, {
            ["x"] = 0,
            ["y"] = 5,
            value = 5
        }, {
            ["x"] = 1,
            ["y"] = 1,
            value = 5
        }, {
            ["x"] = 1,
            ["y"] = 7,
            value = 2
        }, {
            ["x"] = 2,
            ["y"] = 4,
            value = 3
        }, {
            ["x"] = 2,
            ["y"] = 6,
            value = 5
        }, {
            ["x"] = 2,
            ["y"] = 8,
            value = 4
        }, {
            ["x"] = 3,
            ["y"] = 0,
            value = 2
        }, {
            ["x"] = 3,
            ["y"] = 3,
            value = 5
        }, {
            ["x"] = 4,
            ["y"] = 2,
            value = 1
        }, {
            ["x"] = 4,
            ["y"] = 6,
            value = 4
        }, {
            ["x"] = 5,
            ["y"] = 1,
            value = 9
        }, {
            ["x"] = 5,
            ["y"] = 6,
            value = 1
        }, {
            ["x"] = 6,
            ["y"] = 4,
            value = 8
        }, {
            ["x"] = 6,
            ["y"] = 8,
            value = 3
        }, {
            ["x"] = 7,
            ["y"] = 1,
            value = 3
        }, {
            ["x"] = 7,
            ["y"] = 7,
            value = 4
        }, {
            ["x"] = 8,
            ["y"] = 0,
            value = 4
        }, {
            ["x"] = 8,
            ["y"] = 5,
            value = 9
        }, {
            ["x"] = 8,
            ["y"] = 8,
            value = 8
        } }
      
    for i, v in ipairs(squares) do
        self.cells[v.x + 1][v.y + 1].value = v.value
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

function Board:isColliding(x, y)
    -- Checks if the given point collides with the board
    -- Returns true if collides, false otherwise

    if x >= self.x and x <= (self.x + self.width) and y >= self.y and y <= (self.y + self.width) then
        return true
    end

    return false
end

function Board:mousePressed(x, y, button, istouch, presses)
    if self.state == self.states.normal then
        if self:isColliding(x, y) then
            for i, row in ipairs(self.cells) do
                for j, cell in ipairs(row) do
                    cell:mousePressed(x, y, button, istouch, presses)
                end
            end
        end
    end
end

function Board:keyPressed(key, scancode, isrepeat)
    if self.state == self.states.normal then
        for i, row in ipairs(self.cells) do
            for j, cell in ipairs(row) do
                cell:keyPressed(key, scancode, isrepeat)
            end
        end
    end
end

function Board:update()
    if self.state == self.states.normal then
        for i, row in ipairs(self.cells) do
            for j, cell in ipairs(row) do
                cell:update(dt)
            end
        end
    end
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
