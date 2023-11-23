# Stellar Structure Data Analysis

In this project I extracted data from different Wikipedia pages about main-sequence stars; a kind of star in its early ages, that have a certain relationships between its components and a particular internal structure.
The main topics on this project are:
- Web scraping with python.
- Data wrangling.
- Data visualization.
- Statistical analysis.
- Evaluation of lineal models.

The data gathering process was developed with python using BeautifulSoup and request with pandas, to search the classic infobox tables in the 'Quick Facts' section about each star and extract different links to find each star page from a initial Wikipedia's page.
This part of the project was developed in the ZAMS_Web_scraping.ipynb file.

The data that we are looking for each star is its mass, luminosity, effective temperature and its metalicity, then it is used in a translation of the StarStar program, a model originally created in FORTRAN but that I developed in python as part of a homework in one of my astronomy classes.
With this program I was able to find the density, pressure and temperature in the center of each star, finally I developed a statistical analysis to find interesting relationships between the input and output variables from the StarStar model. This part of the project can be found in the StarStar_analysis.ipynb file.
