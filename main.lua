function love.load()
    love.window.setTitle("Sudoku")
    love.window.setMode(700, 400)
    backgroundColor = 0.8
end

function love.update()

end

function love.draw()
    love.graphics.setBackgroundColor(backgroundColor, backgroundColor, backgroundColor)
end