
require "player"

local vec = require "hump.vector" -- TODO: replace with own lib

local GUIBar = require "guiBar"


local stateBattle = {}


local background

local GUIPlayerHealth = GUIBar:new(vec(300, 900) , vec(300, 30))
GUIPlayerHealth.innerColor = {255, 000, 000}

local GUIPlayerSP     = GUIBar:new(vec(300, 940) , vec(300, 30))
GUIPlayerSP.innerColor = {000, 255, 255}


local GUIEnemyHealth  = GUIBar:new(vec(1200, 200), vec(300, 30))
GUIEnemyHealth.innerColor = {255, 000, 000}


function stateBattle:init()
  background = love.graphics.newImage("assets/background.png")
end

function stateBattle:enter()
  player:reset()
----  enemy:reset()

  GUIPlayerHealth:setTrackTarget(player, "health", 0, player.maxhealth)
  GUIPlayerSP:setTrackTarget(player, "SP", 0, player.maxSP)

--  GUIEnemyHealth:setTrackTarget(enemy, "health", 0, enemy.maxhealth)
end


function stateBattle:update(dt)
  player:update(dt)
--  enemy:update(dt)

  GUIPlayerHealth:update(dt)
  GUIPlayerSP:update(dt)

--  GUIEnemyHealth:update(dt)
end

function stateBattle:draw()
  love.graphics.draw(background, nil, nil, nil, nil, nil, 250, 250)

--  enemy:draw (nil, nil, nil, nil, nil, 250, 250)
  player:draw(nil, nil, nil, nil, nil, 250, 250)

  GUIPlayerHealth:loveDraw()
  GUIPlayerSP:loveDraw()
--  GUIEnemyHealth:loveDraw()
end


return stateBattle