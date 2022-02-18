Enemy = Class{}

function Enemy:init(x , y , type)
  self.x = x
  self.y = y
  self.type = type
  self.texture = 'Enemy' .. tostring(type)
  self.width = gTextures[self.texture]:getHeight()
  self.height = gTextures[self.texture]:getWidth()

end


function Enemy:update(dt)
end


function Enemy:render()
  love.graphics.draw(gTextures[self.texture] , self.x , self.y)
end
