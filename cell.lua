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
    self.normalColor = {1, 1, 1}

    -- 187, 222, 251
    self.setValueColor = {187 / 255, 222 / 255, 251 / 255}

    -- 189, 199, 212
    self.outlineColor = {189 / 255, 199 / 255, 212 / 255}

    -- 29, 46, 66
    self.textColor = {29 / 255, 46 / 255, 66 / 255}

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

function Cell:mousePressed(x, y, button, istouch, presses)
    if x >= self.x and x <= (self.x + self.width) and y >= self.y and y <= (self.y + self.width) then
        if self.state == self.states.normal then
            self.state = self.states.setValue
        elseif self.state == self.states.setValue then
            self.state = self.states.normal
        end
    end
end

function Cell:keyPressed(key, scancode, isrepeat)
    if self.state == self.states.setValue then
        if key >= "1" and key <= "9" then
            self.value = tonumber(key)
        end
    end
end

function Cell:update(dt)

end

function Cell:draw()
    if self.state == self.states.normal then
        love.graphics.setColor(self.normalColor)
    elseif self.state == self.states.setValue then
        love.graphics.setColor(self.setValueColor)
    end

    -- Fill
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.width)
    -- Outline
    love.graphics.setColor(self.outlineColor)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.width)

    -- Number
    if self:hasValue() then
        love.graphics.setColor(self.textColor)
        love.graphics.printf(tostring(self.value), self.font, self.x, self.y, self.width, "center")
    end
end

return Cell
