-- TODO:Make jumping natural.  When that is done create multiple platforms and create test level. Lastly I have to clean up the code and seperate it into multiple files. 
functions = love.filesystem.load("functions/base.lua")
functions()
require("levels/level1")
require("levels/level2")
local level = 1
function love.load()
	love.graphics.setBackgroundColor(0,40,30)
	checkpoint = {}
	checkpoint.image = love.graphics.newImage("icon.png")
	checkpoint.height = 50
	checkpoint.width = 50
	--configurations for kip, the hero
	kip = {}
	kip.x = 400
	kip.y = 859
	kip.width = 30
	kip.height = 40
	kip.speed = 7
	kip.jump = false
	kip.set_height = 460
	kip.jump_height = 160
	kip.fall = false
	kip.leftmo = true
	kip.rightmo = true
	platforms = {}
	platforms.floor= {}
	platforms.floor.width = 900
	platforms.floor.height = 100
	platforms.floor.x = 1
	platforms.floor.y = 900
	level1.load()
end

function love.keypressed(key,unicode)
	-- Starts jump 
	if kip.fall == false then
		if key == "up" then
			kip.jump = true
		end
	end
	if key == "escape" then
		love.event.push("quit")
	end
	--Debug
	 if key == "d" then --set to whatever key you want to use
        	debug.debug()
     	end
end

function love.update(dt)
	--level setup
	if level == 1 then
		checkpoint.x = checkpoint.x1
		checkpoint.y = checkpoint.y1
	end
	--checkpoint collision
	if CheckCollision(checkpoint.x,checkpoint.y,checkpoint.width,checkpoint.height, kip.x,kip.y,kip.width,kip.height) then
		level = 2
	end
	-- configuring sides A.K.A more configurations
	sides(kip)
	sides(platforms.floor)
	-- stuff for levels
	if level == 1 then
		level1.update(dt)
	end
	if level == 2 then
		level2.update(dt)
	end
	--side's collisions.
	if  level == 2 then
		if  right_col(kip,platforms["platform1"])  or right_col(kip,platforms["platform2"])  or right_col(kip,platforms["platform4"]) then
				kip.rightmo = false
		else
				kip.rightmo = true
		end

		if  left_col(kip,platforms["platform2"]) or  left_col(kip,platforms["platform4"]) then
			kip.leftmo = false
		else 
			kip.leftmo = true
		end

	--keyboard setup
	
	-- Left key config.

		if kip.left > 0 then
			if kip.leftmo then
				if love.keyboard.isDown("left") then
					kip.x = kip.x - kip.speed
				end
			end
		end
	
	-- Right key config.
		if kip.right < 900 then
	 		if kip.rightmo then
				if love.keyboard.isDown("right") then
					kip.x = kip.x + kip.speed
				end
			end
		end
	end
	
	--Platform hero configurations
	if kip.jump == false then
		if kip.fall == false then
			kip.set_height = kip.top
		end
	end
	
	  
	--bump logic.
	collision(platforms)
	
	--if bump_top(kip,platforms["platform1"])  or bump_top(kip,platforms["platform2"])  or bump_top(kip,platforms["platform3"])  or bump_top(kip,platforms["platform4"])  then
	--	kip.fall = true
	--	kip.jump =false
	--end
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
	

	 
	 --Fall logic
	if kip.fall then
		kip.y  = kip.y + 10
	end
end

-- A function for drawing rectangles
function draaw(object)
	love.graphics.rectangle("fill",object.x,object.y,object.width,object.height)
end

function love.draw()
	love.graphics.setColor(255,255,255)
	love.graphics.draw(checkpoint.image,checkpoint.x,checkpoint.y)
	-- floor drawing
	love.graphics.setColor(255,0,0)
	--fix this
	draaw(platforms.floor)
	--kip's image
	love.graphics.setColor(0,255,0)
	draaw(kip)
	love.graphics.setColor(0,0,255)
	--platforms
	if level == 1 then
		level1.draw()
	end
	--TESTS
	love.graphics.setColor(0,255,0)
	--a short test of kip's sides
	--love.graphics.print(ldt,200,300)
	--love.graphics.print(kip.left,300,300)
	--love.graphics.print(kip.right,400,300)
	--love.graphics.print(kip.bottom,500,300)
	--love.graphics.print(kip.set_height,600,300)
	if level == 2 then
		love.graphics.print("You Won",450,25)
	end
	-- tests for jumping
	
	-- test for seeing if  jump is true
	if kip.jump then
		love.graphics.print("jump = true",400,200)
	end
end
