function loadCollisionMap(mapname)
  io.write("\n\nLoading collision map:\n\n")
  collMap = {}
  io.input("levels/" .. mapname .. "/coll.txt")
  lineCounter = 1
  collCounter = 1
  collMap[lineCounter] = {}
  newColl = 0
  while newColl ~= 3 do
    newColl = io.read("*number")
    io.write(newColl .. " ")
    if newColl == 2 then
      collMap.width = collCounter
      collCounter = 1
      lineCounter = lineCounter + 1
      collMap[lineCounter] = {}
      io.write("\n")
    elseif newColl <= 1 then
      collMap[lineCounter][collCounter] = newColl
      collCounter = collCounter + 1
    end
  end
  collMap.height = lineCounter
  return collMap
end

function loadVisMap(mapname)
  io.write("\n\nLoading visible map:\n\n")
  visiMap = {}
  io.input("levels/" .. mapname .. "/levl.txt")
  lineCounter = 1
  thingCounter = 1
  visiMap[lineCounter] = {}
  newVisi = 0
  while newVisi ~= -1 do
    newVisi = io.read("*number")
    io.write(newVisi)
    if newVisi then
      if newVisi == 0 then
        visiMap.width = thingCounter - 1
        thingCounter = 1
        lineCounter = lineCounter + 1
        visiMap[lineCounter] = {}
        io.write("\n")
      elseif newVisi > 0 then
        visiMap[lineCounter][thingCounter] = newVisi
        thingCounter = thingCounter + 1
        io.write("_")
      end
    end
  end
  visiMap.height = lineCounter
  return visiMap
end

function loadTileVar(mapname)
  io.write("\n\nLoading Tile Variation:\n\n")
  tileVar = {}
  io.input("levels/" .. mapname .. "/tile.txt")
  tileCounter = 1
  tile = ""
  while true do
    tile = io.read("*line")
    if tile == nil then break end
    tileVar[tileCounter] = love.graphics.newImage("assets/tiles/" .. tile)
    tileCounter = tileCounter + 1
  end
  return tileVar
end

function loadPropTypes(mapname)
  io.write("\n\nLoading prop types:\n\n")
  propTypes = {}
  io.input("levels/" .. mapname .. "/proptype.txt")
  typeCounter = 1
  newType = ""
  while true do
    newType = io.read("*line")
    if newType == nil then break end
    propTypes[typeCounter] = love.graphics.newImage("assets/sprites/" .. newType)
    typeCounter = typeCounter + 1
  end
  return propTypes
end

function loadThings(mapname, proptypes)
  io.write("\n\nLoading things:\n\n")
  things = {}
  things.count = 1
  things[1] = {}
  io.input("levels/" .. mapname .. "/props.txt")
  while true do
    things[things.count].image = proptypes[io.read("*number")]
    things[things.count].x = io.read("*number")
    things[things.count].y = io.read("*number")  
    nextOne = io.read("*number")
    if nextOne == -1 then
      break
    else
      things.count = things.count + 1
      things[things.count] = {}
    end
  end
  return things
end

function loadMap(mapname)
  collisionWorld = loadCollisionMap("house")
  drawWorld = loadVisMap("house") --table for cosmetics of each tile
  tileVariants = loadTileVar("house")
  props.things = loadThings("house", loadPropTypes("house"))
end