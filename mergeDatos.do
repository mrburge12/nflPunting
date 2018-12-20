********************************************************************************
** Preliminaries
********************************************************************************

clear
cls
br

********************************************************************************
** Import Data
********************************************************************************

import delimited "data/NGS-2016-post.csv", clear
save "data/ngs.dta"


local filelist NGS-2016-pre.csv NGS-2016-reg-wk1-6.csv NGS-2016-reg-wk7-12.csv ///
			   NGS-2016-reg-wk13-17.csv NGS-2017-post.csv NGS-2017-pre.csv ///
			   NGS-2017-reg-wk1-6.csv NGS-2017-reg-wk7-12.csv NGS-2017-reg-wk13-17.csv

			   
local filelist NGS-2017-reg-wk13-17.csv
foreach file of local filelist{
	import delimited "data/`file'", clear
	duplicates drop
	append using "data/ngs.dta", force
	save "data/ngs.dta", replace
}

clear
use "data/punts.dta", clear
drop _merge

merge m:1 gamekey playid using "data/ngs.dta", force

save "data/mergedPuntData.dta", replace

clear
import delimited "data/player_punt_data.csv", clear
merge m:1 gsisid using "data/mergedPuntData.dta", force nogen
