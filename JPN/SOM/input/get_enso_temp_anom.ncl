; 1965,1968,1969,1976,1986,1987,1991,2002,2004,2009,2015

load "$SysE/lib/ncl/helper_libs.ncl"
load "$SysE/lib/ncl/syse_db.ncl"

function get_monthly(vnm,year)
begin
  src  = "APHRODITE"
  lat  = (/30,46/)
  lon = (/126,150/)
  tim = (/"01Jan"+year,"31Mar"+(/year+1/)/)
  opt = True
  ;opt@local_file = "aphro_enso_temp.nc"
  opt@DataRoot = "/home/kohei/SysE_DB"
  var = syse_get_mon_anom(src,vnm,lat,lon,tim,opt)
  return(var)

; smooth temp with 3-mon running mean
; var_mon =  runave_n_Wrap(var,3,1,0)
; return(var_mon)
end

vnm  = "temp"

o65 = get_monthly(vnm,1965)
o68 = get_monthly(vnm,1968)
o69 = get_monthly(vnm,1969)
o76 = get_monthly(vnm,1976)
o86 = get_monthly(vnm,1986)
o87 = get_monthly(vnm,1987)
o91 = get_monthly(vnm,1991)
o02 = get_monthly(vnm,2002)
o04 = get_monthly(vnm,2004)
; o09 = get_monthly(vnm,2009)
; o15 = get_monthly(vnm,2015)

var = o65
var = (/(o65+o68+o69+o76+o86+o87+o91+o02+o04)/9.0/)
var = runave_n_Wrap(var,3,-1,0)

tunits = o65&time@units
delete(var&time)
var&time  = make_monthly_time(1904,1,15,1905,3,15,tunits,15)
mon_var_fil ="enso_comp_aphro_"+vnm+"_mon.nc"
rm_file_if_present(mon_var_fil)
fout = fopen_write(mon_var_fil)
fout->temp = var
