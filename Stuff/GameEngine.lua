local GameEngine = {Required = {}}
local Mouse = require("Mouse")

function GameEngine.New(self, ObjType, ...)
    assert(self == GameEngine, "Use ':' not '.'")
    if GameEngine.Required[ObjType] then
        return GameEngine.Required[ObjType]:New(...)
    else
        error("Invalid Class Name")
    end
end

function GameEngine.Get(self, ObjType)
    -- Get() returns the Class itself rather than creating an instance of it
    -- Perfect for if you create the class often
    -- local Class = GameManager:Get("Class")
    -- Class:New()
    assert(self == GameEngine, "Use ':' not '.'")
    if GameEngine.Required[ObjType] then
        return GameEngine.Required[ObjType]
    else
        error("Invalid Class Name")
    end
end


GameEngine.Required["Core"] = require("Classes/CoreClass")
GameEngine.Required["Transformation"] = require("Classes/Transformation")
GameEngine.Required["Scene"] = require("Classes/Scene")
GameEngine.Required["Frame"] = require("Classes/Frame")
GameEngine.Required["Sprite"] = require("Classes/Sprite")

GameEngine.Required["EventManager"] = require("DataTypes/EventManager")
GameEngine.Required["UDim2"] = require("DataTypes/UDim2")
GameEngine.Required["Vector2"] = require("DataTypes/Vector2")


return GameEngine