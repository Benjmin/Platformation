-- TODO:When that is done create multiple platforms and create test level. Lastly I have to clean up the code and seperate it into multiple files.

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
	platforms = {}
	for i = 1, 4 do
		platforms["platform"..i] = {}
		platforms["platform"..i].x = 200
		platforms["platform"..i].y = 500 - i*100
		platforms["platform"..i].width = 200
		platforms["platform"..i].height = 50
	end
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
function sides ( name)
	name["top"] = name["y"]
	name["left"] = name["x"]
	name["right"] = name["x"] + name["width"]
	name["bottom"]= name["y"] + name["height"]
end

--Functions for comparing tables.
function contains(tbl, val)
  for k,v in pairs(tbl) do
    if v == val then return true end
  end
  return false
end

function compare(t1, t2)
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
	sides(kip)
	for i = 1,4 do
		sides(platforms["platform"..i])
	end
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
	if kip.jump == false then
		if kip.fall == false then
			kip.set_height = kip.top
		end
	end
	--Jump-on logic.
	for i = 1, 4 do
		if collide_ontop(kip,platforms["platform"..i]) then
			if kip.jump == false then
				kip.fall  = false
			end
		end
	end
	if kip.jump == false then
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
	for i = 1,4 do 
		draaw(platforms["platform"..i])
	end
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
