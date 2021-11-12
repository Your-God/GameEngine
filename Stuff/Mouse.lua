local SpriteClass = require("Classes/Sprite")

--SpriteClass.__GetInteractionLedger()


local function WithinBounds(Obj, mX, mY)
    local AP = Obj.ActualPosition
    local AS = Obj.ActualSize
    return 
        ( AP.x <= mX ) and
        ( AP.x + AS.x >= mX) and
        ( AP.y <= mY ) and
        ( AP.y + AS.y >= mY )
end



function love.mousepressed( x, y, button, istouch, presses )
    local HighestLayer = -math.huge
    local HighestObject = nil
    for Obj, ID in pairs(SpriteClass.__GetInteractionLedger()) do
        if (Obj.ListenToMouse) and (ID > HighestLayer) and (WithinBounds(Obj, x, y)) then
            HighestLayer = ID
            HighestObject = Obj
        end
    end

    if HighestObject then
        HighestObject.OnMouseDown:Fire( x, y, button, istouch, presses )
    end
end