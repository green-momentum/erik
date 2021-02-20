-- local World = require('world')
local Hero = require 'hero'

-- local hero, world
local hero

function love.load()
    -- world = World.new()

    -- TODO: shall we disable key repeat? I added this to move the hero one by one.
    love.keyboard.setKeyRepeat(false)
    hero = Hero.new(0, 0)
end

function love.update(dt)
    hero:update(dt)
end

function love.draw(dt)
    love.graphics.scale(2, 2)
    hero:draw()
end
