[This data is published under an [Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) license](https://creativecommons.org/licenses/by-nc-sa/4.0/)]

# About this story

The Washington Post is making public the data used in the story **[Domestic terrorism attacks are soaring in America, led by far-right extremists](https://www.washingtonpost.com/investigations/interactive/2021/domestic-terrorism-data/)**. It is a selection of 12 columns from a Center for Strategic & International Studies data set released publicly on April 12, 2021 and eight columns added by The Washington Post based on additional reporting and document gathering. Researchers may inquire with CSIS through [their website](https://www.csis.org/analysis/military-police-and-rise-terrorism-united-states) for the full CSIS data set.

* **[csis_wapo_domestic_terrorism.csv](https://github.com/wpinvestigative/csis_domestic_terrorism/raw/main/data/clean_data/csis_wapo_domestic_terrorism.csv)**

# About the data

The database includes 980 incidents since 1994 that met CSIS’s definition of terrorism: an attack or plot involving a deliberate use or threat of violence to achieve political goals, create a broad psychological impact or change government policy.

hat definition excludes many violent events, including incidents during nationwide unrest last year, because CSIS analysts could not determine whether attackers had a political or ideological motive.

Incidents do not have to be adjudicated in the court system to be included. Dozens of incidents have no identified perpetrator, but details about the attacks - including evidence of motive and the target - led to the case being included in the database.

The attacks and plots, all on U.S. soil, are classified by CSIS as far right, far left, religious or “ethnonationalist,” which means they support nationalist goals that often include dividing society along ethnic lines. Under the CSIS system, the attacks on 9/11 are in the religious category because the perpetrators were Islamist terrorists.

To build its dataset, CSIS reviewed several terrorism and political violence data sets, FBI/DOJ documentation and media reports (see [methodology](https://csis-website-prod.s3.amazonaws.com/s3fs-public/publication/210412_Jones_Methodology.pdf?mG2pmLJmpc4OAKQdPDm8n.9cWaDW8Pj4) for full details). CSIS considers the data set a living document and occasionally makes adjustments.

**CSIS variables (includes all attack/plot orientations from 1994 to Jan. 2021):**

* Year_csis	
* Month_csis	
* Day_csis	
* State_csis	
* City_csis	
* Orientation_csis	
* LEStatus_csis	
* MILStatus_csis	
* Target_csis	
* Weapon_csis	
* Lat_csis	
* Long_csis

Some attacks do not have an easily discerned motive or a single ideological thread. To refine the types of extremism involved in each case, The Post compiled court records, social media postings, news accounts and other material from local, state and federal law enforcement authorities.

For example, the extended review enabled the The Post to determine that at least 15 attacks or plots involved predominantly black churches over the last six years.


**Washington Post variables (includes only "Violent Right-wing" orientation from 2015 to Jan. 2021):**

* type_extremism_1	
* type_extremism_2	
* victim_category	
* victim_specific1	
* victim_specific2	
* susp_total	
* susp_hometown	
* susp_social_media_use



# Folders of note in this repo

* **[data/clean_data](data/clean_data)** - Cleaned up, public data from [CSIS](https://csis-website-prod.s3.amazonaws.com/s3fs-public/publication/210412_Jones_Methodology.pdf?mG2pmLJmpc4OAKQdPDm8n.9cWaDW8Pj4) as well as additional categorization by The Washington Post.
* **[data/raw_data](data/raw_data)** - Raw data from CSIS, as well as additional categorization by The Washington Post.
* **[scripts/markdown](scripts/markdown)** - R Markdown files used to generate exploratory data analysis
* **[scripts/analysis](scripts/analysis)** - Exploratory analysis scripts

# Notebooks

* [Summary findings of CSIS data analysis](http://wpinvestigative.github.io/csis_domestic_terrorism/output/docs/01_wapo_csis_analysis.html) - Analysis of CSIS data that was used in the story.
* [Deeper analysis of CSIS data](http://wpinvestigative.github.io/csis_domestic_terrorism/output/docs/02_more_analysis.html) - Analysis of many more factors within the data.
* [Static maps](http://wpinvestigative.github.io/csis_domestic_terrorism/output/docs/03_map_groups.html) - Maps of where right-wing domestic terrorism incidents occurred since 1994.
* [Exploratory map](http://wpinvestigative.github.io/csis_domestic_terrorism/output/docs/04_exploratory_map.html) - Exploratory map and table dashboard of right-wing plots and incidents since 2015.

# Related

* [Global Terrorism Database analysis (2018)](https://github.com/wpinvestigative/global_terrorism_database_analysis)

