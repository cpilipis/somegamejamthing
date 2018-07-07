require "code/player"
require "code/load"
require "code/scenery"

collisionWorld = {}
drawWorld = {}
tileVariants = {}
collisionWorld.width = 1
collisionWorld.height = 1


function love.load()
  player.load()
  props.load()
  --[[collisionWorld = loadCollisionMap("house")
  drawWorld = loadVisMap("house") --table for cosmetics of each tile
  tileVariants = loadTileVar("house")--]]
  loadMap("house")
end

function love.update(dt)
  player.update(dt, collisionWorld, collisionWorld.height, collisionWorld.width)

end

function worldDrawDebug(someworld, h, w)
  for drawY=1, h do
    for drawX=1, w do
      if someworld[drawY][drawX] == 1 then
        love.graphics.setColor(1, 1, 1)
      else
        love.graphics.setColor(0, 0, 0)
      end
      love.graphics.rectangle("fill", (drawX-1)*32, (drawY-1)*32, 32, 32)
    end
  end
end

function worldDraw(someworld, h, w, TV)
  love.graphics.setColor(1, 1, 1)
  for drawY=1, h do
    for drawX=1, w do
      intToDraw = someworld[drawY][drawX]
      if intToDraw > 0 then
        love.graphics.draw(tileVariants[intToDraw], (drawX-1)*32, (drawY-1)*32)
      end
    end
    io.write("\n")
  end
end


function love.draw()
  love.graphics.setBackgroundColor(.55,0,.55)
  worldDraw(drawWorld, drawWorld.height, drawWorld.width, tileVariants)
  props.draw()
  player.draw()
end
