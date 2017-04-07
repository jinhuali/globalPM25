# globalPM25


This package is developed for users to access and plot real-time air pollute PM2.5 level near you, at a city, at any location, or in a region around the world. The purpose is to increase overall awareness about the dangerous of air pollution to human health, particularly in some developing countries. 


## What is PM2.5 and why it is dangerous to you and your family's health

PM2.5 refers to atmospheric particulate matter (PM) that have a diameter less than 2.5 micrometers. PM2.5 can come from various sources. Many experts believe that two main sources are power plants and motor vehicles. The effects of inhaling PM that have been widely studied in humans and animals include asthma, lung cancer, cardiovascular disease, respiratory diseases, premature delivery, birth defects, and premature death. Please refer to the wikipedia page [Particulate Matter](https://en.wikipedia.org/wiki/Particulates) about PM's health effects and more.  


## How is PM2.5 measured?

According to US EPA, PM2.5 can be both quantitatively measured by AQI  (air quality index) and qualitatively measured by APL (air pollution level). 

![EPA PM2.5 standard (APL=Air Quality Index Levels of Health Concern, AQI=Numeric Value)](\vignettes\EPApm25AQIOverview.png)

Please refer to US EPA official website [airnow.gov](https://airnow.gov/index.cfm?action=aqibasics.aqi) for more information. In this package, both AQI and APL are provided. 


## Data source 

The real-time PM2.5 data feed are from [WAQ (World Air Quality) Project](http://www.aqicn.org) via JSON API. According to WAQ, "Real-time Air Quality information is available for than 9000 stations in 800 major cities from 70 countries, thanks to the huge effort from the world EPAs (Environmental Protection Agencies)." 

To use globalPM25 package to access real-time PM2.5 data feed, users first need to request a personal token from WAQ website. To request your personal token, please visit this [link](http://aqicn.org/data-platform/token/). For more about JSON API, please visit this [link](http://aqicn.org/json-api/doc/).


## Functions and data overview 

There are 10 functions/.R files in the package. Below are the names and a short description for each of them.

1. `settoken(token)`: set your personal token requested from WAQ website

1. `processPMdata(data)`: process raw data feed. extract information such as PM2.5 AQI, APL, local time, address, and geographical location into a dataframe  

1. `getPMbyCityNames(citynames)`: query PM2.5 level by a city name or a vector of city names. this function will request real-time feed and process the feed by calling `processPMdata`. Output is organized in a dataframe. 

1. `getPMbylatlon(latitude, longitude)`: similar to `getPMbyCityNames` but query by latitude and longitude instead of a city name

1. `getPMnearme()`: similar to `getPMbyCityNames` but query by a station closest to you based on computer IP address.  

1. `getPMinRegion()`: similar to `getPMbyCityNames` but query by a list of stations in a region. The region can be defined in two ways: a) `getPMinRegion(cityname, distance)` a city name and a distance range. b) `getPMinRegion(geobound = c(lat1, lon1, lat2, lon2))` a rectangular boundary defined by a pair of latitudes and longitudes at opposite corners. 

1. `getPMatMajorWorldCities()`: similar to `getPMbyCityNames` but the cities are pre-selected major cities around the world. the city names can be listed using `getglobalPM25Options()` and set using `setworldcities(citynames)` in `global.R`. 

1. `plotPMdat()`: demo to plot some results

1. `zzz.R`: use to suppress no global variable binding note. 

1. `global.R`: set access to some variables such as token string, WAQ URL string, etc.

There are 2 data sets, which are:

1. `usdat.rda`: this contains PM2.5 data collected from all stations at continental USA using `getPMinRegion()`. the data are collected at 4pm PST, March 19, 2017

1. `worlddat.rda`: this contains PM2.5 data collected from a list of large cities worldwide using `getPMatMajorWorldCities()`. the data are collected at 4pm PST, March 19, 2017

## Example
![PM2.5 data collected from stations at a list of selected cities worldwide; \n the data are sampled at 4pm PST, March 19, 2017)](\vignettes\sampleworld.png)
![PM2.5 data collected from stations at a list of selected cities worldwide; \n the data are sampled at 4pm PST, March 19, 2017)](\vignettes\EPApm25AQIOverview.png)
![EPA PM2.5 standard (APL=Air Quality Index Levels of Health Concern, AQI=Numeric Value)](\vignettes\EPApm25AQIOverview.png)

## Conclusion and Future work
First of all, I would like to thank WAQ for making the data available. This package allows users to access real-time air pollute PM2.5 level in various ways: near the user, at any city, at any location, and/or in a region. Basic sorting and plot are implemented. The package was built using R studio with devtools and shared at [github](https://github.com/jinhuali/globalPM25). 

I plan to continue to maintain the package. Some future work can be: a) change to S6 or reference class, b) add more real-time air pollute parameters such O3, NO2, SO2, PM10 levels. that are available from WAQ server, c) add functions to save the data so that users can retrieve historical data. 

