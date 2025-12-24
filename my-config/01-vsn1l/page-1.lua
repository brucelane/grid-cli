-- grid: page=1

-- grid:event element=0 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Volume")

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
--[[Button Init]]

-- ============================================================

-- grid:event element=0 event=button
-- action: Press (bpr)
--[[@bpr]]
if self:button_state()>0 then

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","set_active_property","volume")

-- ------------------------------------------------------------
-- action: Release (bprel)
--[[@bprel]]
else

-- ------------------------------------------------------------
-- action: End (bpre)
--[[@bpre]]
end

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ============================================================

-- grid:event element=1 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Pan")

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
--[[Button Init]]

-- ============================================================

-- grid:event element=1 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(0) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Press (bpr)
--[[@bpr]]
if self:button_state()>0 then

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","set_active_property","panning")

-- ------------------------------------------------------------
-- action: Release (bprel)
--[[@bprel]]
else

-- ------------------------------------------------------------
-- action: End (bpre)
--[[@bpre]]
end

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ============================================================

-- grid:event element=2 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Send A")

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
--[[Button Init]]

-- ============================================================

-- grid:event element=2 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(0) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Press (bpr)
--[[@bpr]]
if self:button_state()>0 then

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","set_active_property","sends",0)

-- ------------------------------------------------------------
-- action: Release (bprel)
--[[@bprel]]
else

-- ------------------------------------------------------------
-- action: End (bpre)
--[[@bpre]]
end

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ============================================================

-- grid:event element=3 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Send B")

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
--[[Button Init]]

-- ============================================================

-- grid:event element=3 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(0) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Press (bpr)
--[[@bpr]]
if self:button_state()>0 then

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","set_active_property","sends",1)

-- ------------------------------------------------------------
-- action: Release (bprel)
--[[@bprel]]
else

-- ------------------------------------------------------------
-- action: End (bpre)
--[[@bpre]]
end

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ============================================================

-- grid:event element=4 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Mute")

-- ============================================================

-- grid:event element=4 event=button
-- action: Press (bpr)
--[[@bpr]]
if self:button_state()>0 then

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","selected_track_arm_mute_solo","mute")

-- ------------------------------------------------------------
-- action: Release (bprel)
--[[@bprel]]
else

-- ------------------------------------------------------------
-- action: End (bpre)
--[[@bpre]]
end

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{225,255,0,0.2},{225,255,0,1}})

-- ============================================================

-- grid:event element=5 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Solo")

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
--[[Button Init]]

-- ============================================================

-- grid:event element=5 event=button
-- action: Press (bpr)
--[[@bpr]]
if self:button_state()>0 then

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","selected_track_arm_mute_solo","solo")

-- ------------------------------------------------------------
-- action: Release (bprel)
--[[@bprel]]
else

-- ------------------------------------------------------------
-- action: End (bpre)
--[[@bpre]]
end

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{0,8,255,0.2},{0,8,255,1}})

-- ============================================================

-- grid:event element=6 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Arm")

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
--[[Button Init]]

-- ============================================================

-- grid:event element=6 event=button
-- action: Press (bpr)
--[[@bpr]]
if self:button_state()>0 then

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","selected_track_arm_mute_solo","arm")

-- ------------------------------------------------------------
-- action: Release (bprel)
--[[@bprel]]
else

-- ------------------------------------------------------------
-- action: End (bpre)
--[[@bpre]]
end

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{255,17,0,0.2},{255,17,0,1}})

-- ============================================================

-- grid:event element=7 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Last Touched")

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
--[[Button Init]]

-- ============================================================

-- grid:event element=7 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(0) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Press (bpr)
--[[@bpr]]
if self:button_state()>0 then

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","set_active_property","lastTouched")

-- ------------------------------------------------------------
-- action: Release (bprel)
--[[@bprel]]
else

-- ------------------------------------------------------------
-- action: End (bpre)
--[[@bpre]]
end

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ============================================================

-- grid:event element=8 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Change Active Property")

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
--[[Endless Init]]

-- ============================================================

-- grid:event element=8 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(0) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","reset_active_property")

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ============================================================

