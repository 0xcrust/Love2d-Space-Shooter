Projectile = Class{}

function Projectile:init(spawnX, spawnY)
  self.spawnX = spawnX
  self.spawnY = spawnY
  self.width = gTextures['ProjectileArt']:getWidth()
  self.height = gTextures['ProjectileArt']:getHeight()
  self.dy = -300

end

function Projectile:update(dt)
  self.spawnY = self.spawnY + self.dy * dt

end

function Projectile:collides(target)

  if Projectile.spawnY > target.y + target.height then
    return true
  end

end


function Projectile:render()
  --love.graphics.rectangle('fill' , self.spawnX - (self.width/2) , self.spawnY , self.width , self.height )
  love.graphics.draw(gTextures['ProjectileArt'], self.spawnX, self.spawnY, 0, 0.5, 0.5)
end
