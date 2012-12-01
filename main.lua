-- TODO:Spellcheck comments. Make it so you can jump higher than 300 when on a platform. When that is done create multiple platforms and create test level. Lastly I have to clean up the code and seperate it into multiple files.

function love.load()
	love.graphics.setBackgroundColor(0,40,30)
	--configurations for kip, the hero
	kip = {}
	kip.x = 300
	kip.y = 460
	kip.width = 30
	kip.height = 40
	kip.speed = 5
	kip.jump = false
	kip.set_height = 460
	kip.jump_height = 160
	kip.fall = false
	floor = 500
	--configurations for platforms
	--platforms = {}
	--for i = 1, 4 do
	--	platform = {}
	--	platform.y = 500 - 100*i
	--	platform.x = 200 
	--end
	platform = {}
	platform.x = 200
	platform.y = 400
	platform.width = 200
	platform.height = 50
end

function love.keypressed(key,unicode)
	-- Starts jump 
	if kip.fall == false then
		if key == "up" then
			kip.jump = true
		end
	end
end

--Side function for sides
function sides ( name,x, y, width, height)
	name["top"] = y
	name["left"] = x
	name["right"] = x + width
	name["bottom"]= y + height
end

--Functions for comparing tables.
local function contains(tbl, val)
  for k,v in pairs(tbl) do
    if v == val then return true end
  end
  return false
end

local function compare(t1, t2)
  for k,v in pairs(t2) do
    if contains(t1, v) then return true end
  end
  return false
end

-- functions for checking collisions.

--function for jumping ontop of things. objects must have sides.
function collide_ontop ( object1,object2 )
	if object1["bottom"] == object2["top"] then
		local range1 ={}
		 for i = object1["left"],object1["right"] do
		 	range1[i] = i
		 end
		local range2 = {}
		for i = object2["left"],object2["right"] do
			range2[i] = i
		end
		if compare(range1,range2) then 
			return true
		else
			return false
		end
	end
end
 	
function love.update(dt)
	-- configuring sides A.K.A more configurations
	sides(kip,kip.x,kip.y,kip.width,kip.height)
	sides(platform,platform.x,platform.y,platform.width,platform.height)
	
	--keyboard setup
	
	-- Left key config.
	if kip.left > 0 then
		if love.keyboard.isDown("left") then
			kip.x = kip.x - kip.speed
		end
	end
	
	-- Right key config.
	if kip.right < 800 then 
		if love.keyboard.isDown("right") then
			kip.x = kip.x + kip.speed
		end
	end
	
	--Platform hero configurations
	
	--Jump-on logic.
	if collide_ontop(kip,platform) then
		if kip.jump == false then
			kip.fall  = false
		end
	elseif kip.jump == false then
		kip.set_height = kip.x
		kip.fall = true
	end
	
	-- Jumping configuration
	
	--Jump logic.
	if kip.jump then
		kip. y = kip.y  - 10
	end
	
	--Sets max height of jump ending jump and starting fall.
	if kip.top == kip.set_height - kip.jump_height then
		kip.jump = false
		kip.fall = true
	end
	
	-- Fall configuration.
	
	--Ends fall
	if kip.bottom == floor then
		kip.fall = false
	end
	 
	 --Fall logic
	if kip.fall then
		kip.y  = kip.y + 10
	end
end

-- A function for drawing rectangles
function draaw(object)
	love.graphics.rectangle("fill",object["x"],object["y"],object["width"],object["height"])
end

function love.draw()
	-- floor drawing
	love.graphics.setColor(255,0,0)
	love.graphics.rectangle("fill",1,500,800,100)
	--kip's image
	love.graphics.setColor(0,255,0)
	draaw(kip)
	love.graphics.setColor(0,0,255)
	draaw(platform)
	--TESTS
	love.graphics.setColor(0,255,0)
	--a short test of kip's sides
	love.graphics.print(kip.top,200,300)
	love.graphics.print(kip.left,300,300)
	love.graphics.print(kip.right,400,300)
	love.graphics.print(kip.bottom,500,300)
	love.graphics.print(kip.set_height,600,300)
	-- tests for jumping
	
	-- test for seeing if  jump is true
	if kip.jump then
		love.graphics.print("jump = true",400,200)
	end
end
