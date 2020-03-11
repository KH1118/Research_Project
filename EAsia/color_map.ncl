load "$SysE/lib/ncl/helper_libs.ncl"
load "$SysE/lib/ncl/syse_db.ncl"

f = addfile("./SOM/input/enso_comp_aphro_temp_mon.nc","r")
var = f->temp
vmam = var(3,{30:56},{100:150})
vjja = var(6,{30:56},{100:150})
vson = var(9,{30:56},{100:150})
vdjf = var(12,{30:56},{100:150})
vmam@clevs=(/-4.0,-3.5,-3.0,-2.5,-2.0,-1.5,-1.0,-0.8,-0.6,-0.3,-0.25,-0.2,-0.15,-0.1,-0.05,0.0,0.05,0.1,0.15,0.2,0.25,0.3,0.35,0.4,0.45/)
wks = open_wks("png","color_map","NCV_jaisnd")
res = True
set_string(res,0.1,"","")
res@cnFillColors=(/2,12,22,32,42,52,62,72,82,92,102,112,122,132,142,152,162,172,182,192,202,212,222,232,242,255/)
pmam = map_shaded(wks,vmam,res)
pjja = map_shaded(wks,vjja,res)
pson = map_shaded(wks,vson,res)
pdjf = map_shaded(wks,vdjf,res)

pres = True
pres@gsnPanelMainString = "Temperature anomalies during El Nino in different seasons"
pres@gsnPanelFigureStrings = (/"MAM","JJA","SON","DJF"/)
gsn_panel(wks,(/pmam,pjja,pson,pdjf/),(/2,2/),pres)
