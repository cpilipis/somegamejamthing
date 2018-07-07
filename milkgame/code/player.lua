require "code/collisions"
require "code/misc"

player = {}
function player.load()
player.x = 85
player.y = 160
player.xvel = 0
player.yvel = 0
player.width = 22
player.height = 44
player.jump = 220
player.speed = 220
player.acc = 500 --player acceleration rate
player.grounded = false
end

function player.update(dt, world, h, w)
  player.walk(dt)
  player.move(dt, world, h, w)
  player.unstick(world, h, w)
end

function player.draw()
love.graphics.setColor(1, 0, 0)
love.graphics.rectangle("fill", player.x, player.y, player.width, player.height)
thing = {}
thing[1] = proptypes[1]
thing[2] = proptypes[4]
thing[3] = proptypes[3]
thing.count = 3
if player.x < 400 then
  player.think(thing, {"+", "+", "+"})
end
end

function player.move(dt, someworld, h, w)
  player.grounded = false
  for worldY=1, h do
    for worldX=1, w do
      if someworld[worldY][worldX] == 1 then
        if checkRectWithTile(player.x + player.xvel*dt, player.y, player.width, player.height, worldX, worldY) then
          player.xvel = 0
        end
        if checkRectWithTile(player.x, player.y + player.yvel*dt, player.width, player.height, worldX, worldY) then
          player.yvel = 0
        end

        if math.ceil(player.y + player.height) == ((worldY-1) * 32) and rectsLinedUpHorizontally(player.x, player.x + player.width, (worldX-1)*32, (worldX)*32) then
          player.grounded = true
        end
      end
    end
  end
  player.x = player.x + player.xvel * dt
  player.y = player.y + player.yvel * dt
  player.yvel = player.yvel + 512 * dt
end

function player.walk(dt)
  walking = false
  if player.grounded then
    if love.keyboard.isDown("up") then
      player.yvel = -player.jump
    end
  end
  if love.keyboard.isDown("left") then
    if player.xvel > -player.speed then
      multi = 1
      if player.xvel > 0 then multi = 2.4 end
      player.xvel = player.xvel - dt*player.acc*multi
    end
    walking = true
  end

  if love.keyboard.isDown("right") then
    if player.xvel < player.speed then
      multi = 1
      if player.xvel < 0 then multi = 2.4 end
      player.xvel = player.xvel + dt*player.acc
    end
    walking = true
  end
  if walking == false and math.abs(player.xvel) > 1 and player.grounded == true then
    player.xvel = player.xvel - signof(player.xvel)*dt*player.acc
  end
  if math.abs(player.xvel) <= 1 and walking == false then
    player.xvel = 0
  end
  
  if love.keyboard.isDown("down") then
    player.height = 22
  else
    player.height = 44
  end
end

function player.unstick(world, h, w)
  for worldY=1, h do
    for worldX=1, w do
      if world[worldY][worldX] == 1 then
        while checkRectWithTile(player.x, player.y, player.width, player.height, worldX, worldY) do
	  player.y = player.y - 1
	  print("Looks like the player is stuck!")
	end
      end
    end
  end
end

function player.think(foodForThought, connectors)
  love.graphics.setColor(1, 1, 1)
  playerCornerX = player.x + player.width
  love.graphics.circle("fill", playerCornerX + 10, player.y - 10, 5, 50)
  love.graphics.circle("fill", playerCornerX + 25, player.y - 25, 10, 50)
  thoughtWidth = foodForThought.count * 16
  thoughtStartX = playerCornerX + 40
  love.graphics.ellipse("fill", playerCornerX + 35 + thoughtWidth, player.y - 65, thoughtWidth, 35)
  for stuffToGo = 1, foodForThought.count do
    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(foodForThought[stuffToGo], thoughtStartX + (stuffToGo-1)*32, player.y - 75, 0, 1.5, 1.5)
    love.graphics.setColor(0, 0, 0)
    if stuffToGo ~= foodForThought.count then love.graphics.print(connectors[stuffToGo], thoughtStartX + (stuffToGo-.3) * 32, player.y - 70) end
  end
end