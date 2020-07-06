* oef.do - Analyze OEF results
* 
* Created: 2019-10-11
*
* Last Edited: $Date$
*     Version: $Revision$

version 16

global cdate = c(current_date)

set more off

clear

log using oef.log, text replace

set seed 1234567


insheet using data.csv, clear

desc, full


drop if oef_mean==.

gen str35 studylabel1 = author + " (" + strofreal(year) + ") (N = " + strofreal(n) + ")"
label var studylabel1 "Study"


sort year


meta set oef_mean oef_se, studylabel(studylabel1) studysize(n)

meta summarize

meta forestplot

meta forestplot, xline(.425) markeropts(msym(s)) omarkeropts( mcol(maroon)) xt("OEF") col(_id, title("Study Method"))

graph save   graphs_oef/oef_all.gph, replace
graph export graphs_oef/oef_all.png, replace
graph export graphs_oef/oef_all.eps, replace
graph export graphs_oef/oef_all.ps, logo(off) mag(180) orientation(landscape) pagesize(letter) tmargin(.5) lmargin(.5) replace
graph export graphs_oef/oef_all.svg, width(10.5in) height(8in) replace

meta forestplot, subgroup(method region) xline(.425) markeropts(msym(s)) omarkeropts( mcol(maroon)) xt("OEF") col(_id, title("Study Method"))

graph save   graphs_oef/oef_method_region.gph, replace
graph export graphs_oef/oef_method_region.png, replace
graph export graphs_oef/oef_method_region.eps, replace
graph export graphs_oef/oef_method_region.ps, logo(off) mag(180) orientation(landscape) pagesize(letter) tmargin(.5) lmargin(.5) replace
graph export graphs_oef/oef_method_region.svg, width(10.5in) height(8in) replace

meta forestplot, subgroup(mxr) xline(.425) markeropts(msym(s)) omarkeropts( mcol(maroon)) xt("OEF") col(_id, title("Study Method"))

graph save   graphs_oef/oef_method_region2.gph, replace
graph export graphs_oef/oef_method_region2.png, replace
graph export graphs_oef/oef_method_region2.eps, replace
graph export graphs_oef/oef_method_region2.ps, logo(off) mag(180) orientation(landscape) pagesize(letter) tmargin(.5) lmargin(.5) replace
graph export graphs_oef/oef_method_region2.svg, width(10.5in) height(8in) replace


* DL estimator

meta set oef_mean oef_se, studylabel(studylabel1) studysize(n) random(dl)

meta summarize


* White Matter

meta summarize if region=="White"
global theta_wm = r(theta)

meta forestplot if region=="White", subgroup(method) xline($theta_wm) markeropts(msym(s)) omarkeropts( mcol(maroon)) xt("WM OEF") col(_id, title("Study Method"))

graph save   graphs_oef/oef_wm_method.gph, replace
graph export graphs_oef/oef_wm_method.png, replace
graph export graphs_oef/oef_wm_method.eps, replace
graph export graphs_oef/oef_wm_method.ps, logo(off) mag(180) orientation(landscape) pagesize(letter) tmargin(.5) lmargin(.5) replace
graph export graphs_oef/oef_wm_method.svg, width(10.5in) height(8in) replace


* Gray Matter

meta summarize if region=="Gray"
global theta_gm = r(theta)

meta forestplot if region=="Gray", subgroup(method) xline($theta_gm) markeropts(msym(s)) omarkeropts( mcol(maroon)) xt("GM OEF") col(_id, title("Study Method"))

graph save   graphs_oef/oef_gm_method.gph, replace
graph export graphs_oef/oef_gm_method.png, replace
graph export graphs_oef/oef_gm_method.eps, replace
graph export graphs_oef/oef_gm_method.ps, logo(off) mag(180) orientation(landscape) pagesize(letter) tmargin(.5) lmargin(.5) replace
graph export graphs_oef/oef_gm_method.svg, width(10.5in) height(8in) replace




label data "oef - $cdate"
capture drop _I*
compress
save oef, replace

log close


