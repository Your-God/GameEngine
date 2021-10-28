local SuperClass = require("Classes/CoreClass")
local SubClassMetaTable = {}





function SubClassMetaTable.New(self, DefaultParent, DefaultName)
  local SuperObj = SuperClass:New(DefaultParent, DefaultName)
  -- SuperObj is the Class which this class Inherits; Like SuperClass but is an Object
  
  
  local WriteMethods = {
    
  }
  local WriteProtected = {
    --Anything in here can be read but will throw an error if assigned
    ClassName = "SubClass",
  }
  local WriteExposed = {
    -- Can be freely assigned with no problem
    Name = DefaultName or WriteProtected,
  }
  SuperObj:__Inject(WriteProtected, WriteExposed, WriteMethods) -- Injects the SuperObj with our updated Values
  --------------------------------------------------------------------------------
  -- Anything that should be done after the Object is setup should be done here
  
  
  return SuperObj
end



return SubClassMetaTable