-- grid:event element=8 event=endless
-- action: Code Block (cb)
--[[@cb]]
self:endless_sensitivity(30)

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","set_active_property_value",self:endless_value()/100)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ============================================================

-- grid:event element=9 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Play/Stop")

-- ============================================================

-- grid:event element=9 event=button
-- action: Press (bpr)
--[[@bpr]]
if self:button_state()>0 then

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","play_or_stop")

-- ------------------------------------------------------------
-- action: Release (bprel)
--[[@bprel]]
else

-- ------------------------------------------------------------
-- action: End (bpre)
--[[@bpre]]
end

-- ============================================================

-- grid:event element=10 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Record")

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
--[[Button Init]]

-- ============================================================

-- grid:event element=10 event=button
-- action: Press (bpr)
--[[@bpr]]
if self:button_state()>0 then

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","record")

-- ------------------------------------------------------------
-- action: Release (bprel)
--[[@bprel]]
else

-- ------------------------------------------------------------
-- action: End (bpre)
--[[@bpre]]
end

-- ============================================================

-- grid:event element=11 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Left")

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
--[[Button Init]]

-- ============================================================

-- grid:event element=11 event=button
-- action: Press (bpr)
--[[@bpr]]
if self:button_state()>0 then

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","navigate","left")

-- ------------------------------------------------------------
-- action: Release (bprel)
--[[@bprel]]
else

-- ------------------------------------------------------------
-- action: End (bpre)
--[[@bpre]]
end

-- ============================================================

-- grid:event element=12 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("Right")

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
--[[Button Init]]

-- ============================================================

-- grid:event element=12 event=button
-- action: Press (bpr)
--[[@bpr]]
if self:button_state()>0 then

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
package_send("package-ableton-js","navigate","right")

-- ------------------------------------------------------------
-- action: Release (bprel)
--[[@bprel]]
else

-- ------------------------------------------------------------
-- action: End (bpre)
--[[@bpre]]
end

-- ============================================================

-- grid:event element=13 event=init
-- action: Element Name (sn)
--[[@sn]]
self:element_name("GUI")

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
lcd_set_backlight(255)lcd,f,cWh,cBl=element[13],0,{255,255,255},{0,0,0}lcd:draw_area_filled(0,0,319,239,cBl)lcd:draw_rectangle_rounded(3,3,317,237,10,cWh)lcd:draw_swap()function ui(p)f=1;if p["gui"]then lcd:draw_area_filled(10,10,310,46,cBl)lcd:draw_text_fast(p["tn"],10,10,36,p["c"])end;if p["evt"]~=nil then lcd:draw_area_filled(10,50,200,74,cBl)lcd:draw_text_fast(p["evt"],10,50,24,cWh)if p["ap"]~=nil then lcd:draw_area_filled(10,80,200,120,cBl)lcd:draw_text_fast(p["ap"],10,80,24,cWh)else lcd:draw_area_filled(10,80,200,120,cBl)end end;lcd:draw_text_fast("play",30,215,8,cWh)lcd:draw_text_fast("stop",30,225,8,cWh)lcd:draw_text_fast("record",100,220,8,cWh)lcd:draw_text_fast("left",185,220,8,cWh)lcd:draw_text_fast("right",260,220,8,cWh)end

-- ============================================================

-- grid:event element=13 event=draw
-- action: Code Block (cb)
--[[@cb]]
if f>0 then self:draw_swap()f=f-1 end

-- ============================================================

-- grid:event element=255 event=init
-- action: Code Block (cb)
--[[@cb]]
function ableton_js_callback(p)if p["evt"]=='ST_DEFAULT'then st_default(p)else st(p)end end;function st(p)local v=0;ui(p)if p["evt"]=='ST_SENDS'then v=(p["v"][p["ap"]+1]*100)//1 else v=(p["v"]*100)//1 end;element[8]:endless_min(p["min"]*100)element[8]:endless_max(p["max"]*100)element[8]:endless_value(v)element[8]:led_value(2,map_saturate(v,p["min"]*100,p["max"]*100,0,255))end;function st_default(p)element[4]:led_value(1,p.m and 0 or 255)element[5]:led_value(1,p.s and 255 or 0)element[6]:led_value(1,p.a and 255 or 0)end
