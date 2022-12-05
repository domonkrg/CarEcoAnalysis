# CarEcoAnalysis

## Project

### Overview

Created for ISA 401, data is pulled from a website hosted by the EPA to create a database with Make/Models across various years into a CSV file. The original purpose is to use the data to create a PowerBI Dashboard to compare which Make/Model, year, and drive variation is the most interesting for purchase by the viewer.

### Details

The link https://www.fueleconomy.gov/feg/download.shtml is scraped to find the seven topmost (aka most recent) EPA Green Vehicle Guide Datafiles. The scraping is done by looking for the table which houses all of the year files and then parsing through the third column in that table. The information in that column is where we find the information to build the URLs and find the year of said Datafiles. These are .xlsx files which are then downloaded using a temporary file and each year's data is put into a dataframe to be processed. 

All 7 dataframes are then combined using the rbind function to create the full.data dataframe.

The processing is done using the mutate, select, distinct, and filter functions from the dplyr package (housed within tidyverse). This ensures all variables are sensibly named, and only the variables of interest are kept. Additionally, this allows us make it so all of the MPG variants (highway, city and combination) can be read as numbers rather than strings, since hybrid fuel cars have slashes in their recorded MPG variables. 

Upon running, a CSV file named fullData.csv is created to house the data. Additonally, four Reports are also generated: 
  A folder of .png files of informational graphics about the the data before it is processed
  A folder of .png files of informational graphics about the the data after it is processed
  An html file of an auto generated report from the DataExplorer package on the preprocessed data
  An html file of an auto generated report from the DataExplorer package on the processed data

### Installation/Utilization

The R version used is 4.2.1- later versions will not work because the xlsx package doesn't work in the newest version(s) of R.

## Citations

  Cui B (2020). _DataExplorer: Automate Data Exploration and Treatment_. R package version 0.8.2,
  <https://CRAN.R-project.org/package=DataExplorer>.
  
  Dragulescu A, Arendt C (2020). _xlsx: Read, Write, Format Excel 2007 and Excel 97/2000/XP/2003 Files_. R package version 0.6.5,
  <https://CRAN.R-project.org/package=xlsx>.
  
  Garrett Grolemund, Hadley Wickham (2011). Dates and Times Made Easy with lubridate. Journal of Statistical Software, 40(3),
  1-25. URL https://www.jstatsoft.org/v40/i03/.
  
  R Core Team (2022). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna,
  Austria. URL https://www.R-project.org/.
  
  Rinker, T. W. & Kurkiewicz, D. (2017). pacman: Package Management for R. version 0.5.0. Buffalo, New York.
  http://github.com/trinker/pacman
  
  United States Evironmental Protection Agency. (2022, November 30). Download Fuel Economy Data. www.fueleconomy.gov - the official government source for  
  fuel economy information. Retrieved December 5, 2022, from https://www.fueleconomy.gov/feg/download.shtml 
  
  Wickham H, Averick M, Bryan J, Chang W, McGowan LD, François R, Grolemund G, Hayes A, Henry L, Hester J, Kuhn M, Pedersen TL,
  Miller E, Bache SM, Müller K, Ooms J, Robinson D, Seidel DP, Spinu V, Takahashi K, Vaughan D, Wilke C, Woo K, Yutani H (2019).
  “Welcome to the tidyverse.” _Journal of Open Source Software_, *4*(43), 1686. doi:10.21105/joss.01686
  <https://doi.org/10.21105/joss.01686>.
  
  Wickham H (2022). _rvest: Easily Harvest (Scrape) Web Pages_. R package version 1.0.3,
  <https://CRAN.R-project.org/package=rvest>.

  Wickham H (2022). _stringr: Simple, Consistent Wrappers for Common String Operations_. R package version 1.4.1,
  <https://CRAN.R-project.org/package=stringr>.
