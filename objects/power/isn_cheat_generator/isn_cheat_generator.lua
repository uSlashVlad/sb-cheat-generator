require '/scripts/fupower.lua'

function init()
	self.powerLevel = config.getParameter("powerLevel",1)
	power.init()
end

function update(dt)
	storage.checkticks = (storage.checkticks or 0) + dt
	if storage.checkticks >= 10 then
		storage.checkticks = storage.checkticks - 10
      	animator.setAnimationState("meter", "4")
		power.setPower(999999999999)
	end
	power.update(dt)
end
