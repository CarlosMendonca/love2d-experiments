function love.load()
    love.physics.setMeter(4) -- B2 wingspan is 172 feet, or 52-ish meters; these ships are 14 pixels tall, so say that 1 meter equals 4 pixels
    world = love.physics.newWorld(0, 0, 400, 240)

    objects = {}
    
    objects.ship1 = {}
    objects.ship1.body = love.physics.newBody(world, 10, 10, "dynamic")
    objects.ship1.shape = love.physics.newRectangleShape(0, 0, 11, 14)
    objects.ship1.fixture = love.physics.newFixture(objects.ship1.body, objects.ship1.shape, 59) -- around 59 tons for B2
    objects.ship1.sprite = love.graphics.newImage("sprites/ship_player2.png")

    objects.ship2 = {}
    objects.ship2.body = love.physics.newBody(world, 390, 130, "dynamic")
    objects.ship2.shape = love.physics.newRectangleShape(0, 0, 11, 14)
    objects.ship2.fixture = love.physics.newFixture(objects.ship2.body, objects.ship2.shape, 59)

    love.graphics.setBackgroundColor(0, 0, 0)
    love.window.setMode(400, 240)
end

function love.update(dt)
    world:update(dt)

    if love.keyboard.isDown("right") then
        objects.ship1.body:applyForce(100000, 0)
    elseif love.keyboard.isDown("left") then
        objects.ship1.body:applyForce(-100000, 0)
    elseif love.keyboard.isDown("space") then
        objects.ship1.body:setPosition(10, 10)
        objects.ship1.body:setLinearVelocity(0, 0)
    end
end

function love.draw()
    love.graphics.setColor(1, 1, 1)
    --love.graphics.draw(objects.ship1.sprite, 100, 100)

    print(objects.ship1.shape:getPoints())
    print(objects.ship1.body:getWorldPoints(objects.ship1.shape:getPoints()))

    --love.graphics.draw(objects.ship1.sprite, objects.ship1.body:getWorldPoints(objects.ship1.shape:getPoints()))
    love.graphics.polygon("fill", objects.ship1.body:getWorldPoints(objects.ship1.shape:getPoints()))
end

function love.conf(t)
    t.console = true
end