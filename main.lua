local SM = require 'src.state_manager'
local flux = require 'lib.flux'
local inspect = require 'lib.inspect'
local Timer = require "lib.timer"
local game_state = require 'src.game_state'
local opening_state = require 'src.opening_state'
local info_state = require 'src.info_state'
local pre_state = require 'src.pre_state'
local ending_state = require 'src.ending_state'
local fail_state = require 'src.fail_state'

function love.load()
    sm = SM.new()
    sm:register("opening_state", opening_state)
    sm:register("info_state", info_state)
    sm:register("pre_state", pre_state)
    sm:register("game_state", game_state)
    sm:register("ending_state", ending_state)
    sm:register("fail_state", fail_state)

    sm:setState("opening_state")
end

function love.keypressed(key)
    sm:keypressed(key)
end

function love.update(dt)
    flux.update(dt)
    Timer.update(dt)
    sm:update(dt)
end

function love.draw(dt)
    -- camera:attach()
    -- do your drawing here
    sm:draw(dt)
    -- camera:detach()
end
