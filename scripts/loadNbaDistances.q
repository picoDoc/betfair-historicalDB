coord:`Chicago`Seattle`LALakers`Toronto`Washington`Cleveland`Boston`Minnesota`Memphis`Utah`Denver`Phoenix`Houston`Portland`LAClippers`GoldenState`SanAntonio`Atlanta`NewYork`Philadelphia`Dallas`Brooklyn`Charlotte`NewOrleans`Indiana`Detroit`Miami`Milwaukee`Orlando`Sacramento`Oklahoma!((41.8782;-87.6297);(47.6066;-121.3318);(34.0523;-118.2436);(43.6520;-79.3823);(38.9072;-77.0364);(41.4995;-81.6954);(42.3584308;-71.0597732);(44.983334;-93.26666999);(35.1495343;-90.0489801);(40.7607793;-111.89104739);(39.737567;-104.9847179000);(33.4483771;-112.0740372);(29.7601927;-95.369389);(45.5234515;-122.6762071);(34.0522342;-118.2436849);(37.7749295;-122.419415500);(29.4241219;-98.49362819);(33.7489954;-84.3879824);(40.7143528;-74.0059731);(39.952335;-75.163789000);(32.7801399;-96.8004510);(40.65;-73.9499999);(35.2270869;-80.84312669);(29.9510657;-90.0715323);(39.768403;-86.15806800);(42.331427;-83.0457538);(25.7889689;-80.2264392);(43.0389025;-87.906473600);(28.5383355;-81.3792364);(38.5815719;-121.4943996);(35.4675602;-97.5164275));

separation:{[lat1;long1;lat2;long2]
      		  angle:acos[(prd sin[lat1,lat2])+(prd cos[lat1,lat2,(abs long1-long2)])];
		  :6371*angle
		  };

distances:`home xkey update home:() from 0#flip coord;
{
	distances[x]:separation ./: %[;180%3.14159] coord[x],/:value[coord];
	} each key[coord];

