local class = require "lib/middleclass"

Cell = class("Cell")

function Cell:initialize(x, y, width, value)
    -- Initializes cell with
    -- position x, y
    -- size width

    self.x = x
    self.y = y
    self.width = width
    self.value = value
    self.font = love.graphics.newFont("fonts/Adequate.ttf", 29)
    self.normalColor = {1, 1, 1}

    -- 187, 222, 251
    self.setValueColor = {187 / 255, 222 / 255, 251 / 255}

    -- 189, 199, 212
    self.outlineColor = {189 / 255, 199 / 255, 212 / 255}

    -- 29, 46, 66
    self.textColor = {29 / 255, 46 / 255, 66 / 255}

    -- 221, 238, 254
    self.hoverColor = {221 / 255, 238 / 255, 254 / 255}

    self.states = {
        normal=0,
        setValue=1,
        hover=2
    }
    self.state = self.states.normal
end

function Cell:hasValue()
    -- If value is 0 then it has no value.

    if self.value == 0 then
        return false
    end

    return true
end

function Cell:isColliding(x, y)
    if x >= self.x and x <= (self.x + self.width) and y >= self.y and y <= (self.y + self.width) then
        return true
    end

    return false
end

function Cell:mousePressed(x, y, button, istouch, presses)
    if self:isColliding(x, y) then
        if button == 1 then
            if self.state == self.states.setValue then
                self.state = self.states.normal
            else
                self.state = self.states.setValue
            end
        elseif button == 2 then
            self.value = 0
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
    -- Mouse hover
    if self.state == self.states.normal then
        if self:isColliding(love.mouse.getX(), love.mouse.getY()) then
            self.state = self.states.hover
        end
    elseif self.state == self.states.hover then
        if not self:isColliding(love.mouse.getX(), love.mouse.getY()) then
            self.state = self.states.normal
        end
    end
end

function Cell:draw()
    if self.state == self.states.normal then
        love.graphics.setColor(self.normalColor)
    elseif self.state == self.states.setValue then
        love.graphics.setColor(self.setValueColor)
    elseif self.state == self.states.hover then
        love.graphics.setColor(self.hoverColor)
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
