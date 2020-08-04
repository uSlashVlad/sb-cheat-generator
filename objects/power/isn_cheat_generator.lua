require '/scripts/power.lua'

function init()
  self.powerLevel = config.getParameter("powerLevel",1)
  power.init()
end

function update(dt)
  storage.checkticks = (storage.checkticks or 0) + dt
  if storage.checkticks >= 10 then
    storage.checkticks = storage.checkticks - 10
    if isn_powerGenerationBlocked() then
      animator.setAnimationState("meter", "0")
      power.setPower(0)
    else
      animator.setAnimationState("meter", "4")

      power.setPower(999999999999)
    end
  end
  power.update(dt)
end

function getLight(location)
  return 0
end

function isn_powerGenerationBlocked()
  -- Power generation does not occur if...
  local location = isn_getTruePosition()
  return world.underground(location) or world.lightLevel(location) < 0.2 or (world.timeOfDay() > 0.55 and world.type() ~= 'playerstation') --or world.type == 'unknown'
end

function isn_getTruePosition()
  storage.truepos = storage.truepos or {entity.position()[1] + math.random(2,3), entity.position()[2] + 1}
  return storage.truepos
end