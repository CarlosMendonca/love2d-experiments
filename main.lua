require('typo')

local ship_rotation, ship_x, ship_y
local ship_x0 = 100
local ship_y0 = 100
local ship_width = 100
local ship_height = 100

function love.load()
    love.keyboard.setKeyRepeat(true)

    star_map = {}
    ship_rotation = 0
    ship_x = 0
    ship_y = 0

    typo_new("Hello, World", 0.5, 500, 'center', 0, 0, love.graphics.newFont(30), { 255, 255, 255 })
end

function love.update(dt)
    typo_update(dt)
end

function love.draw()
    --drawStarMap()
    --drawTriangle()

    love.graphics.print("Hello World", 400, 300)
    typo_draw()
end

function love.keypressed(key, isrepeat)

    generateStarMap()
    if key == 'q' then
        ship_rotation = ship_rotation + 0.1
    elseif key == 'e' then
        ship_rotation = ship_rotation - 0.1
    elseif key == 'w' then
        ship_y = ship_y + 10
    elseif key == 's' then
        ship_y = ship_y - 10
    elseif key == 'a' then
        ship_x = ship_x + 10
    elseif key == 'd' then
        ship_x = ship_x - 10
    end
end

function drawStarMap()
    for i, star in ipairs(star_map) do
        love.graphics.points(star[1], star[2])
    end
end

function generateStarMap()
    local screen_width, screen_height = love.graphics.getDimensions()
    local max_stars = 1500

    for i=1, max_stars do
        local x = love.math.random(1, screen_width-1)
        local y = love.math.random(1, screen_height-1)
        star_map[i] = {x, y}
    end
end

function drawTriangle()
    ship_center_x = ship_x0 + ship_x + ship_width/2;
    ship_center_y = ship_y0 + ship_y + ship_height/2;

    love.graphics.push()
	love.graphics.translate(ship_center_x,ship_center_y)    -- rotation center
	love.graphics.rotate(ship_rotation)                     -- rotate
	love.graphics.translate(-ship_center_x,-ship_center_y)  -- move back
    love.graphics.polygon('line',
        ship_x + 100, ship_y + 100,
        ship_x + 200, ship_y + 100,
        ship_x + 150, ship_y + 200)
	love.graphics.pop()

	love.graphics.polygon('fill', 200, 200, 300, 200, 250, 300)
end