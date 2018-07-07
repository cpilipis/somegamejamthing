require "code/load"
props = {}
props.things = {}
proptypes = {}

function props.load()
  proptypes = loadPropTypes("house")
  props.things = {}
  props.things = loadThings("house", proptypes)
end

function props.draw()
  love.graphics.setColor(255, 255, 255)
  for pc = 1, props.things.count do
    love.graphics.draw(props.things[pc].image, props.things[pc].x, props.things[pc].y)
  end
end
