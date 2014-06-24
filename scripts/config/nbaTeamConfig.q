/ dictionary for correcting the hom and away team names 
parseTeamNames:{[t]
	teamDict:();  
	f:{x!count[x]#y};
	teams:exec distinct HOME from t;
	teams,:exec distinct AWAY from t;
	teams,:exec distinct SELECTION from t where any EVENT like/: ("Moneyline";"Match Odds");
	teams:distinct teams;
	teamDict,:f[teams where teams like "Atlan*";`Atlanta];
	teamDict,:f[teams where any teams like/: ("Boston*";"Boton*");`Boston];
	teamDict,:f[teams where any teams like/: ("Brook*";"New [Jj]e*";"N Jer*");`Brooklyn];
	teamDict,:f[teams where teams like ("Charl*");`Charlotte];
	teamDict,:f[teams where teams like ("Chic*");`Chicago];
	teamDict,:f[teams where teams like ("Clev*");`Cleveland];
	teamDict,:f[teams where teams like ("Dalla*");`Dallas];
	teamDict,:f[teams where teams like ("Denve*");`Denver];
	teamDict,:f[teams where teams like ("Detroi*");`Detroit];
	teamDict,:f[teams where any teams like/: ("Golden*";"G State*");`GoldenState];
	teamDict,:f[teams where teams like ("Houst*");`Houston];
	teamDict,:f[teams where teams like ("India*");`Indiana];
	teamDict,:f[teams where any teams like/: ("*C[Ll]i*";"Los Ang");`LAClippers];
	teamDict,:f[teams where any teams like/: ("*Lak*";"Los Angeles");`LALakers];
	teamDict,:f[teams where teams like ("*Memp*");`Memphis];
	teamDict,:f[teams where teams like ("*Miami*");`Miami];
	teamDict,:f[teams where teams like ("*Milwau*");`Milwaukee];
	teamDict,:f[teams where teams like ("*Minnes*");`Minnesota];
	teamDict,:f[teams where any teams like/: ("*[Nn]ew [Oo]*";"*NewO*";"*N O*");`NewOrleans];
	teamDict,:f[teams where any teams like/: ("*New Y*";"*NY*";"*N Y*");`NewYork];
	teamDict,:f[teams where teams like ("*Oklahom*");`Oklahoma];
	teamDict,:f[teams where teams like ("*[Oo]rland*");`Orlando];
	teamDict,:f[teams where any teams like/: ("*Phil*";"*Pdel*");`Philadelphia];
	teamDict,:f[teams where any teams like/: ("*Phoe*";"*Pheo*");`Phoenix];
	teamDict,:f[teams where teams like ("*Port*");`Portland];
	teamDict,:f[teams where teams like ("*Sac*");`Sacramento];
	teamDict,:f[teams where any teams like/: ("*S Ant*";"*San [Aa]*");`SanAntonio];
	teamDict,:f[teams where teams like ("*Toront*");`Toronto];
	teamDict,:f[teams where teams like ("*Utah*");`Utah];
	teamDict,:f[teams where any teams like/: ("*[Ww]ashin*";"*Wahin*");`Washington];
	teamDict,:f[teams where teams like ("*Seatt*");`Seattle];
	:teamDict
	};





