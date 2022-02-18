Player = Class{}

function Player:init(x , y , size )
self.x = x
self.y = y
self.width = size
self.height = size
self.dx = 0
end

function Player:update(dt)
if self.dx < 0 then
  self.x = math.max(0 , self.x + self.dx * dt)
else
  self.x = math.min(WINDOW_WIDTH - self.width , self.x + self.dx * dt)
end

end


function Player:render()
love.graphics.draw(gTextures['playerArt'] , self.x  , self.y )
end
