-- grid: page=0

-- grid:event element=255 event=init
--[[@cb]]
_G.p={0,0,0,0} _G.f={0,0,0,0} _G.b={0,0,0,0}

-- ============================================================

-- grid:event element=0 event=init
--[[@cb]]
self:pmi(0) self:pma(16383)

-- ============================================================

-- grid:event element=0 event=potmeter
--[[@cb]]
local n=self:ind() local v=self:pva() _G.p[1]=v glc(n,1,255,128,0) glp(n,1,v//64) gms(0,176,1,v//128) gms(0,176,33,v%128)

-- ============================================================

-- grid:event element=1 event=init
--[[@cb]]
self:pmi(0) self:pma(16383)

-- ============================================================

-- grid:event element=1 event=potmeter
--[[@cb]]
local n=self:ind() local v=self:pva() _G.p[2]=v glc(n,1,255,128,0) glp(n,1,v//64) gms(0,176,2,v//128) gms(0,176,34,v%128)

-- ============================================================

-- grid:event element=2 event=init
--[[@cb]]
self:pmi(0) self:pma(16383)

-- ============================================================

-- grid:event element=2 event=potmeter
--[[@cb]]
local n=self:ind() local v=self:pva() _G.p[3]=v glc(n,1,255,128,0) glp(n,1,v//64) gms(0,176,3,v//128) gms(0,176,35,v%128)

-- ============================================================

-- grid:event element=3 event=init
--[[@cb]]
self:pmi(0) self:pma(16383)

-- ============================================================

-- grid:event element=3 event=potmeter
--[[@cb]]
local n=self:ind() local v=self:pva() _G.p[3]=v glc(n,1,255,128,0) glp(n,1,v//64) gms(0,176,4,v//128) gms(0,176,36,v%128)

-- ============================================================

-- grid:event element=4 event=init
--[[@cb]]
self:pmi(0) self:pma(16383)

-- ============================================================

-- grid:event element=4 event=potmeter
--[[@cb]]
local n=self:ind() local v=self:pva() _G.f[1]=v glc(n,1,0,128,255) glp(n,1,v//64) gms(0,176,5,v//128) gms(0,176,37,v%128)

-- ============================================================

-- grid:event element=5 event=init
--[[@cb]]
self:pmi(0) self:pma(16383)

-- ============================================================

-- grid:event element=5 event=potmeter
--[[@cb]]
local n=self:ind() local v=self:pva() _G.f[2]=v glc(n,1,0,128,255) glp(n,1,v//64) gms(0,176,6,v//128) gms(0,176,38,v%128)

-- ============================================================

-- grid:event element=6 event=init
--[[@cb]]
self:pmi(0) self:pma(16383)

-- ============================================================

-- grid:event element=6 event=potmeter
--[[@cb]]
local n=self:ind() local v=self:pva() _G.f[3]=v glc(n,1,0,128,255) glp(n,1,v//64) gms(0,176,7,v//128) gms(0,176,39,v%128)

-- ============================================================

-- grid:event element=7 event=init
--[[@cb]]
self:pmi(0) self:pma(16383)

-- ============================================================

-- grid:event element=7 event=potmeter
--[[@cb]]
local n=self:ind() local v=self:pva() _G.f[4]=v glc(n,1,0,128,255) glp(n,1,v//64) gms(0,176,8,v//128) gms(0,176,40,v%128)

-- ============================================================

-- grid:event element=8 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:bva() _G.b[1]=v gms(0,v>0 and 144 or 128,36,v)

-- ============================================================

-- grid:event element=9 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:bva() _G.b[2]=v gms(0,v>0 and 144 or 128,37,v)

-- ============================================================

-- grid:event element=10 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:bva() _G.b[3]=v gms(0,v>0 and 144 or 128,38,v)

-- ============================================================

-- grid:event element=11 event=button
--[[@sbc]]
self:bmo(0) self:bmi(0) self:bma(127)
--[[@sglc]]
self:led_color(-1,{{-1,-1,-1,1}}) self:led_value(-1,-1)
--[[@cb]]
local v=self:bva() _G.b[4]=v gms(0,v>0 and 144 or 128,39,v)
