
local Animation = require "animation"
local AC = {}


function AC:new()
  obj = {}

  setmetatable(obj, self)
  self.__index = self

  obj.curAnim = nil
  obj.default = nil
  
  obj.animations = {}

  return obj
end

-- Sets a default animation to switch to when other animations are done
-- Will always loop
function AC:setDefault(name)
  self:checkInCollection(name)
  
  self.default = name
end


function AC:addAnimation(name, animation, setAsCurrent, looping)
  do -- Error checking, name is string, animation is Animation, name not already in collection
    assert(type(name) == "string", "AnimationCollection:newAnimation(): name must be string!")
    assert(getmetatable(animation) == Animation, "AnimationCollection:newAnimation(): animation must be Animation!")

    assert(not self.animations[name], "Animation already exists in collection")
    --return nil, "Animation already exists" -- Error?
  end 
  --

  self.animations[name] = animation

  if setAsCurrent or self.curAnim == nil then
    self:setAnimation(name, looping)
  end
end
--

function AC:setAnimation(name, looping)
  self:checkInCollection(name)
  
  if name == self.curName then -- This animation is already playing, don't change (NOTE: not thought through)
    self.curAnim.looping = looping or false -- redundant but clear (Also not thought through, tired, probably hacky)
    return
  end

  -- TODO: maybe make a NULL Animation
  if self.curAnim then self.curAnim:stop() end-- NOTE: this might actually be better to not have here, double check when doing QA on animation switching
  
  self.curName = name
  self.curAnim = self.animations[self.curName]
  
  self.curAnim = self.animations[name]:play()
  self.curAnim.looping = looping or false
end



function AC:update(dt)
  self.curAnim:update(dt)
  
  if not self.curAnim.playing and self.default then
    self:setAnimation(self.default, true) -- Always loop default
--    print("Thing")
--    print(self.curName, self.curAnim.looping)
  end
end


function AC:draw()
  self.curAnim:draw()
end


function AC:checkInCollection(name)
  assert(type(name) == "string", "AnimationCollection: name must be string!")
  assert(self.animations[name] ~= nil, "AnimationCollection: Animation " .. name .. " is not in the collection!")
end


return AC