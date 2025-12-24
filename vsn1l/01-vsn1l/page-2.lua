-- grid: page=2

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

-- ============================================================

-- grid:event element=13 event=init
-- action: Code Block (cb)
--[[@cb]]
lcd_set_backlight(255)lcd=element[13]black={0,0,0}orange={249,150,0}purple={128,0,128}sz=10;pi,s,c,self.f,self.v,self.id=math.pi,32,{{0,0,0},{255,255,255},{led_default_red(),led_default_green(),led_default_blue()}},1,{27,0,100},'VSN1'd={[1]='Linear',[2]='Encoder',[3]='Button',[7]='Endless'}xc,yc,p=160,120,s*5/8;self.eventrx_cb=function(self,hdr,e,v,n)self.v=v;if#n==0 then n=d[e[3]]..e[2]end;self.id=string.sub(n,1,(self:screen_width()/(s/2)-1)//1)self.f=1 end;self:draw_area_filled(0,0,319,239,c[1])self:draw_rectangle_rounded(3,3,317,237,10,c[2])

-- ============================================================

-- grid:event element=13 event=draw
-- action: Code Block (cb)
--[[@cb]]
if self.f>0 then self.f=self.f-1;local ar,xo=map_saturate(self.v[1],self.v[2],self.v[3],0.1,1),#tostring(self.v[1])/2*s/2-#tostring(self.v[1])-s//32;self:draw_rectangle_rounded(xc-p//1-1,yc-p//1-1,xc+p//1+1,yc+p//1+1,s,c[2])self:draw_rectangle_rounded_filled(xc-p*ar//1,yc-p*ar//1,xc+p*ar//1,yc+p*ar//1,s,c[3])self:draw_text_fast(self.v[1],xc-xo,yc+s,s/2,c[2])local xn=(#self.id*(s/2))/2-s//32;self:draw_text_fast(self.id,xc-xn,yc-1.5*s,s/2,c[2])for i=0,12,1 do bv=element[i]:button_value()col=black;if bv>0.0 then col={deb,0,bv*25}end;deb=20*i;fin=deb+20;lcd:draw_text_fast(i,deb,0,sz,{deb,0,bv*255})lcd:draw_rectangle_rounded_filled(deb,43,fin-1,bv*0.1,10,col)end;if element[8]:endless_value()>0.01 then bv=element[8]:endless_value()col=black;if bv>0.0 then col={deb,0,bv*25}end;deb=20*13;fin=deb+20;lcd:draw_text_fast(bv,deb,0,sz+3,{deb,0,bv*255})lcd:draw_rectangle_rounded_filled(deb,43,fin-1,12.1,10,col)end;lcd:draw_swap()end
