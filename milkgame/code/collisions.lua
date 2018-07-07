function ptWithinRect(px, py, rectx, recty, xlen, ylen)
  if px > rectx and py > recty and px < rectx + xlen and py < recty + ylen then
    return true
  else
    return false
  end
end

function rectsLinedUpHorizontally(x1, x2, x3, x4) --Check if one rectangle is aligned with another
  inside = false
  if (x1 >= x3 and x1 <= x4) or (x2 >= x3 and x2 <= x4) then
    inside = true
  end

  if (x3 >= x1 and x3 <= x2) or (x4 >= x1 and x4 <= x2) then
    inside = true
  end

  return inside
end

function checkRectWithTile(rectX, rectY, rectWidth, rectHeight, tX, tY)
  collided = false
  if ptWithinRect(rectX, rectY, (tX-1)*32, (tY-1)*32, 32, 32) then
    collided = true
    --print("top right collide")
  end
  if ptWithinRect(rectX + rectWidth, rectY, (tX-1)*32, (tY-1)*32, 32, 32) then
    collided = true
    --print("top left collide")
  end
  if ptWithinRect(rectX + rectWidth, rectY + rectHeight, (tX-1)*32, (tY-1)*32, 32, 32) then
    collided = true
    --print("bottom left collide")
  end
  if ptWithinRect(rectX, rectY + rectHeight, (tX-1)*32, (tY-1)*32, 32, 32) then
    collided = true
    --print("bottom right collide")
  end

  if ptWithinRect((tX-1)*32, (tY-1)*32, rectX, rectY, rectWidth, rectHeight) then
    collided = true
  end

  if ptWithinRect((tX-1)*32 + 32, (tY-1)*32, rectX, rectY, rectWidth, rectHeight) then
    collided = true
  end

  if ptWithinRect((tX-1)*32 + 32, (tY-1)*32 + 32, rectX, rectY, rectWidth, rectHeight) then
    collided = true
  end

  if ptWithinRect((tX-1)*32, (tY-1)*32 + 32, rectX, rectY, rectWidth, rectHeight) then
    collided = true
  end

  return collided
end
