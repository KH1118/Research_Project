require 'rubygems'
require 'numru/netcdf'
require 'pp'
include NumRu

file = NetCDF.open("../Masked/aphro_enso_anom_stn.nc")
temp = file.var("temp").get
station = file.var("station").get
file.close

pp temp.class
pp temp.size
pp temp.dim
pp temp.shape
ntim,nstn = temp.shape

# we need only temperature for selected season

fout = File.open("aphro_enso_anom_stn.txt","w")
fout.puts "#{ntim} rect 2 2 gaussian"
(0..nstn-1).each do |istn|

  txt = (temp[true,istn]).to_a.map do |s| 

    v="%2.2f"%s
    v.gsub("-99.90", "x")
  end
  fout.puts txt.join(" ")+" #{"%02d" % station[istn]}"
end
fout.close

