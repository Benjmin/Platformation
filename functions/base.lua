--TODO: seperate the functions into differeant files.
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

function CheckCollision(ax1,ay1,aw,ah, bx1,by1,bw,bh)

  local ax2,ay2,bx2,by2 = ax1 + aw, ay1 + ah, bx1 + bw, by1 + bh
  return ax1 < bx2 and ax2 > bx1 and ay1 < by2 and ay2 > by1
end

function collision(platform_table) 
	if kip.jump == false then
		kip.fall = true
		for _, platform in pairs(platform_table) do
			if collide_ontop(kip,platform) then
				kip.fall = false
				kip.jump = false
				break
			end
		end
	end
end
--functions for platform, and kip interactions of platforms.

--function for plattform movement
function pmove(platform,limit1,limit2)
	if platforms[platform].r_mov then
	 	platforms[platform].x  =  platforms[platform].x + 10
	 end
	 
	 if platforms[platform].right == limit2 then
	 	platforms[platform].r_mov = false
	 	platforms[platform].l_mov = true
	 end
	 
	 if platforms[platform].l_mov then
	 	 platforms[platform].x =  platforms[platform].x - 10
	 end
	 
	 if  platforms[platform].left ==  limit1 then
	 	platforms[platform].l_mov = false
	 	platforms[platform].r_mov = true
	 end
end

--function for moving platform collision.
function kipmove(kip_state, platform)
	if collide_ontop(kip,platforms[platform]) then
		kip[kip_state] = true
	 else 
		kip[kip_state] = false
	end

	if kip[kip_state] == true then 
	 	if platforms[platform].r_mov then
	 		kip.x = kip.x + 10
	 		if  level == 2 then
	 			if love.keyboard.isDown("left") then
	 				kip.x = kip.x - 5
	 			end
	 		end
	 	elseif platforms[platform].l_mov then
	 		kip.x = kip.x - 10
	 		if  level == 2 then
	 			if love.keyboard.isDown("left") then
	 				kip.x = kip.x +5
	 			end
	 		end
	 	end
	 end
end

--putting it all together
function movement(platform, limit1, limit2, kip_state)
	pmove(platform,limit1,limit2)
	kipmove(kip_state,platform)
end
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
 
 --function for bumping on top of things	
 function bump_top (object1,object2)
 	if object1["top"] == object2["bottom"] then
 		local range1 = {}
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
--functions for side bumps
function left_col (object1, object2)
	if object1["left"] == object2["right"] then 
		local range1 = {}
		 for i = object1["top"],object1["bottom"] do
		 	range1[i] = i
		 end
		local range2 = {}
		for i = object2["top"],object2["bottom"] do
			range2[i] = i
		end
		if compare(range1,range2) then
			return true
		else
			return false
		end
	end
end

function right_col (object1, object2)
	if object1["right"] == object2["left"] then 
		local range1 = {}
		 for i = object1["top"],object1["bottom"] do
		 	range1[i] = i
		 end
		local range2 = {}
		for i = object2["top"],object2["bottom"] do
			range2[i] = i
		end
		if compare(range1,range2) then
			return true
		else
			return false
		end
	end
end

