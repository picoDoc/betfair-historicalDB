/ Script to grab the raw csv data from weekly files, 
/ separate out chosen sport,
/ cast to sym those cols that can be enumerated,
/ cast the time cols to time types,
/ and add to bettingData table

/ parameters bettingData (table name) and sportId must be set by wrapper

system"z 1";

f:system"ls data/raw_data";
f:`$f where f like "*.csv";
f:-1_f;
bettingData set ();
{
  -1 "raw data from the file ",string[x]," successfully loaded";
  t:("II*****I*FFF**I*";enlist ",") 0:` sv `:data/raw_data/,x;
  t:select from t where SPORTS_ID=sportsId;
  t:@[t;`SETTLED_DATE`FULL_DESCRIPTION`SCHEDULED_OFF`EVENT,(`$"DT ACTUAL_OFF"),`SELECTION`LATEST_TAKEN`FIRST_TAKEN`IN_PLAY;{y$x};`];
  bettingData insert t;
  } each 20#f;

/rename poorly named column and remove old col
![bettingData;();0b;(enlist`DT_ACTUAL_OFF)!(enlist`$"DT ACTUAL_OFF")];
bettingData set (enlist`$"DT ACTUAL_OFF") _value bettingData;

/ cast the time cols to time types
dt1:{("D"$10#x)+("V"$-8#x)};
dt2:{("D"$10#x)+("U"$-5#x)};
update SETTLED_DATE:dt1 each string SETTLED_DATE,
       SCHEDULED_OFF:dt2 each string SCHEDULED_OFF,
       LATEST_TAKEN:dt1 each string LATEST_TAKEN,
       FIRST_TAKEN:dt1 each string FIRST_TAKEN,
       DT_ACTUAL_OFF:dt1 each string DT_ACTUAL_OFF
       from bettingData;

.Q.gc[];
