local class = require "lib/middleclass"

Button = class("Button")

function Button:initialize(x, y, width, fontSize, text)
    self.x = x
    self.y = y
    self.font = love.graphics.newFont("fonts/SourceSansPro-Regular.ttf", fontSize)
    self.width = width
    self.height = self.font:getHeight() + 5
    self.text = text

    self.hover = false
    
    -- 74, 144, 226
    self.color = {74 / 255, 144 / 255, 226 / 255}

    -- 105, 167, 240
    self.hoverColor = {105 / 255, 167 / 255, 240 / 255}

    -- 255, 255, 255
    self.textColor = {1, 1, 1}
end

function Button:isColliding(x, y)
    -- Checks if the given point collides with the Button
    -- Returns true if collides, false otherwise

    if x >= self.x and x <= (self.x + self.width) and y >= self.y and y <= (self.y + self.height) then
        return true
    end

    return false
end

function Button:mousePressed(x, y, button, istouch, presses)
    if self:isColliding(x, y) and button == 1 then
        return true
    end
    
    return false
end

function Button:update(dt)
    -- Mouse hover
    if self:isColliding(love.mouse.getX(), love.mouse.getY()) then
        if not self.hover then
            self.hover = true
        end
    else
        if self.hover then
            self.hover = false
        end
    end
end

function Button:draw()
    if self.hover then
        love.graphics.setColor(self.hoverColor)
    else
        love.graphics.setColor(self.color)
    end

    -- Button
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height, 5)

    -- Text
    love.graphics.setColor(self.textColor)
    love.graphics.printf(self.text, self.font, self.x, self.y, self.width, "center")
end

return Button
