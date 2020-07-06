* cmro.do - Analyze CMRO2 results
* 
* Created: 2019-10-11
*
* Last Edited: $Date$
*     Version: $Revision$

version 16

global cdate = c(current_date)

set more off

clear

log using cmro.log, text replace

set seed 1234567


insheet using data.csv, clear

desc, full

drop if cmro_sd==.

gen str35 studylabel1 = author + " (" + strofreal(year) + ") (N = " + strofreal(n) + ")"
label var studylabel1 "Study"


sort year



meta set cmro_mean cmro_se, studylabel(studylabel1) studysize(n)

meta summarize

meta forestplot

meta forestplot, xline(3.06) markeropts(msym(s)) omarkeropts( mcol(maroon)) xt("CMRO2") col(_id, title("Study Method"))

graph save   graphs_cmro/cmro_all.gph, replace
graph export graphs_cmro/cmro_all.png, replace
graph export graphs_cmro/cmro_all.eps, replace
graph export graphs_cmro/cmro_all.ps, logo(off) mag(100) orientation(portrait) pagesize(letter) tmargin(.5) lmargin(.5) replace
graph export graphs_cmro/cmro_all.svg, width(10.5in) height(8in) replace

meta forestplot, subgroup(method region) xline(3.06) markeropts(msym(s)) omarkeropts( mcol(maroon)) xt("CMRO2") col(_id, title("Study Method"))

graph save   graphs_cmro/cmro_method_region.gph, replace
graph export graphs_cmro/cmro_method_region.png, replace
graph export graphs_cmro/cmro_method_region.eps, replace
graph export graphs_cmro/cmro_method_region.ps, logo(off) mag(100) orientation(portrait) pagesize(letter) tmargin(.5) lmargin(.5) replace
graph export graphs_cmro/cmro_method_region.svg, width(10.5in) height(8in) replace

meta forestplot, subgroup(mxr) xline(3.06) markeropts(msym(s)) omarkeropts( mcol(maroon)) xt("CMRO2") col(_id, title("Study Method"))

graph save   graphs_cmro/cmro_method_region2.gph, replace
graph export graphs_cmro/cmro_method_region2.png, replace
graph export graphs_cmro/cmro_method_region2.eps, replace
graph export graphs_cmro/cmro_method_region2.ps, logo(off) mag(100) orientation(portrait) pagesize(letter) tmargin(.5) lmargin(.5) replace
graph export graphs_cmro/cmro_method_region2.svg, width(10.5in) height(8in) replace



* DL estimator

meta set cmro_mean cmro_se, studylabel(studylabel1) studysize(n) random(dl)

meta summarize


* White Matter

meta summarize if region=="White"
global theta_wm = r(theta)

meta forestplot if region=="White", subgroup(method) xline($theta_wm) markeropts(msym(s)) omarkeropts( mcol(maroon)) xt("WM CMRO2") col(_id, title("Study Method"))

graph save   graphs_cmro/cmro_wm_method.gph, replace
graph export graphs_cmro/cmro_wm_method.png, replace
graph export graphs_cmro/cmro_wm_method.eps, replace
graph export graphs_cmro/cmro_wm_method.ps, logo(off) mag(100) orientation(portrait) pagesize(letter) tmargin(.5) lmargin(.5) replace
graph export graphs_cmro/cmro_wm_method.svg, width(10.5in) height(8in) replace


* Gray Matter

meta summarize if region=="Gray"
global theta_gm = r(theta)

meta forestplot if region=="Gray", subgroup(method) xline($theta_gm) markeropts(msym(s)) omarkeropts( mcol(maroon)) xt("GM CMRO2") col(_id, title("Study Method"))

graph save   graphs_cmro/cmro_gm_method.gph, replace
graph export graphs_cmro/cmro_gm_method.png, replace
graph export graphs_cmro/cmro_gm_method.eps, replace
graph export graphs_cmro/cmro_gm_method.ps, logo(off) mag(100) orientation(portrait) pagesize(letter) tmargin(.5) lmargin(.5) replace
graph export graphs_cmro/cmro_gm_method.svg, width(10.5in) height(8in) replace




label data "cmro - $cdate"
capture drop _I*
compress
save cmro, replace

log close


