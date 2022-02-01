ship.collisionRadius = 11
ship.affectedByGravity = true

ship.position.x = 0
ship.position.y = 0

ship.power = 0
ship.weapon = 0
ship.shieldStrength = 0

ship.forwardThrusterActive = false
ship.reverseThrusterActive = false

ship.lastThrust = 0
ship.lastPhoton = 0

ship.vkForward = 0
ship.vkReverse = 0
ship.vkLeft    = 0
ship.vkRight   = 0
ship.vkFire    = 0

function ship:init()
end

function ship:draw()
    love.graphics.polygon("fill", ship.position.x, ship.position.y)
end

function ship:update(dt)
    ship.vkForward = love.keyboard.isScancodeDown('w') and 1 or 0
    ship.vkReverse = love.keyboard.isScancodeDown('s') and 1 or 0
    ship.vkLeft    = love.keyboard.isScancodeDown('a') and 1 or 0
    ship.vkRight   = love.keyboard.isScancodeDown('d') and 1 or 0

    if ship.vkReverse ~= 0 or ship.vkForward ~= 0 then -- if ship going forward or back...
		-- Reset trusters
        ship.forwardThrusterActive = false
		ship.reverseThrusterActive = false

        local sign = 0

        if ship.vkReverse ~= 0 then
			ship.reverseThrusterActive = true
			sign = sign - ship.vkReverse
		end

		if ship.vkForward ~= 0 then
			ship.forwardThrusterActive = true
			sign = sign + ship.vkForward
		end

		if ship.lastThrust == 0 then
			ship.lastThrust = love.timer.getTime()
		end

        -- Some normalization of last trust input?
        local factor = math.min(((love.timer.getTime() - ship.lastThrust) / 0.5) + 0.2, 1)
        ship.acceleration = Vector2(math.sin(ship.rotation), -math.cos(ship.rotation)) * sign * factor * Ship.MAXIMUM_SHIP_THRUST

    else
        -- Rest trusters
		ship.forwardThrusterActive = false
		ship.reverseThrusterActive = false
		ship.lastThrust = 0
	end

    if ship.vkLeft ~= 0 then
		ship.rotationDeltaNextFrame = ship.rotationDeltaNextFrame + (ship.vkLeft * ((-math.pi / 2) * (dt / 0.4)))
	end

	if ship.vkRight ~= 0 then
		ship.rotationDeltaNextFrame = ship.rotationDeltaNextFrame + (ship.vkRight * ((math.pi / 2) * (dt / 0.4)))
	end
end