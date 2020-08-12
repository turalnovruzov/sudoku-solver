local class = require "lib/middleclass"
local json = require "lib/json"

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

    -- local squares = {{["x"]=0,["y"]=1,value=8},{["x"]=0,["y"]=2,value=5},{["x"]=0,["y"]=4,value=3},{["x"]=0,["y"]=6,value=2},{["x"]=1,["y"]=2,value=3},{["x"]=1,["y"]=5,value=5},{["x"]=1,["y"]=6,value=8},{["x"]=2,["y"]=0,value=7},{["x"]=2,["y"]=1,value=2},{["x"]=2,["y"]=3,value=9},{["x"]=2,["y"]=5,value=6},{["x"]=2,["y"]=6,value=5},{["x"]=2,["y"]=8,value=4},{["x"]=3,["y"]=0,value=9},{["x"]=3,["y"]=3,value=3},{["x"]=3,["y"]=4,value=1},{["x"]=3,["y"]=7,value=8},{["x"]=3,["y"]=8,value=5},{["x"]=4,["y"]=0,value=5},{["x"]=4,["y"]=4,value=7},{["x"]=5,["y"]=0,value=3},{["x"]=5,["y"]=1,value=1},{["x"]=5,["y"]=4,value=5},{["x"]=5,["y"]=5,value=8},{["x"]=5,["y"]=6,value=9},{["x"]=5,["y"]=8,value=2},{["x"]=6,["y"]=3,value=5},{["x"]=6,["y"]=5,value=3},{["x"]=6,["y"]=6,value=7},{["x"]=6,["y"]=7,value=2},{["x"]=7,["y"]=1,value=3},{["x"]=7,["y"]=3,value=8},{["x"]=7,["y"]=7,value=5},{["x"]=7,["y"]=8,value=6},{["x"]=8,["y"]=0,value=8},{["x"]=8,["y"]=2,value=7},{["x"]=8,["y"]=3,value=1},{["x"]=8,["y"]=4,value=6},{["x"]=8,["y"]=6,value=4},{["x"]=8,["y"]=8,value=3}}
    local squares = {{["y"]=1,["x"]=1,value=4},{["y"]=2,["x"]=1,value=8},{["y"]=3,["x"]=1,value=5},{["y"]=4,["x"]=1,value=7},{["y"]=5,["x"]=1,value=3},{["y"]=6,["x"]=1,value=1},{["y"]=7,["x"]=1,value=2},{["y"]=8,["x"]=1,value=6},{["y"]=9,["x"]=1,value=9},{["y"]=1,["x"]=2,value=6},{["y"]=2,["x"]=2,value=9},{["y"]=3,["x"]=2,value=3},{["y"]=4,["x"]=2,value=4},{["y"]=5,["x"]=2,value=2},{["y"]=6,["x"]=2,value=5},{["y"]=7,["x"]=2,value=8},{["y"]=8,["x"]=2,value=1},{["y"]=9,["x"]=2,value=7},{["y"]=1,["x"]=3,value=7},{["y"]=2,["x"]=3,value=2},{["y"]=3,["x"]=3,value=1},{["y"]=4,["x"]=3,value=9},{["y"]=5,["x"]=3,value=8},{["y"]=6,["x"]=3,value=6},{["y"]=7,["x"]=3,value=5},{["y"]=8,["x"]=3,value=3},{["y"]=9,["x"]=3,value=4},{["y"]=1,["x"]=4,value=9},{["y"]=2,["x"]=4,value=7},{["y"]=3,["x"]=4,value=2},{["y"]=4,["x"]=4,value=3},{["y"]=5,["x"]=4,value=1},{["y"]=7,["x"]=4,value=6},{["y"]=8,["x"]=4,value=8},{["y"]=9,["x"]=4,value=5},{["y"]=1,["x"]=5,value=5},{["y"]=2,["x"]=5,value=6},{["y"]=3,["x"]=5,value=8},{["y"]=4,["x"]=5,value=2},{["y"]=5,["x"]=5,value=7},{["y"]=7,["x"]=5,value=3},{["y"]=8,["x"]=5,value=4},{["y"]=9,["x"]=5,value=1},{["y"]=1,["x"]=6,value=3},{["y"]=2,["x"]=6,value=1},{["y"]=3,["x"]=6,value=4},{["y"]=4,["x"]=6,value=6},{["y"]=5,["x"]=6,value=5},{["y"]=6,["x"]=6,value=8},{["y"]=7,["x"]=6,value=9},{["y"]=8,["x"]=6,value=7},{["y"]=9,["x"]=6,value=2},{["y"]=1,["x"]=7,value=1},{["y"]=2,["x"]=7,value=4},{["y"]=3,["x"]=7,value=6},{["y"]=4,["x"]=7,value=5},{["y"]=6,["x"]=7,value=3},{["y"]=7,["x"]=7,value=7},{["y"]=8,["x"]=7,value=2},{["y"]=9,["x"]=7,value=8},{["y"]=1,["x"]=8,value=2},{["y"]=2,["x"]=8,value=3},{["y"]=3,["x"]=8,value=9},{["y"]=4,["x"]=8,value=8},{["y"]=5,["x"]=8,value=4},{["y"]=6,["x"]=8,value=7},{["y"]=7,["x"]=8,value=1},{["y"]=8,["x"]=8,value=5},{["y"]=9,["x"]=8,value=6},{["y"]=1,["x"]=9,value=8},{["y"]=2,["x"]=9,value=5},{["y"]=3,["x"]=9,value=7},{["y"]=4,["x"]=9,value=1},{["y"]=5,["x"]=9,value=6},{["y"]=6,["x"]=9,value=2},{["y"]=7,["x"]=9,value=4},{["y"]=8,["x"]=9,value=9},{["y"]=9,["x"]=9,value=3}}
    

    for i, v in ipairs(squares) do
        self.cells[v.x ][v.y ].value = v.value
        self.cells[v.x ][v.y ].const = true
    end

    -- Colors
    -- 189, 199, 212
    self.lineColor = {189 / 255, 199 / 255, 212 / 255}

    -- 52, 72, 97
    self.boldLineColor = {52 / 255, 72 / 255, 97 / 255}

    self.states = {
        normal = 0,
        solved = 1
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

function Board:checkConflict(i, j)
    -- Checks if the given cell has any conflicts
    -- Returns true if the cell has conflicts, false otherwise

    -- Horizontal checking
    for j_=1,9 do
        if self.cells[i][j_]:hasValue() and j_ ~= j then
            if self.cells[i][j_].value == self.cells[i][j].value then
                return true
            end
        end
    end

    -- Vertical
    for i_=1,9 do
        if self.cells[i_][j]:hasValue() and i_ ~= i then
            if self.cells[i_][j].value == self.cells[i][j].value then
                return true
            end
        end
    end

    -- Cube
    for i_ = math.floor((i - 1) / 3) * 3 + 1, math.floor((i - 1) / 3 + 1) * 3 do
        for j_ = math.floor((j - 1) / 3) * 3 + 1, math.floor((j - 1) / 3 + 1) * 3  do
            if self.cells[i_][j_]:hasValue() and i_ ~= i and j_ ~= j then
                if self.cells[i_][j_].value == self.cells[i][j].value then
                    return true
                end
            end
        end
    end

    return false
end

function Board:updateConflicts(i, j)
    -- Updates cells' conflict values 

    -- Horizontal
    for j_=1,9 do
        if self.cells[i][j_]:hasValue()  and j_ ~= j then
            if self.cells[i][j_].value == self.cells[i][j].value then
                self.cells[i][j_].conflict = true
            elseif not self:checkConflict(i, j_) then
                self.cells[i][j_].conflict = false
            end
        end
    end

    -- Vertical
    for i_=1,9 do
        if self.cells[i_][j]:hasValue()  and i_ ~= i then
            if self.cells[i_][j].value == self.cells[i][j].value then
                self.cells[i_][j].conflict = true
            elseif not self:checkConflict(i_, j) then
                self.cells[i_][j].conflict = false
            end
        end
    end

    -- Cube
    for i_ = math.floor((i - 1) / 3) * 3 + 1, math.floor((i - 1) / 3 + 1) * 3 do
        for j_ = math.floor((j - 1) / 3) * 3 + 1, math.floor((j - 1) / 3 + 1) * 3  do
            if self.cells[i_][j_]:hasValue() and i_ ~= i and j_ ~= j then
                if self.cells[i_][j_].value == self.cells[i][j].value then
                    self.cells[i_][j_].conflict = true
                elseif not self:checkConflict(i_, j_) then
                    self.cells[i_][j_].conflict = false
                end
            end
        end
    end

    if self:checkConflict(i, j) then
        self.cells[i][j].conflict = true
    else
        self.cells[i][j].conflict = false
    end
end

function Board:terminal(update)
    -- Checks if the puzzle is solved
    -- update (boolean): if true will update the object to solved state
    -- Returns true if solved, false otherwise

    for i=1,9 do
        for j=1,9 do
            if not self.cells[i][j]:hasValue() or self.cells[i][j].conflict then
                return false
            end
        end
    end

    if update then
        self.state = self.states.solved

        -- Deafult all cells
        for i = 1,9 do
            for j = 1,9 do
                self.cells[i][j].hover = false
                self.cells[i][j].state = self.cells[i][j].states.normal
            end
        end
    end

    return true
end

function Board:isSolved()
    if self.state == self.states.solved then
        return true
    end

    return false
end

function Board:mousePressed(x, y, button, istouch, presses)
    if self.state == self.states.normal and self:isColliding(x, y) then
        for i, row in ipairs(self.cells) do
            for j, cell in ipairs(row) do
                if cell:mousePressed(x, y, button, istouch, presses) then
                    self:updateConflicts(i, j)
                    self:terminal(true)
                end
            end
        end
    end
end

function Board:keyPressed(key, scancode, isrepeat)
    if self.state == self.states.normal then
        for i, row in ipairs(self.cells) do
            for j, cell in ipairs(row) do
                if cell:keyPressed(key, scancode, isrepeat) then
                    self:updateConflicts(i, j)
                    self:terminal(true)
                end
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

return Board
