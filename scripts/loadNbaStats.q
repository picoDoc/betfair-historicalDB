stats:()!();

{[year]
	t:flip `Player`Team`PS`GP`Min`FGM`FGA`3M`3A`FTM`FTA`OR`TR`AS`ST`TO`BK`PF`DQ`PTS`TC`EJ`FF`Sta!1_/:("SSSJJJJJJJJJJJJJJJJJJJJJ";17 4 3 4 5 5 5 4 3 5 5 5 5 4 4 4 4 4 5 5 4 4 3 4) 0: `$":data/stats/",year,".txt";
	if[year~"2012";td:`Atlanta`Boston`Brooklyn`Charlotte`Chicago`Cleveland`Dallas`Denver`Detroit`GoldenState`Houston`Indiana`LAClippers`LALakers`Memphis`Miami`Milwaukee`Minnesota`NewOrleans`NewYork`Oklahoma`Orlando`Philadelphia`Phoenix`Portland`Sacramento`SanAntonio`Toronto``Utah`Washington];
	if[any year~/:("2011";"2010";"2009";"2008");td:`Atlanta`Boston`Charlotte`Chicago`Cleveland`Dallas`Denver`Detroit`GoldenState`Houston`Indiana`LAClippers`LALakers`Memphis`Miami`Milwaukee`Minnesota`Brooklyn`NewOrleans`NewYork`Oklahoma`Orlando`Philadelphia`Phoenix`Portland`Sacramento`SanAntonio`Toronto``Utah`Washington];
	if[any year~/:("2007";"2006";"2005");td:`Atlanta`Boston`Charlotte`Chicago`Cleveland`Dallas`Denver`Detroit`GoldenState`Houston`Indiana`LAClippers`LALakers`Memphis`Miami`Milwaukee`Minnesota`Brooklyn`NewOrleans`NewYork`Orlando`Philadelphia`Phoenix`Portland`Sacramento`SanAntonio`Oklahoma`Toronto``Utah`Washington];
	d:(asc distinct t[`Team])!td;
	t[`Team]:d[t[`Team]];
	t:select from t where Team<>`;
	t:`Min xdesc t;
	t:select from t where not Player=`$"douglas-roberts";
	t[`Player]:`${" " sv reverse {@[x;0;{@[.Q.a!.Q.A;x]}]} each {"," vs x}[x]} each string t[`Player];
	stats[`$year]:(string team)!{select from y where Team=x}[;t] each team:distinct t`Team;
	} each ("2005";"2006";"2007";"2008";"2009";"2010";"2011";"2012");

playerStats:`year xcols raze value {[x;y]update year:y from raze value x}'[stats;key stats];
/.j.j (string key[stats])!value[stats]t


