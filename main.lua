-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local title = display.newText("Tic-Tac-Toe", display.contentCenterX, 25, native.SystemFontBold, 20)

local leftVL = display.newRect(display.contentCenterX-50, display.contentCenterY, 5, 300)
local rightVL = display.newRect(display.contentCenterX+50, display.contentCenterY, 5, 300)
local topHL = display.newRect(display.contentCenterX, display.contentCenterY-50, 300, 5)
local bottomHL = display.newRect(display.contentCenterX, display.contentCenterY+50, 300, 5)