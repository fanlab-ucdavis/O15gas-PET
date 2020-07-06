* added.do - Some additional analyses for submission
* 
* Created: 2020-02-24
*
* Last Edited: $Date$
*     Version: $Revision$

version 16

global cdate = c(current_date)

set more off

clear

log using added.log, text replace

set seed 1234567


***
***  OEF
***


use oef, clear

desc, full


* restore to REML method rather than DerSimonian-Laird

meta set oef_mean oef_se, studylabel(studylabel1) studysize(n)



**
**  Subgroup analyses of method and region
**


meta summarize, subgroup(region method)

meta forestplot, subgroup(method region) xline(.426) markeropts(msym(s)) omarkeropts( mcol(maroon)) xt("OEF") col(_id, title("Study Method"))

graph save   graphs_oef/oef_subgroup.gph, replace
graph export graphs_oef/oef_subgroup.png, replace
graph export graphs_oef/oef_subgroup.eps, replace
graph export graphs_oef/oef_subgroup.ps, logo(off) mag(180) orientation(landscape) pagesize(letter) tmargin(.5) lmargin(.5) replace
graph export graphs_oef/oef_subgroup.svg, width(10.5in) height(8in) replace


* Method

meta summarize, subgroup(method)


* Region

meta summarize, subgroup(region)


* Region within method

meta summarize if method=="Bolus", subgroup(region)

meta summarize if method=="SS", subgroup(region)



***
***  CMRO
***


use cmro, clear

desc, full


* restore to REML method rather than DerSimonian-Laird

meta set cmro_mean cmro_se, studylabel(studylabel1) studysize(n)


**
**  Subgroup analyses of method and region
**


meta summarize, subgroup(region method)

meta forestplot, subgroup(method region) xline(3.06) markeropts(msym(s)) omarkeropts( mcol(maroon)) xt("CMRO") col(_id, title("Study Method"))

graph save   graphs_cmro/cmro_subgroup.gph, replace
graph export graphs_cmro/cmro_subgroup.png, replace
graph export graphs_cmro/cmro_subgroup.eps, replace
graph export graphs_cmro/cmro_subgroup.ps, logo(off) mag(180) orientation(landscape) pagesize(letter) tmargin(.5) lmargin(.5) replace
graph export graphs_cmro/cmro_subgroup.svg, width(10.5in) height(8in) replace


* Method

meta summarize, subgroup(method)


* Region

meta summarize, subgroup(region)


* Region within method

meta summarize if method=="Bolus", subgroup(region)

meta summarize if method=="SS", subgroup(region)




*label data "added - $cdate"
*capture drop _I*
*compress
*save added, replace

log close

