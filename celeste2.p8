pico-8 cartridge // http://www.pico-8.com
version 29
__lua__

-- globals
room = 0
objects = {}
snow = {}
clouds = {}

function _init()

	for i=0,25 do
		snow[i] = { x = rnd(132), y = rnd(132) }
	end
	for i=0,25 do
		clouds[i] = { x = rnd(132), y = rnd(132), s = 16 + rnd(32) }
	end

	room_load(0)
end
-->8

freeze_time = 0
game_time = 0

input_x = 0
input_y = 0
input_x_turned = false
input_y_turned = false
input_jump = false
input_jump_pressed = 0
input_grapple = false
input_grapple_pressed = 0

function consume_jump_press()
	local val = input_jump_pressed > 0
	input_jump_pressed = 0
	return val
end

function consume_grapple_press()
	local val = input_grapple_pressed > 0
	input_grapple_pressed = 0
	return val
end

function _update()

	-- input_x
	local prev_x = input_x
	if (btn(0)) then
		if (btn(1)) then
			if (input_x_turned) then
				input_x = prev_x
			else
				input_x = -prev_x
				input_x_turned = true
			end
		else
			input_x = -1
			input_x_turned = false
		end
	elseif (btn(1)) then
		input_x = 1
		input_x_turned = false
	else
		input_x = 0
		input_x_turned = false
	end

	-- input_y
	local prev_y = input_y
	if (btn(2)) then
		if (btn(3)) then
			if (input_y_turned) then
				input_y = prev_y
			else
				input_y = -prev_y
				input_y_turned = true
			end
		else
			input_y = -1
			input_y_turned = false
		end
	elseif (btn(3)) then
		input_y = 1
		input_y_turned = false
	else
		input_y = 0
		input_y_turned = false
	end

	-- input_jump
	local jump = btn(4)
	if (jump and not input_jump) then		
		input_jump_pressed = 4
	elseif (jump) then
		input_jump_pressed = max(0, input_jump_pressed - 1)
	else
		input_jump_pressed = 0
	end
	input_jump = jump

	-- input_grapple
	local grapple = btn(5)
	if (grapple and not input_grapple) then
		input_grapple_pressed = 4
	elseif (grapple) then
		input_grapple_pressed = max(0, input_grapple_pressed - 1)
	else
		input_grapple_pressed = 0
	end
	input_grapple = grapple

	--freeze
	if (freeze_time > 0) then
		freeze_time -= 1
	else
		game_time += 1

		--objects
		for i = 1, #objects do
			objects[i]:update()
		end
	end
end
-->8
function _draw()

	-- clear screen
	cls(0)

	-- draw clouds
	local cc = 13
	for i=0,#clouds do
		local c = clouds[i]
		local x = c.x % (128 + c.s) - c.s / 2
		local y = c.y
		clip(x - c.s / 2, y - c.s / 2, c.s, c.s / 2)
		circfill(x, y, c.s / 3, cc)
		if (i % 2 == 0) then
			circfill(x - c.s / 3, y, c.s / 5, cc)
		end
		if (i % 2 == 0) then
			circfill(x + c.s / 3, y, c.s / 6, cc)
		end
		c.x += (4 - i % 4) * 0.25
	end
	clip(0,0,128,128)

	-- draw tileset
	map((room % 4) * 16, (room / 4) * 16, 0, 0, 16, 16, 1)

	-- draw objects
	for i=1,#objects do
		objects[i]:draw()
	end

	-- draw snow
	for i=1,#snow do
		circfill(snow[i].x % 132 - 2, snow[i].y % 132, i % 2, 7)
		snow[i].x += (4 - i % 4)
		snow[i].y += sin(time() * 0.25 + i * 0.1)
	end

	-- debug
	-- print("cpu: " .. flr(stat(1) * 100) .. "/100", 9, 9, 4)
	-- print("mem: " .. flr(stat(0)) .. "/2048", 9, 15, 4)
end

-->8

-- Objects:
#include object.lua
#include player.lua

crate = {}
crate.tile = 19
crate.base = object
crate.geom = g_solid
crate.init = function(self)
	self.spr = self.tile
end
crate.update = function(self) 
	self:move_y(1)
end

setmetatable(crate, lookup)
add(types, crate)

-->8

-- gets the tile at the given location in the CURRENT room
function room_tile_at(x, y)
	return mget((room % 4) * 16 + x, (room / 4) * 16 + y)
end

-- loads the given room
function room_load(index)
	room = index
	objects = {}

	for i = 0,15 do
		for j = 0,15 do
			for n=1,#types do
				if (room_tile_at(i, j) == types[n].tile) then
					create(types[n], i * 8, j * 8)
				end
			end
		end
	end
end

function approach(x, target, max_delta)
	if (x < target) then
		return min(x + max_delta, target)
	else
		return max(x - max_delta, target)
	end
end

