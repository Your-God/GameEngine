local SpriteClass = require("Classes/Sprite")
local Camera = require("GameEngine").Required["Camera"]
local Vector2 = require("DataTypes/Vector2")
local Mouse = {HeldDown = false, __Position = Vector2:New()}

--SpriteClass.__GetInteractionLedger()
-- Rotated Mouse Coordinates
local RMC_x = 0
local RMC_y = 0
local function WithinBounds(Obj, mX, mY)
    local AP  =  Obj.ActualPosition
    local AS  =  Obj.ActualSize * 0.5
    local Rot = -Obj.Rotation
    mX = mX - AP.x - (AS.x) -- Find the offset of the mouse to the center of the obj
    mY = mY - AP.y - (AS.y)

    -- Rotated Mouse Coordinates
    RMC_x = mX * math.cos(Rot) - mY * math.sin(Rot) + (AS.x)
    RMC_y = mX * math.sin(Rot) + mY * math.cos(Rot) + (AS.y)

    return 
        ( 0 <= RMC_x ) and
        ( 0 <= RMC_y ) and
        ( AS.x*2 >= RMC_x ) and
        ( AS.y*2 >= RMC_y )
end



function love.mousepressed( x, y, button, istouch, presses )
    Mouse.Down = true
    Mouse.Button = button
end

function love.mousereleased( x, y, button, istouch, presses )
    Mouse.Down = false
end

function Mouse.GetPosition()
    Mouse.__Position.x = love.mouse.getX()
    Mouse.__Position.y = love.mouse.getY()

    return Mouse.__Position
end





return Mouse