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
    self.font = love.graphics.newFont("fonts/SourceSansPro-Regular.ttf", 35)
    self.normalColor = {1, 1, 1}

    -- 187, 222, 251
    self.focusColor = {187 / 255, 222 / 255, 251 / 255}

    -- 29, 46, 66
    self.textColor = {29 / 255, 46 / 255, 66 / 255}

    -- 221, 238, 254
    self.hoverColor = {221 / 255, 238 / 255, 254 / 255}

    -- Whether the mouse is hovering over the cell
    self.hover = false

    self.states = {
        normal=0,
        focus=1
    }
    self.state = self.states.normal
end

function Cell:hasValue()
    -- Checks if the cell has value
    -- Returns false if cell's value is 0, true otherwise

    if self.value == 0 then
        return false
    end

    return true
end

function Cell:isFocused()
    -- Checks if the current state is focus
    -- Returns true if the state is focus, false otherwise

    if self.state == self.states.focus then
        return true
    end

    return false
end

function Cell:isColliding(x, y)
    -- Checks if the given point collides with the cell
    -- Returns true if collides, false otherwise

    if x >= self.x and x <= (self.x + self.width) and y >= self.y and y <= (self.y + self.width) then
        return true
    end

    return false
end

function Cell:mousePressed(x, y, button, istouch, presses)

    -- If the mouse is colliding with the cell
    if self:isColliding(x, y) then
        
        -- Primary button
        if button == 1 then
            
            -- If the state is normal, set it to focus, else do the reverse
            if self.state == self.states.normal then
                self.state = self.states.focus
            elseif self.state == self.states.focus then
                self.state = self.states.normal
            end
        
        -- Secondary button
        elseif button == 2 then
            -- Delete the cell's value and return to normal state
            self.value = 0
            self.state = self.states.normal
        end
    end
end

function Cell:keyPressed(key, scancode, isrepeat)
    -- If focus state, set the value according to the key pressed
    if self.state == self.states.focus then
        if key >= "1" and key <= "9" then
            self.value = tonumber(key)
        end
    end
end

function Cell:update(dt)
    -- Mouse hover
    if self.state == self.states.normal then
        if self:isColliding(love.mouse.getX(), love.mouse.getY()) then
            self.hover = true
        else
            self.hover = false
        end
    end
end

function Cell:draw()
    -- Select fill color
    if self.state == self.states.normal then
        if self.hover then
            love.graphics.setColor(self.hoverColor)
        else
            love.graphics.setColor(self.normalColor)
        end
    elseif self.state == self.states.focus then
        love.graphics.setColor(self.focusColor)
    end

    -- Fill
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.width)

    -- Number
    if self:hasValue() then
        love.graphics.setColor(self.textColor)
        love.graphics.printf(tostring(self.value), self.font, self.x, self.y, self.width, "center")
    end
end

return Cell
