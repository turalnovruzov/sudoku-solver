function love.load()
    love.window.setTitle("Sudoku")
    love.window.setMode(700, 400)
    backgroundColorCode = 0.85
    backgroundColor = {backgroundColorCode, backgroundColorCode, backgroundColorCode}
end

function love.update()

end

function love.draw()
    love.graphics.setBackgroundColor(backgroundColor)
end