level1 = {}
function level1.load()
	--checkpoint location
	checkpoint.y1 = 50
	checkpoint.x1 = 450
	--for hero moving
	kip.p1_mov = false
	kip.p2_mov = false
	kip.p3_mov = false
	--configuration of platforms
	platforms1 = {}
	for i = 2, 8 do
		platforms1["platform"..i] = {}
		platforms1["platform"..i].x = 300 
		platforms1["platform"..i].y = 900 - (i -1)*100
		platforms1["platform"..i].width = 200
		platforms1["platform"..i].height = 50
		if i == 2 or i == 4 or i == 6 or i == 8 then
			platforms1["platform"..i].r_mov = true
			platforms1["platform"..i].l_mov = false
		end 
		if  i == 7 then
			platforms1["platform"..i].r_mov = false
			platforms1["platform"..i].l_mov = true
		end
	end
	--customization of platforms
	platforms1.platform5.x  = 150 
	platforms1.platform6.x = 600
	platforms1.platform7.x  = 100
end
function level1.update(dt)
	--level setup
	platforms = platforms1
	--side config.
	for i = 2,8 do
		sides(platforms["platform"..i])
	end
	--platforms
	movement("platform2",100,800,'p1_mov')
	movement("platform4",100,800,'p1_mov')
	movement("platform8",100,800,'p1_mov')
	movement("platform6",100,800,'p2_mov')
	movement("platform7",100,800,'p3_mov')
end
function level1.draw()
	for i = 2,8 do 
		draaw(platforms["platform"..i])
	end
end	
