/ selects out NBA regular season and playoff rows, 
/ adds HOME & AWAY columns, 
/ and cleans up SELECTION for Match Odds and MoneyLine EVENTS

system"l util/json.k";

/ set some parameters and load up raw basketball data
sportsId:7522;
bettingData:`basketball;
system"l scripts/readRawData.q";

/ pull NBA regular season and playoff matches out of basketball data
NBA:select from basketball where 
	FULL_DESCRIPTION like "*NBA*",
	not FULL_DESCRIPTION like "*WNBA*",
	{string[x] like "* @ *"} each FULL_DESCRIPTION,
	not any FULL_DESCRIPTION like/: 
		("*[Pp]layoff*";"*[Ss]emi*";"*[Ff]inal*"),
	not FULL_DESCRIPTION like "*[Pp]re*",
	not FULL_DESCRIPTION like "*[Ss]ummer*",
	any EVENT like/: ("Match Odds";"Moneyline"),
	IN_PLAY=`PE;
NBAplayoffs:select from basketball where
        FULL_DESCRIPTION like "*NBA*",
        not FULL_DESCRIPTION like "*WNBA*",
        {string[x] like "* @ *"} each FULL_DESCRIPTION,
	any FULL_DESCRIPTION like/: 
		("*[Pp]layoff*";"*[Ss]emi*";"*[Ff]inal*"),
	any EVENT like/: ("Match Odds";"Moneyline"),
	IN_PLAY=`PE;

/ parse the team names out of the FULL_DESCRIPTION
homeTeam:{m:last "/" vs string x;
	  $["@" in m;
		  `$trim last "@" vs m;
		  `$trim last "v" vs m]};
awayTeam:{m:last "/" vs string x;
	  $["@" in m;
                  `$trim first "@" vs m;
                  `$trim first "v" vs m]};

{update HOME:homeTeam each FULL_DESCRIPTION,AWAY:awayTeam each FULL_DESCRIPTION from x} each `NBA`NBAplayoffs;

/ parse the team names
system"l scripts/config/nbaTeamConfig.q";
teamNameDict:parseTeamNames[NBA];
teamNameDict,:parseTeamNames[NBAplayoffs];
NBA:update HOME:teamNameDict[HOME],AWAY:teamNameDict[AWAY] from select from NBA where HOME in key[teamNameDict],AWAY in key[teamNameDict];
NBAplayoffs:update HOME:teamNameDict[HOME],AWAY:teamNameDict[AWAY] from select from NBAplayoffs where HOME in key[teamNameDict],AWAY in key[teamNameDict];
NBA:update SELECTION:teamNameDict[SELECTION] from NBA where SELECTION in key[teamNameDict],any EVENT like/: ("Moneyline";"Match Odds");
NBAplayoffs:update SELECTION:teamNameDict[SELECTION] from NBAplayoffs where SELECTION in key[teamNameDict],any EVENT like/: ("Moneyline";"Match Odds");

/clean up tables
delete SPORTS_ID from `NBA;
NBA:`EVENT_ID`SETTLED_DATE`FULL_DESCRIPTION`HOME`AWAY xcols NBA;
delete SPORTS_ID from `NBAplayoffs;
NBAplayoffs:`EVENT_ID`SETTLED_DATE`FULL_DESCRIPTION`HOME`AWAY xcols NBAplayoffs;

/ rename Seattle for consistancy
{update HOME:`Oklahoma from x where HOME=`Seattle} each `NBA`NBAplayoffs;
{update AWAY:`Oklahoma from x where AWAY=`Seattle} each `NBA`NBAplayoffs;

/ calculate match odds from bets placed, and implied win chance for each team
NBAmatchOdds:select first SCHEDULED_OFF,first HOME,first AWAY,CHANCE:{x:x-1;1-x%x+1}(VOLUME_MATCHED wavg ODDS),sum VOLUME_MATCHED,first WIN_FLAG by FULL_DESCRIPTION,SELECTION from `FULL_DESCRIPTION`SCHEDULED_OFF`HOME`AWAY`EVENT`SELECTION`ODDS`NUMBER_BETS`VOLUME_MATCHED`WIN_FLAG#NBA;
NBAmatchOdds:update CHANCE_ADJ:CHANCE%ADJ from (0!NBAmatchOdds) lj select ADJ:sum CHANCE by FULL_DESCRIPTION from NBAmatchOdds;
NBAmatchOdds:update SEASON:`year$-180+`date$NBAmatchOdds.SCHEDULED_OFF from NBAmatchOdds;

NBAplayoffmatchOdds:select first SCHEDULED_OFF,first HOME,first AWAY,CHANCE:{x:x-1;1-x%x+1}(VOLUME_MATCHED wavg ODDS),sum VOLUME_MATCHED,first WIN_FLAG by FULL_DESCRIPTION,SELECTION from `FULL_DESCRIPTION`SCHEDULED_OFF`HOME`AWAY`EVENT`SELECTION`ODDS`NUMBER_BETS`VOLUME_MATCHED`WIN_FLAG#NBAplayoffs;
NBAplayoffmatchOdds:update CHANCE_ADJ:CHANCE%ADJ from (0!NBAplayoffmatchOdds) lj select ADJ:sum CHANCE by FULL_DESCRIPTION from NBAplayoffmatchOdds;
NBAplayoffmatchOdds:update SEASON:`year$-180+`date$NBAplayoffmatchOdds.SCHEDULED_OFF from NBAplayoffmatchOdds;

system"l scripts/loadNbaDistances.q";
system"l scripts/loadNbaMarkets.q";
system"l scripts/loadNbaSalarys.q";
system"l scripts/loadNbaStats.q";

/ diffs:0!select diff:(avg WIN_FLAG)-(avg CHANCE_ADJ),extraWins:count[WIN_FLAG]*(avg WIN_FLAG)-(avg CHANCE_ADJ),wins:sum WIN_FLAG by year:SEASON,team:SELECTION from winChance

/ extra info, should be moved out to config?
/ update DISTANCE:distances'[HOME;AWAY] from `winChance;
/ update GAMES_IN_WEEK:-1+{[x;y] count select from winChance where within[x-`date$SCHEDULED_OFF;(0;7)],SELECTION=y}'[`date$SCHEDULED_OFF;SELECTION] from `winChance;
