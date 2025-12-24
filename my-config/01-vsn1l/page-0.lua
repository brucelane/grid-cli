-- grid: page=0

-- grid:event element=0 event=init
-- action: Locals (l)
--[[@l#Element name]]
local dname="Bu0"

-- ============================================================

-- grid:event element=0 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ============================================================

-- grid:event element=1 event=init
-- action: Locals (l)
--[[@l#Element name]]
local dname="Bu1"

-- ============================================================

-- grid:event element=1 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ============================================================

-- grid:event element=2 event=init
-- action: Locals (l)
--[[@l#Element name]]
local dname="Bu2"

-- ============================================================

-- grid:event element=2 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ============================================================

-- grid:event element=3 event=init
-- action: Locals (l)
--[[@l#Element name]]
local dname="Bu3"

-- ============================================================

-- grid:event element=3 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ------------------------------------------------------------
-- action: Element Name (sn)
--[[@sn]]
self:element_name("sb")

-- ============================================================

-- grid:event element=4 event=init
-- action: Locals (l)
--[[@l#Element name]]
local dname="Bu4"

-- ============================================================

-- grid:event element=4 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ============================================================

-- grid:event element=5 event=init
-- action: Locals (l)
--[[@l#Element name]]
local dname="Bu5"

-- ============================================================

-- grid:event element=5 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ============================================================

-- grid:event element=6 event=init
-- action: Locals (l)
--[[@l#Element name]]
local dname="Bu6"

-- ============================================================

-- grid:event element=6 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ============================================================

-- grid:event element=7 event=init
-- action: Locals (l)
--[[@l#Element name]]
local dname="Bu7"

-- ============================================================

-- grid:event element=7 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ------------------------------------------------------------
-- action: Element Name (sn)
--[[@sn]]
self:element_name("b3")

-- ============================================================

-- grid:event element=8 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}})

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ============================================================

-- grid:event element=8 event=endless
-- action: Locals (l)
--[[@l#absolute/relative mode]]
local relative=false

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}})

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
if relative then self:endless_mode(1)else self:endless_mode(0)end;event_trigger(self.l_b,3)local ev=self:endless_value()if self.l_b then self.b_v[self.l_b]=ev end

-- ============================================================

-- grid:event element=9 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ============================================================

-- grid:event element=10 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ============================================================

-- grid:event element=11 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ============================================================

-- grid:event element=12 event=button
-- action: Button Mode (sbc)
--[[@sbc]]
self:button_mode(1) self:button_min(0) self:button_max(127)

-- ------------------------------------------------------------
-- action: Simple Color (sglc)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)

-- ------------------------------------------------------------
-- action: MIDI (gms)
--[[@gms]]
self:midi_send(-1,-1,-1,-1)

-- ============================================================

-- grid:event element=13 event=init
-- action: Code Block (cb)
--[[@cb]]
print("setup lcd")lcd=element[13]black={0,0,0}orange={249,150,0}purple={128,0,128}sz=8

-- ------------------------------------------------------------
--[[@ximi]]
package_send("package-image-stream", "init", module_position_x(), module_position_y())

-- ============================================================

-- grid:event element=13 event=draw
-- action: Code Block (cb)
--[[@cb]]
for i=0,12,1 do bv=element[i]:button_value()col=black;if bv>0.0 then col={deb,0,bv*25}end;deb=20*i;fin=deb+20;lcd:draw_text_fast(i,deb,0,sz,{deb,0,bv*255})lcd:draw_rectangle_rounded_filled(deb,43,fin-1,bv*0.1,10,col)end;if element[8]:endless_value()>0.01 then bv=element[8]:endless_value()col=black;if bv>0.0 then col={deb,0,bv*25}end;deb=20*13;fin=deb+20;lcd:draw_text_fast(bv,deb,0,sz+3,{deb,0,bv*255})lcd:draw_rectangle_rounded_filled(deb,43,fin-1,12.1,10,col)end;lcd:draw_swap()

-- ============================================================

-- grid:event element=255 event=init
-- action: Code Block (cb)
--[[@cb#Forced Pre-Initialization]]
for i=0,#element-1 do element[i]:ini()end

-- ------------------------------------------------------------
-- action: Code Block (cb)
--[[@cb]]
function smm(min,max)element[8]:endless_min(min)element[8]:endless_max(max)end;function sled(val,min,max)val=map_saturate(val,min,max,0,255)element[8]:led_value(2,val//1)end;function radio(active_b)for i=0,7 do if i==active_b then element[i]:led_value(1,255)else element[i]:led_value(1,20)end end end
