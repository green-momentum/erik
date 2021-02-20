-- local World = require('world')
local Hero = require('hero')

-- local hero, world
local hero

function love.load()
    -- world = World.new()
    hero = Hero.new(0, 0)
end

function love.update(dt)
    hero:update(dt)
end

function love.draw(dt)
    hero:draw()
end
