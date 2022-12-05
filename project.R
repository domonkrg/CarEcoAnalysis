# Author: Rylee Domonkos

# Imports ----------------------------------------------------------------------

if(require(pacman)==F) install.packages("pacman")
pacman::p_load(lubridate)
pacman::p_load(tidyverse)
pacman::p_load(rvest)
pacman::p_load(stringr)
pacman::p_load("xlsx")
pacman::p_load(DataExplorer)

# Scrape web for most recent 7 years from the table ----------------------------

baseURL = "https://www.fueleconomy.gov/feg/"

step0 = paste(baseURL , 'download.shtml',  sep = "")

step1 = read_html(step0)

step2 = html_elements(step1, "table > tr > td:nth-child(3) > a") 

recentYears = html_attr(step2, name = 'href')

listRecentYears = as.list(recentYears)

# Build df of links and years --------------------------------------------------

# pull 1, 3, 5, 7, 9, 11, 13 and create the links 
linkList = list()
yearNos = as.list(as.integer(stringr::str_extract(recentYears, "\\d+")))

for (x in 1:13) {
  if(x%%2 == 1){
    linkList[x] = paste(baseURL, listRecentYears[[x]], sep = "")
    linkList[x+1] =  2000 + yearNos[[x]] # will work for the next 1977 years so this kind of hard coding is probably acceptable
  }
}

# Bring in data ----------------------------------------------------------------

temp <- tempfile()

download.file(linkList[[1]], temp)
data1 <- read.xlsx(temp, 1)
data1 <- data1 %>%
  mutate(Year = linkList[[2]])

download.file(linkList[[3]], temp)
data2 <- read.xlsx(temp, 1)
data2 <- data2 %>%
  mutate(Year = linkList[[4]])

download.file(linkList[[5]], temp)
data3 <- read.xlsx(temp, 1)
data3 <- data3 %>%
  mutate(Year = linkList[[6]])

download.file(linkList[[7]], temp)
data4 <- read.xlsx(temp, 1)
data4 <- data4 %>%
  mutate(Year = linkList[[8]])

download.file(linkList[[9]], temp)
data5 <- read.xlsx(temp, 1)
data5 <- data5 %>%
  mutate(Year = linkList[[10]])

download.file(linkList[[11]], temp)
data6 <- read.xlsx(temp, 1)
data6 <- data6 %>%
  mutate(Year = linkList[[12]])


download.file(linkList[[13]], temp)
data7 <- read.xlsx(temp, 1)
data7 <- data7 %>%
  mutate(Year = linkList[[14]])

unlink(temp)

# Build full datafame and make data tidy and consistent ------------------------

full.data = rbind(data1, data2, data3, data4, data5, data6, data7)

final.data <- full.data %>%
  mutate(`Vehicle Class` = Veh.Class, 
         `Air Pollution Score` = Air.Pollution.Score, `City MPG` = City.MPG,
         `Highway MPG` = Hwy.MPG, `Combination MPG` = Cmb.MPG, `Combination CO2`
         = Comb.CO2, `Greenhouse Gas Score` = Greenhouse.Gas.Score) %>%
  select(Model, Year, Drive, Fuel, `Vehicle Class`, `Air Pollution Score`, 
         `City MPG`, `Highway MPG`, `Combination MPG`, `Greenhouse Gas Score`, 
         SmartWay, `Combination CO2`)  %>% 
  distinct(Model, Year, Drive, .keep_all = TRUE) %>%
  filter((Fuel == "Gasoline" | Fuel == "Electricity") & `Vehicle Class` != "special purpose")

write.csv(final.data,paste(getwd(), "/fullData.csv", sep=""), row.names = FALSE)


# Report information -----------------------------------------------------------

create_report(full.data, output_file = "starting_report.html", output_dir = getwd())

create_report(full.data, output_file = "starting_report.docx", output_format = 
                "word_document", output_dir = getwd())

create_report(final.data, output_file = "final_report.docx", output_format = 
                "word_document", output_dir = getwd())

create_report(final.data, output_file = "final_report.html", output_dir = getwd())
