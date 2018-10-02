local widget = require("widget")

local winningLine
local winningText
local resetButton
local allowMoves = true

local title = display.newText("Tic-Tac-Toe", display.contentCenterX, 25, native.SystemFontBold, 20)

local leftVL = display.newRect(display.contentCenterX-50, display.contentCenterY, 5, 300)
local rightVL = display.newRect(display.contentCenterX+50, display.contentCenterY, 5, 300)
local topHL = display.newRect(display.contentCenterX, display.contentCenterY-50, 300, 5)
local bottomHL = display.newRect(display.contentCenterX, display.contentCenterY+50, 300, 5)

local spots = {}
local col = { 0.2, 0.2, 0.2 }

local player = "X"

local winPatterns = {}

winPatterns[1] = { 1, 2, 3 }
winPatterns[2] = { 4, 5, 6 }
winPatterns[3] = { 7, 8, 9 }
winPatterns[4] = { 1, 4, 7 }
winPatterns[5] = { 2, 5, 8 }
winPatterns[6] = { 3, 6, 9 }
winPatterns[7] = { 1, 5, 9 }
winPatterns[8] = { 7, 5, 3 }

local function resetGame()
    for i=1, #spots do
        spots[i].moveText.text = " "
        spots[i].moveType = nil
    end
    
    display.remove(winningLine)
    winningLine = nil
    display.remove(winningText)
    winningText = nil
    display.remove(resetButton)
    resetButton = nil
    player = "X"
    allowMoves = true
end

local function gameOver(winningMove, currentPlayer)
    allowMoves = false
    if winningMove then
        local startX = spots[winPatterns[winningMove][1]].x
        local startY = spots[winPatterns[winningMove][1]].y
        local endX = spots[winPatterns[winningMove][3]].x
        local endY = spots[winPatterns[winningMove][3]].y
        winningLine = display.newLine(startX, startY, endX, endY)
        winningLine:setStrokeColor(1, 0, 0)
        winningLine.strokeWidth = 5
        winningText = display.newText("Player " .. currentPlayer .. " won!", display.contentCenterX, display.contentHeight - 60, native.SystemFontBold, 30)
    else
        winningText = display.newText("Stalemate", display.contentCenterX, display.contentHeight - 60, native.SystemFontBold, 30)
    end
    resetButton = widget.newButton({
        label = "Reset",
        x = display.contentCenterX,
        y = display.contentHeight - 20,
        font = native.SystemFontBold,
        fontSize = 20,
        labelColor = {default = {0.75, 0.75, 1}, over = {1, 1, 1}},
        onPress = resetGame
    })
end

local function stalemate()
    for i=1, #spots do
        if spots[i].moveType == nil then
            return
        end
    end

    gameOver(nil, nil)
end

local function isGameOver(currentPlayer)
    local isWinner = false
    for i=1, #winPatterns do
        if spots[winPatterns[i][1]].moveType == currentPlayer and 
            spots[winPatterns[i][2]].moveType == currentPlayer and 
            spots[winPatterns[i][3]].moveType == currentPlayer then
                isWinner = true
                gameOver( i, currentPlayer )
            break
        end
    end

    if not isWinner then
        stalemate()
    end

    if currentPlayer == "O" then 
        player = "X"
    else
        player = "O"
    end
end

local function handleTouch(event)
    if event.phase == "began" then
        if event.target.moveType == nil and allowMoves then
            event.target.moveText.text = player
            event.target.moveType = player
            
            isGameOver(player)
        end
    end
    return true
end

for i=1, 9 do
    spots[i] = display.newRect(0, 0, 90, 90)
    spots[i]:setFillColor(unpack(col))
    spots[i].x = (i-1)%3*100+60
    spots[i].y = math.floor((i-1)/3)*100+140
    spots[i].moveText = display.newText("", spots[i].x, spots[i].y, native.SystemFontBold, 50)
    spots[i].moveType = nil

    spots[i]:addEventListener("touch", handleTouch)
end