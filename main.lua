function love.load()
    love.window.setTitle("Sudoku")
    love.window.setMode(750, 480)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    backgroundColorCode = 1
    backgroundColor = {backgroundColorCode, backgroundColorCode, backgroundColorCode}
end

function love.update()

end

function love.draw()
    love.graphics.setBackgroundColor(backgroundColor)
end