local CoreClass_metatable = {}
--CoreClass_metatable.__index = CoreClass_metatable --What if I disable this? I think I override it anyways
local CoreClass_metatable_Functions = {}

function IsObject(Value)
  return type(Value) == "table" and Value.__IsInternalObject
end


 
local function Merge(t1, t2)
  for k, v in pairs(t2) do
      if (type(v) == "table") and (type(t1[k] or false) == "table") then
          Merge(t1[k], t2[k])
      else
          --t1[k] = v
          rawset(t1,k,v)
      end
  end
  return t1
end
 
local function __InjectIntoClass(self, Protected, Exposed, ProtectedMethods)
  self.__InternalObj.__WriteMethods = Merge(self.__InternalObj.__WriteMethods, ProtectedMethods)
  self.__InternalObj = Merge(self.__InternalObj, Protected)
  self = Merge(self, Exposed)
  
end

function CoreClass_metatable.__index(t, k)
  return t.__InternalObj[k]
end
function CoreClass_metatable.__newindex(self, key, value)
  local func = self.__InternalObj.__WriteMethods[key]
  if func then
    func(self, value)
  else
    --error("err; Attempted to assign unknown aspect: " .. key) -- should I do tostring(key)?
  end
end

function CoreClass_metatable.__tostring(self)
  return self.ClassName or "UnnamedClass_Object"
end


local ClassMT = {
  __newindex = function(t,b,c)
    print("NewIndexing",t,b,c)
    --error("attempt to update a read-only table", 2)
  end
  
}




--------------------------------------------------------------------------------
--------------------------------------------------------------------------------



local function AssignParent(self, Value)
  if Value == nil then
    --remove parent
    if self.__InternalObj.Parent then
      self.__InternalObj.Parent:RemoveChild(self)
      self.__InternalObj.Parent = nil
    end
  elseif IsObject(Value) then
    if self == Value then
      error("Cannot assign an object's Parent to itself")
    else
      self.__InternalObj.Parent = Value
      Value:AddChild(self)
    end
  else
    error("Cannot assign Parent to a non object")
  end
end

local function AddChild(self, Child)
  self.__InternalObj.Children[Child] = Child
end

local function RemoveChild(self, Child)
  self.__InternalObj.Children[Child] = nil
end

local function FindParentNamed(self, NameToFind)
  error("This method hasn't been implemented yet")
end

local function FindParentOfClass(self, ClassToFind)
  error("This method hasn't been implemented yet")
end

local function FindParentTagged(self, Tag)
  error("This method hasn't been implemented yet")
end

local function Inherited(self, Class)
  -- Checks if self inherited a Class or not
  return self.__InternalObj.__Inherits
end

local function GetChildren(self)
  local Children = {}
  for i,v in pairs(self.__InternalObj.Children) do
    table.insert(Children,v)
  end
  return Children -- Or should I just return the original Dictionary of Children?
end

local function GetChildNamed(self, NameToFind, Recursive)
  --If Recersive it will check the Children of the Children until it finds
  error("This method hasn't been implemented yet")
end

local function GetChildOfClass(self, ClassName, Recursive)
  error("This method hasn't been implemented yet")
end

local function GetChildTagged(self, TagToFind, Recursive)
  error("This method hasn't been implemented yet")
end

local function Destroy(self)
  AssignParent(self, nil)
  self.__IsObjectAlive = false -- You can now check to see if the object should be destroyed
  -- Do I even need the above?
  --setmetatable(self, nil) -- it will stop acting like a class
end


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function CoreClass_metatable.New(self, DefaultParent, DefaultName)
  local WriteMethods = {
    -- WriteProtected Values can be assigned if given a function below
    -- Said function can do logic based on the input
    Parent = AssignParent,
  }
  local WriteProtected = {
    --Anything in here can be read but will throw an error if assigned
    __IsInternalObject = true,
    __WriteMethods = WriteMethods,
    __Inject = __InjectIntoClass,
    ClassName = "Node",
    Parent = nil,
    Children = {},
    Destroy = Destroy,
    FindParentNamed = FindParentNamed,
    GetChildren = GetChildren,
    GetChildNamed = GetChildNamed,
    GetChildOfClass = GetChildOfClass,
    GetChildTagged = GetChildTagged,
    AddChild = AddChild,
    RemoveChild = RemoveChild,
  }
  local WriteExposed = {
    -- Can be freely assigned with no problem
    __InternalObj = WriteProtected, -- It's unprotected! Please please please don't mess with it.
    __IsObjectAlive = true, -- should object be ignored because its dead... do I even need this?
    Name = DefaultName or WriteProtected.ClassName,
  }
  --------------------------------------------------------------------------------

  local FinishedObj = setmetatable(WriteExposed, CoreClass_metatable)
  -- Anything that should be done after the Object is setup should be done here
  
  if DefaultParent then AssignParent(FinishedObj, DefaultParent) end
  return FinishedObj
end



return CoreClass_metatable