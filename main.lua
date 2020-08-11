Board = require "board"
Button = require "button"

function love.load()
    love.window.setTitle("Sudoku")
    love.window.setMode(750, 480)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    backgroundColorCode = 1
    backgroundColor = {backgroundColorCode, backgroundColorCode, backgroundColorCode}

    board = Board:new(10, 10)
    newGameButton = Button:new(495, 160, 230, 42, "New Game")
    solveButton = Button:new(495, 260, 230, 42, "Solve")
end

function love.mousepressed(x, y, button, istouch, presses)
    board:mousePressed(x, y, button, istouch, presses)

    if newGameButton:mousePressed(x, y, button, istouch, presses) then
        board = Board:new(10, 10)
    end

    if solveButton:mousePressed(x, y, button, istouch, presses) then
        -- TODO
    end
end

function love.keypressed(key, scancode, isrepeat)
    board:keyPressed(key, scancode, isrepeat)
end

function love.update(dt)
    board:update(dt)
    newGameButton:update(dt)
    solveButton:update(dt)
end

function love.draw()
    love.graphics.setBackgroundColor(backgroundColor)
    board:draw()
    newGameButton:draw()
    solveButton:draw()
end