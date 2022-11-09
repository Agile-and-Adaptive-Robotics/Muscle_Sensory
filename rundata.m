function rundata
[Offset,OffsetStat] = ValvePWM(2,5,29000,0,500,400,500);
[Test1Data,Test1Stat]=ValvePWM(2,5,29000,10,500,470,500);
[Test2Data,Test2Stat]=ValvePWM(2,5,29000,10,500,470,500);
[Test3Data,Test3Stat]=ValvePWM(2,5,29000,10,500,460,500);
[Test4Data,Test4Stat]=ValvePWM(2,5,29000,10,500,460,500);
[Test5Data,Test5Stat]=ValvePWM(2,5,29000,10,500,440,500);
[Test6Data,Test6Stat]=ValvePWM(2,5,29000,10,500,440,500);
[Test7Data,Test7Stat]=ValvePWM(2,5,29000,5,500,460,500);
[Test8Data,Test8Stat]=ValvePWM(2,5,29000,5,500,460,500);
[Test9Data,Test9Stat]=ValvePWM(2,5,29000,5,500,450,500);
[Test10Data,Test10Stat]=ValvePWM(2,5,29000,5,500,450,500);

%% Run ValvaPWM_mod _ Use this. 

[Offset,OffsetStat] = ValvePWM_mod(2,3,29000,0,500,400,500);
[Test1Data,Test1Stat]=ValvePWM_mod(2,3,29000,10,500,470,500);
[Test2Data,Test2Stat]=ValvePWM_mod(2,3,29000,10,500,470,500);
[Test3Data,Test3Stat]=ValvePWM_mod(2,3,29000,10,500,460,500);
[Test4Data,Test4Stat]=ValvePWM_mod(2,3,29000,10,500,460,500);
[Test5Data,Test5Stat]=ValvePWM_mod(2,3,29000,10,500,440,500);
[Test6Data,Test6Stat]=ValvePWM_mod(2,3,29000,10,500,440,500);
[Test7Data,Test7Stat]=ValvePWM_mod(2,3,29000,5,500,460,500);
[Test8Data,Test8Stat]=ValvePWM_mod(2,3,29000,5,500,460,500);
[Test9Data,Test9Stat]=ValvePWM_mod(2,3,29000,5,500,450,500);
[Test10Data,Test10Stat]=ValvePWM_mod(2,3,29000,5,500,450,500);

%% Oct 2022 only do two tests (test 9 and 10) 
[Offset,OffsetStat]=ValvePWM_mod(2,3,45000,0,500,450,500);
[Test8Data,Test8Stat]=ValvePWM_mod(2,3,45000,10,500,450,500);
[Test9Data,Test9Stat]=ValvePWM_mod(2,3,45000,5,500,450,500);
[Test10Data,Test10Stat]=ValvePWM_mod(2,3,45000,5,500,450,500);



