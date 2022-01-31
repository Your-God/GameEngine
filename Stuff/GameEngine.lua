local GameEngine = {Required = {}}


function GameEngine.New(self, ObjType, ...)
    Load()
    assert(self == GameEngine, "Use ':' not '.'")
    if GameEngine.Required[ObjType] then
        return GameEngine.Required[ObjType]:New(...)
    else
        error("Invalid Class Name")
    end
end

function GameEngine.Get(self, ObjType)
    Load()
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

local Loaded = false
function Load()
    if Loaded then return end
    Loaded = true
    print("LOADED")
    -- This lets us create a GameEngine Obj without having to require every modulo immidietly
    -- This avoids a require loop where one of the following modulos requires another modulo
    
    GameEngine.Required["Camera"] = require("bin/STALKER_X")()
    GameEngine.Required["Mouse"] = require("bin/Mouse")

    GameEngine.Required["Core"] = require("Classes/CoreClass")
    GameEngine.Required["Transformation"] = require("Classes/Transformation")
    GameEngine.Required["Scene"] = require("Classes/Scene")
    GameEngine.Required["Frame"] = require("Classes/Frame")
    GameEngine.Required["Sprite"] = require("Classes/Sprite")
    GameEngine.Required["Text"] = require("Classes/Text")
    GameEngine.Required["Collider"] = require("Classes/Collider")

    GameEngine.Required["EventManager"] = require("DataTypes/EventManager")
    GameEngine.Required["UDim2"] = require("DataTypes/UDim2")
    GameEngine.Required["Vector2"] = require("DataTypes/Vector2")
    GameEngine.Required["Color3"] = require("DataTypes/Color3")
    GameEngine.Required["World"] = require("DataTypes/World")
end


return GameEngine