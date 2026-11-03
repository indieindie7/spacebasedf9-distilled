local T=MOAITextBox
local J={L=T.LEFT_JUSTIFY,R=T.RIGHT_JUSTIFY,C=T.CENTER_JUSTIFY}
local M={}
function M.tex(k,tn,sp,pos,c,s,h) return {key=k,type='uiTexture',textureName=tn,sSpritesheetPath=sp,pos=pos,color=c,scale=s,hidden=h} end
function M.px(k,pos,s,c,h) return {key=k,type='onePixel',pos=pos,scale=s,color=c,hidden=h} end
local function tb(f) return function(k,pos,t,st,r,c,h,v,hid) return {key=k,type='textBox',pos=pos,[f]=t,style=st,rect=r,color=c,hAlign=J[h or 'L'],vAlign=J[v or 'L'],hidden=hid} end end
M.tx=tb('text')
M.lc=tb('linecode')
function M.c(k,c) return {key=k,color=c} end
function M.v(k,h) return {key=k,hidden=h} end
local function hs(f,g) return function(...) local o,c={},nil for _,a in ipairs({...}) do if type(a)=='string' then o[#o+1]={key=a,[f]=c} elseif not(a==true and g) then c=a end end return o end end
M.hv=hs('color',1)
M.hh=hs('hidden')
function M.btn(k,pos,s,c,on,off,pa,ra) local b={key=k,type='onePixelButton',pos=pos,scale=s,color=c,onHoverOn=on,onHoverOff=off}
 if pa then b.onPressed={{key=k,color=pa}} end
 if ra then b.onReleased={{key=k,color=ra}} end
 return b end
return M
