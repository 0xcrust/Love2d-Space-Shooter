Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'Player'
require 'Projectile'
require 'Enemy'


WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 256
VIRTUAL_HEIGHT = 144

PROJECTILE_INTERVAL = 2
PROJECTILE_WIDTH = 48

playerYOffset = 20

playerSize = 96

playerX = WINDOW_WIDTH/2 - playerSize/2
playerY = WINDOW_HEIGHT - playerSize - playerYOffset

gTextures = {
  ['Background1'] = love.graphics.newImage('Graphics/Background.jpg'),
  ['Background2'] = love.graphics.newImage('Graphics/Background2.jpg'),
  ['playerArt'] = love.graphics.newImage('Graphics/Player.png'),
  ['ProjectileArt'] = love.graphics.newImage('Graphics/bullet.png'),
  ['Enemy1'] = love.graphics.newImage('Graphics/Enemy1.png'),
  ['Enemy2'] = love.graphics.newImage('Graphics/Enemy2.png'),
  ['Enemy3'] = love.graphics.newImage('Graphics/Enemy3.png'),
  ['Enemy4'] = love.graphics.newImage('Graphics/Enemy4.png'),
  ['Enemy5'] = love.graphics.newImage('Graphics/Enemy5.png'),
  ['Enemy6'] = love.graphics.newImage('Graphics/Enemy6.png'),
  ['Enemy7'] = love.graphics.newImage('Graphics/Enemy7.png')
}


function love.load()

player1 = Player(playerX , playerY , playerSize)

math.randomseed(os.time())
projectiles = {}

enemies = generateEnemies()

push:setupScreen(VIRTUAL_WIDTH , VIRTUAL_HEIGHT , WINDOW_WIDTH , WINDOW_HEIGHT , {
  vsync = true,
  resizable = false,
  fullscreen = false
})

love.keyboard.keysPressed = {}

end

function love.resize(w,h)
  push:resize(w,h)
end

function love.keypressed(key)
  if key == 'escape' then
    love.event.quit()

  elseif key == 'space' then
    table.insert(projectiles , Projectile( player1.x + player1.width/2 - PROJECTILE_WIDTH/2 , player1.y - 20 ))
  end



love.keyboard.keysPressed[key] = true

end


function love.keyboard.wasPressed(key)
  return love.keyboard.keysPressed[key]
end


function love.update(dt)

if love.keyboard.isDown('left') then
  player1.dx = -400
elseif love.keyboard.isDown('right') then
  player1.dx = 400
else
  player1.dx = 0
end

player1:update(dt)

for i = 1 , #projectiles do
  projectiles[i]:update(dt)
end

love.keyboard.keysPressed = {}


end



function love.draw()

love.graphics.draw(gTextures['Background2'], 0, 0, 0, WINDOW_WIDTH/gTextures['Background2']:getWidth(),
 WINDOW_HEIGHT/gTextures['Background2']:getHeight())

  player1:render()

  for i = 1 , #projectiles do
    projectiles[i]:render()
  end

  for i = 1 , #enemies do
    enemies[i]:render()
  end
--love.graphics.rectangle('line', player1.x, player1.y, player1.width, player1.height) //for debugging

end


function generateEnemies()
  local enemy_type = math.random(2, 4)
  local size = gTextures['Enemy' .. tostring(enemy_type)]:getWidth()
  local num_rows = math.random(2,3)
  local start_x = 10
  local start_y = 10
  local enemies  = {}
  local yOffset = 60
  local xOffset = 20

  local drawX = 0
  local drawY = 0


local num_cols = math.floor(WINDOW_WIDTH/(size + xOffset))


  for y = 1 , num_rows do
    for x = 1 , num_cols do

      drawX = (x-1) * size + (x-1) * xOffset
      drawY = (y-1) * size + (y-1) * yOffset

      table.insert(enemies , Enemy(drawX, drawY , enemy_type))


    end
  end

  return enemies

end
