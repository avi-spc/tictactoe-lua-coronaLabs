
local title = display.newText("Tic-Tac-Toe", display.contentCenterX, 25, native.SystemFontBold, 20)

local leftVL = display.newRect(display.contentCenterX-50, display.contentCenterY, 5, 300)
local rightVL = display.newRect(display.contentCenterX+50, display.contentCenterY, 5, 300)
local topHL = display.newRect(display.contentCenterX, display.contentCenterY-50, 300, 5)
local bottomHL = display.newRect(display.contentCenterX, display.contentCenterY+50, 300, 5)

local spots = {}
local col = { 0.2, 0.2, 0.2 }

local player = "X"

local function handleTouch(event)
    if event.phase == "began" then
        if event.target.moveType == nil then
            if player == "X" then
                event.target.moveText.text = player
                event.target.moveType = player
                player = "O"
            else
                event.target.moveText.text = player
                event.target.moveType = player
                player = "X"
            end
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