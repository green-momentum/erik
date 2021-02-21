local SM = require 'src.state_manager'
local flux = require 'lib.flux'
local inspect = require 'lib.inspect'
local game_state = require 'src.game_state'
local opening_state = require 'src.opening_state'

function love.load()
  sm = SM.new()
  sm:register("opening_state", opening_state)
  sm:register("game_state", game_state)
  sm:setState("opening_state")
end

function love.keypressed(key)
  sm:keypressed(key)
end

function love.update(dt)
  flux.update(dt)
  sm:update(dt)
end

function love.draw(dt)
  --camera:attach()
  -- do your drawing here
  sm:draw(dt)
  --camera:detach()
end
