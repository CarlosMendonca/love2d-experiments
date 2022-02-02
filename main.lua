local Concord = require('libraries/concord')

-- COMPONENTS
    Concord.component("position", function(component, x, y)
        component.x = x or 0
        component.y = y or 0
    end)

    Concord.component("velocity", function(component, vx, vy)
        component.x = vx or 0
        component.y = vy or 0
    end)

    Concord.component("sprite", function(component, pathToSprite)
        component.texture = love.graphics.newImage(pathToSprite)
    end)

    local Input = Concord.component("input")
-- COMPONENTS

-- SYSTEMS
    -- System: Move
    local MoveSystem = Concord.system({
        pool = {"position", "velocity"}
    })

    function MoveSystem:update(dt)
        for _, e in ipairs(self.pool) do
            e.position.x = e.position.x + e.velocity.x * 5 * dt
            e.position.y = e.position.y + e.velocity.y * 5 * dt
        end
    end

    -- System: Draw
    local DrawSystem = Concord.system({
        pool = {"position", "sprite"}
    })

    function DrawSystem:draw()
        for _, e in ipairs(self.pool) do
            love.graphics.draw(e.sprite.texture, e.position.x, e.position.y)
        end
    end

    -- System: PlayerControl
    local InputSystem = Concord.system({
        pool = {"position", "velocity", "input"}
    })

    function InputSystem:update(dt)
        local keyUpPressed = love.keyboard.isDown("up")
        local keyDownPressed = love.keyboard.isDown("down")
        local keyLeftPressed = love.keyboard.isDown("left")
        local keyRightPressed = love.keyboard.isDown("right")

        local VELOCITY_INCREMENT = 5

        for _, e in ipairs(self.pool) do
            if keyUpPressed then
                if (e.velocity.y > 0) then
                    e.velocity.y = 0
                else
                    e.velocity.y = e.velocity.y - VELOCITY_INCREMENT
                end
            end

            if keyDownPressed then
                if (e.velocity.y < 0) then
                    e.velocity.y = 0
                else
                    e.velocity.y = e.velocity.y + VELOCITY_INCREMENT
                end
            end

            if keyLeftPressed then
                if (e.velocity.x > 0) then
                    e.velocity.x = 0
                else
                    e.velocity.x = e.velocity.x - VELOCITY_INCREMENT
                end
            end

            if keyRightPressed then
                if (e.velocity.x < 0) then
                    e.velocity.x = 0
                else
                    e.velocity.x = e.velocity.x + VELOCITY_INCREMENT
                end
            end
        end
    end

-- WORLDS
    local world = Concord.world()
    world:addSystems(MoveSystem, DrawSystem, InputSystem)
-- WORLDS

local ship_player1 = Concord.entity(world)
:give("position", 100, 100)
:give("velocity", 10, 0)
:give("sprite", 'sprites/ship_player2.png')

local ship_player2 = Concord.entity(world)
:give("position", 50, 50)
:give("velocity")
:give("input")
:give("sprite", 'sprites/ship_player2.png')

local e3 = Concord.entity(world)
:give("position", 200, 200)

function love.update(dt)
    world:emit("update", dt) -- calling the update functions on all system that have it
end

function love.draw()
    world:emit("draw") -- calling the draw function on all systems that have it
end