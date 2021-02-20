local World = require 'src.world'
local Maze = require 'src.maze'
local Hero = require 'src.hero'
local Maze = require 'src.maze'

local world, maze, hero

local screen_size = 256

local maze_size = 10
local maze_cell_size = 20
local maze_draw_offset = (screen_size - (maze_size * maze_cell_size)) / 2

function love.load()
    --world = World.new()
    --maze = Maze:new()
    --hero = Hero.new(0, 0, world.TILE_SIZE.w, world.TILE_SIZE.h)

    --world:add(maze)
    --world:add(hero)

  maze = Maze.new(maze_size, maze_size, maze_cell_size, maze_draw_offset, maze_draw_offset)
  maze:create()

  --for i = 1, maze.w do
  --  for j = 1, maze.h do
  --    print(maze.cells[i][j].row)
  --  end
  --end
end

function love.keypressed(key)
  if key == "space" then
    maze:create()
  end
end

function love.update(dt)
    --hero:update(dt)
end

function love.draw(dt)
    love.graphics.scale(2, 2)
    --hero:draw()
    love.graphics.clear(43 / 255, 40 / 255, 33 / 255, 1)
    maze:draw()
end
