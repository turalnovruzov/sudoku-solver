Board = require "board"

function love.load()
    love.window.setTitle("Sudoku")
    love.window.setMode(750, 480)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    backgroundColorCode = 1
    backgroundColor = {backgroundColorCode, backgroundColorCode, backgroundColorCode}

    board = Board:new(10, 10)
end

function love.mousepressed(x, y, button, istouch, presses)
    board:mousePressed(x, y, button, istouch, presses)
end

function love.keypressed(key, scancode, isrepeat)
    board:keyPressed(key, scancode, isrepeat)
end

function love.update(dt)
    board:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(backgroundColor)
    board:draw()
end