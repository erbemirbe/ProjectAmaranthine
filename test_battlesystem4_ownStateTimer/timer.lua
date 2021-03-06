

-- TODO: make persistent to avoid creating new one all the time, needs reset() + pause state

local Timer = {}


function Timer:new()
  local obj = {}
  
  setmetatable(obj, self)
  self.__index = self
  
  obj._acc = 0
  
  return obj
end


function Timer:update(dt)
  self._acc = self._acc + dt
end

function Timer:reached(time)
  return self._acc >= time
end

function Timer:reset()
  self._acc = 0
end


return Timer