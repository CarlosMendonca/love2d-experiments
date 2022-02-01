local Concord = require('libraries/concord')

-- COMPONENTS
    Concord.component("position", function(component, x, y)
        component.x = x or 0
        component.y = y or 0
    end)

    Concord.component("velocity", function(component, x, y)
        component.x = x or 0
        component.y = y or 0
    end)

    local Drawable = Concord.component("drawable") -- defining the (empty/no data) component and the system at the same time
-- COMPONENTS

-- SYSTEMS
    -- System: Move
    local MoveSystem = Concord.system({
        pool = {"position", "velocity"}
    })

    function MoveSystem:update(dt)
        for _, e in ipairs(self.pool) do
            e.position.x = e.position.x + e.velocity.x * dt
            e.position.y = e.position.y + e.velocity.y * dt
        end
    end

    -- System: Draw
    local DrawSystem = Concord.system({
        pool = {"position", "drawable"}
    })

    function DrawSystem:draw()
        for _, e in ipairs(self.pool) do
            love.graphics.circle("fill", e.position.x, e.position.y, 5)
        end
    end

-- WORLDS
    local world = Concord.world()
    world:addSystems(MoveSystem, DrawSystem)
-- WORLDS

local e1 = Concord.entity(world)
:give("position", 100, 100)
:give("velocity", 100, 0)
:give("drawable")

local e2 = Concord.entity(world)
:give("position", 50, 50)
:give("drawable")

local e3 = Concord.entity(world)
:give("position", 200, 200)

function love.update(dt)
    world:emit("update", dt) -- calling the update functions on all system that have it
end

function love.draw()
    world:emit("draw") -- calling the draw function on all systems that have it
end