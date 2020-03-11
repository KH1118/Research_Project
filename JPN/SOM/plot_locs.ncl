load "$SysE/lib/ncl/helper_libs.ncl"
load "./node_helpers.ncl"

fin=fopen_read("./Masked/aphro_enso_anom_stn.nc")
node_dir="./node_members"
station=fin->station
lat=fin->lat
lon=fin->lon

n0 = (/"som0_0","som0_1","som1_0","som1_1"/)
n1 = (/"som3_0","som4_0","som3_1","som4_1"/)
n2 = (/"som0_4","som1_4"/)
n3 = (/"som3_4","som4_4"/)

wks = gsn_open_wks("png","som_locs")

ll0 = get_multiple_locs(lat,lon,node_dir,n0,station)
ll1 = get_multiple_locs(lat,lon,node_dir,n1,station)
ll2 = get_multiple_locs(lat,lon,node_dir,n2,station)
ll3 = get_multiple_locs(lat,lon,node_dir,n3,station)


;---Style up the Map
mpres              = True
;  mpres@gsnMaximize  = True             ; Maximize plot in frame.
mpres@gsnFrame     = False            ; Don't advance the frame
mpres@gsnDraw      = False            ; Don't advance the frame

mpres@mpDataSetName         = "Earth..4"   ; This new database contains
                                           ; divisions for other countries.
;mpres@mpDataBaseVersion     = "MediumRes"  ; Medium resolution database
mpres@mpDataBaseVersion     = "LowRes"  ; Medium resolution database
mpres@mpOutlineOn           = True         ; Turn on map outlines
mpres@mpOutlineSpecifiers   = (/"China","India"/)
;  mpres@mpOutlineSpecifiers   = (/"China:states","India:states"/)


;---Zoom in on Asia
mpres@mpMinLatF    = 30.
mpres@mpMaxLatF    = 46.
mpres@mpMinLonF    = 128.
mpres@mpMaxLonF    = 150.

map1 = gsn_csm_map(wks,mpres)
map2 = gsn_csm_map(wks,mpres)
map3 = gsn_csm_map(wks,mpres)
map4 = gsn_csm_map(wks,mpres)

; -- marker styling
gsres = True
gsres@gsMarkerIndex = 16  
gsres@gsMarkerSizeF = 0.004
d1=gsn_add_polymarker(wks,map1,ll0(1,:),ll0(0,:),gsres)
d2=gsn_add_polymarker(wks,map2,ll1(1,:),ll1(0,:),gsres)
d3=gsn_add_polymarker(wks,map3,ll2(1,:),ll2(0,:),gsres)
d4=gsn_add_polymarker(wks,map4,ll3(1,:),ll3(0,:),gsres)

pres = True
pres@gsnPanelFigureStrings = (/"A","B","C","D"/)
gsn_panel(wks,(/map1,map2,map3,map4/),(/2,2/), pres)
