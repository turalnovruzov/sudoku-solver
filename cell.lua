local class = require "lib/middleclass"

Cell = class("Cell")

function Cell:initialize(x, y, width)
    -- Initializes cell with
    -- position x, y
    -- size width

    self.x = x
    self.y = y
    self.width = width
    self.value = 1
    self.font = love.graphics.newFont("fonts/Adequate.ttf", 29)
    colorCode = 0.8
    self.color = {colorCode, colorCode, colorCode}
    outlineColorCode = 0.02
    self.outlineColor = {outlineColorCode, outlineColorCode, outlineColorCode}

    self.states = {
        normal=0,
        setValue=1
    }
    self.state = self.states.normal
end

function Cell:hasValue()
    -- If value is 0 then it has no value.

    if self.value then
        return true
    end

    return false
end

function Cell:mousePressed( x, y, button, istouch, presses )
    if x >= self.x and x <= (self.x + self.width) and y >= self.y and y <= (self.y + self.width) then
        if self.state == self.states.normal then
            self.state = self.states.setValue
        elseif self.state == self.states.setValue then
            self.state = self.states.normal
        end
    end
end

function Cell:update(dt)

end

function Cell:draw()
    if self.state == self.states.normal then
        -- Fill
        love.graphics.setColor(self.color)
        love.graphics.rectangle("fill", self.x, self.y, self.width, self.width)

        -- Outline
        love.graphics.setColor(self.outlineColor)
        love.graphics.rectangle("line", self.x, self.y, self.width, self.width)
    end

    -- Number
    if self:hasValue() then
        love.graphics.printf(tostring(self.value), self.font, self.x, self.y, self.width, "center")
    end
end

return Cell