function draw_sine_h(x0, x1, y, col, amplitude, time_freq, x_freq, fade_x_dist)
	pset(x0, y, col)
	pset(x1, y, col)

	local x_sign = sgn(x1 - x0)
	local x_max = abs(x1 - x0) - 1
	local last_y = y
	local this_y = 0
	local ax = 0
	local ay = 0
	local fade = 1

	for i = 1, x_max do
		
		if (i <= fade_x_dist) then
			fade = i / (fade_x_dist + 1)
		elseif (i > x_max - fade_x_dist + 1) then
			fade = (x_max + 1 - i) / (fade_x_dist + 1)
		else
			fade = 1
		end

		ax = x0 + i * x_sign
		ay = y + sin(game_time * time_freq + i * x_freq) * amplitude * fade
		pset(ax, ay, col)

		this_y = ay
		while (abs(ay - last_y) > 1) do
			ay -= sgn(this_y - last_y)
			pset(ax - x_sign, ay, col)
		end
		last_y = this_y
	end
end

function draw_sine_v(y0, y1, x, col, amplitude, time_freq, y_freq, fade_y_dist)
	pset(x, y0, col)
	pset(x, y1, col)

	local y_sign = sgn(y1 - y0)
	local y_max = abs(y1 - y0) - 1
	local last_x = x
	local this_x = 0
	local ax = 0
	local ay = 0
	local fade = 1

	for i = 1, y_max do
		
		if (i <= fade_y_dist) then
			fade = i / (fade_y_dist + 1)
		elseif (i > y_max - fade_y_dist + 1) then
			fade = (y_max + 1 - i) / (fade_y_dist + 1)
		else
			fade = 1
		end

		ay = y0 + i * y_sign
		ax = x + sin(game_time * time_freq + i * y_freq) * amplitude * fade
		pset(ax, ay, col)

		this_x = ax
		while (abs(ax - last_x) > 1) do
			ax -= sgn(this_x - last_x)
			pset(ax, ay - y_sign, col)
		end
		last_x = this_x
	end
end

__gfx__
00000000777777770011110001111110011111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000700000070111111011144411111111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700722222071114441111474471144441100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000722222071147447101444440174474100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000722222070144444000aaaa00044444100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007007222220700aaaa000022220000aaaa700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000722222070022220007000070002222000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000777777770070070000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
57777777777777777777777599999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777791111119000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777777777777777777777791411419000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777771177777711777777791441119000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
77777712217777122177777791144119000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
71777122221111222217771791414419000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
72111222222222222221112791111119000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
72222222222222222222222799999999000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
72222222222222222222222757777775000000000000000022222222222222225555555555555555555555550000000000000000000000000000000000000000
77222222222222222222227777777777000000000000000022222221122222225555555555555550055555550000000000000000000000000000000000000000
77222222222222222222227777777777000000000000000022222211112222225555555555555500005555550000000000000000000000000000000000000000
77722222222222222222277777177177000000000000000022222111111222225555555555555000000555550000000000000000000000000000000000000000
77722222222222222222277777211277000000000000000022221111111122225555555555550000000055550000000000000000000000000000000000000000
77222222222222222222227777222277000000000000000022211111111112225555555555500000000005550000000000000000000000000000000000000000
77222222222222222222227777722777000000000000000022111111111111225555555555000000000000550000000000000000000000000000000000000000
72222222222222222222222757777775000000000000000021111111111111125555555550000000000000050000000000000000000000000000000000000000
72222222222222222222222757777777777777777777777521111111111111121111111150000000000000050000000000000000000000000000000000000000
72222222222222222222222777777777777777777777777722111111111111221111111155000000000000550000000000000000000000000000000000000000
72222722222222222222222777777777777777777777777722211111111112221111111155500000000005550000000000000000000000000000000000000000
72222222222222222222222777777771177777711777777722221111111122221111111155550000000055550000000000000000000000000000000000000000
77222222222222222227227777777712217777122177777722222111111222221111111155555000000555550000000000000000000000000000000000000000
77722222227777222222277771777122221111222217771722222211112222221111111155555500005555550000000000000000000000000000000000000000
77777222277777722227777772111222222222222221112722222221122222221111111155555550055555550000000000000000000000000000000000000000
57777777777777777777777557777777777777777777777522222222222222221111111155555555555555550000000000000000000000000000000000000000
__gff__
0003000000000000000000000000000003030300000000000000000000000000030303030000030301010100000000000303030303030303010101000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
3837212131313131313131313131313600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
38272122283900002a2828282828282000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3838272228280000000000000028282000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3736372228290000000000000028282000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
213131320000000000000000002a282000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2223283900000000000000000000282000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
22282829000000000000002300002a2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2228280000002300000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2228290000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2228000000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2134350000000002000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2228390000000000000000000000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
22282839000000000013003a3913002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2111111200003334343528281011112600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
2726272213003a2828002a282021213800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3838382711111111111111112627263800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
