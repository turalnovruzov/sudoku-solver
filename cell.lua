local class = require "lib/middleclass"

Cell = class("Cell")

-- Initializes cell with
-- position x, y
-- size width
function Cell:initialize(x, y, width)
    self.x = x
    self.y = y
    self.width = width
    self.hasValue = false
    self.value = 0
    self.font = love.graphics.newFont("fonts/Adequate.ttf", 14)
    colorCode = 0.8
    self.color = {colorCode, colorCode, colorCode}
    outlineColorCode = 0.02
    self.outlineColor = {outlineColorCode, outlineColorCode, outlineColorCode}
end

function Cell:update(dt)

end

function Cell:draw()
    love.graphics.setColor(self.color)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.width)

    love.graphics.setColor(self.outlineColor)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.width)
end

return Cell
