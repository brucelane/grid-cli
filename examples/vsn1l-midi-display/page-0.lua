-- grid: page=0

-- grid:event element=255 event=init
--[[@cb]]
_G.k={0,0,0,0,0,0,0,0} _G.n={0,0,0,0} _G.e=8192 _G.eb=0 _G.d=1

-- grid:event element=0 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:bva() _G.k[1]=v gms(0,v>0 and 144 or 128,60,v) _G.d=1

-- grid:event element=1 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:bva() _G.k[2]=v gms(0,v>0 and 144 or 128,61,v) _G.d=1

-- grid:event element=2 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:bva() _G.k[3]=v gms(0,v>0 and 144 or 128,62,v) _G.d=1

-- grid:event element=3 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:bva() _G.k[4]=v gms(0,v>0 and 144 or 128,63,v) _G.d=1

-- grid:event element=4 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:bva() _G.k[5]=v gms(0,v>0 and 144 or 128,64,v) _G.d=1

-- grid:event element=5 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:bva() _G.k[6]=v gms(0,v>0 and 144 or 128,65,v) _G.d=1

-- grid:event element=6 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:bva() _G.k[7]=v gms(0,v>0 and 144 or 128,66,v) _G.d=1

-- grid:event element=7 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:bva() _G.k[8]=v gms(0,v>0 and 144 or 128,67,v) _G.d=1

-- grid:event element=8 event=endless
--[[@sen]]
self:epmo(0) self:epv0(64) self:epmi(0) self:epma(127) self:epse(50)
--[[@sglc]]
self:led_color(-1,{{255,140,0,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:epva() local v14=v*128 _G.e=v14 gms(0,176,1,v14//128) gms(0,176,33,v14%128) _G.d=1

-- grid:event element=8 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@cb]]
local v=self:bva() _G.eb=v gms(0,v>0 and 144 or 128,68,v) _G.d=1

-- grid:event element=9 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@cb]]
local v=self:bva() _G.n[1]=v gms(0,v>0 and 144 or 128,69,v) _G.d=1

-- grid:event element=10 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@cb]]
local v=self:bva() _G.n[2]=v gms(0,v>0 and 144 or 128,70,v) _G.d=1

-- grid:event element=11 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@cb]]
local v=self:bva() _G.n[3]=v gms(0,v>0 and 144 or 128,71,v) _G.d=1

-- grid:event element=12 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@cb]]
local v=self:bva() _G.n[4]=v gms(0,v>0 and 144 or 128,72,v) _G.d=1

-- grid:event element=13 event=init
--[[@cb]]
lcd_set_backlight(255) self:draw_area_filled(0,0,319,239,{0,0,0}) self:draw_swap()

-- grid:event element=13 event=draw
--[[@cb]]
if _G.d>0 then _G.d=0 local s=self s:ldaf(0,0,319,239,{0,0,0}) s:ldt("Keys: "..(_G.k[1]>0 and"X"or"_")..(_G.k[2]>0 and"X"or"_")..(_G.k[3]>0 and"X"or"_")..(_G.k[4]>0 and"X"or"_")..(_G.k[5]>0 and"X"or"_")..(_G.k[6]>0 and"X"or"_")..(_G.k[7]>0 and"X"or"_")..(_G.k[8]>0 and"X"or"_"),20,30,28,{255,255,255}) s:ldt("Enc: ".._G.e.." Btn:".._G.eb,20,90,28,{0,200,255}) s:ldt("Nav: "..(_G.n[1]>0 and"X"or"_")..(_G.n[2]>0 and"X"or"_")..(_G.n[3]>0 and"X"or"_")..(_G.n[4]>0 and"X"or"_"),20,150,28,{0,255,150}) s:ldsw() end
