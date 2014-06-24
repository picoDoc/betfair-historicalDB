teamMap:(`$("New York Knicks";"Dallas Mavericks";"Philadelphia 76ers";"Indiana Pacers";"Orlando Magic";"Los Angeles Lakers";"Houston Rockets";"Memphis Grizzlies";"New Jersey Nets";"San Antonio Spurs";"Sacramento Kings";"Milwaukee Bucks";"Toronto Raptors";"Minnesota Timberwolves";"Miami Heat";"Portland Trailblazers";"Detroit Pistons";"Utah Jazz";"Chicago Bulls";"Golden State Warriors";"Boston Celtics";"Denver Nuggets";"Washington Wizards";"Phoenix Suns";"Los Angeles Clippers";"Cleveland Cavaliers";"Seattle Sonics";"Atlanta Hawks";"New Orleans Hornets";"Charlotte Bobcats";"Oklahoma City Thunder";"Brooklyn Nets"))!`NewYork`Dallas`Philadelphia`Indiana`Orlando`LALakers`Houston`Memphis`Brooklyn`SanAntonio`Sacramento`Milwaukee`Toronto`Minnesota`Miami`Portland`Detroit`Utah`Chicago`GoldenState`Boston`Denver`Washington`Phoenix`LAClippers`Cleveland`Oklahoma`Atlanta`NewOrleans`Charlotte`Oklahoma`Brooklyn;

salarys:()!();

{
	year:x;
	x:`$":data/salary/",string[x],".txt";
	x:read0 x;
	teams:`$except\:[-12_/:4_/:x;"."];
	salary:%[;1000000]"J"$except\:[-12#/:x;"$ ,"];
	teams:teamMap teams;
	salarys[year]:([]team:teams;salary:salary);
	} each (2005;2006;2007;2008;2009;2010;2011;2012);
