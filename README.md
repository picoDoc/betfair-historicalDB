betfair-historicalDB
====================

kdb+ code to parse betfair historical data, and some supporting databases

- fill up the data/raw data folder with betfair historical data csvs 
  (can be downloaded from http://www.nielda.co.uk/betfair/data/ or betfair itself)
- run parseNbaData.q to parse the data and save to tables in tables/
- run q loadTables.q to open a session with all the tables present and json parser
