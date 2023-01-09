%calculating strains and relative strains
%10mm - max strain (from excel: BPAparameters) 
kink = {'Unkink_','kinked25_','kinked50_','kinked75_'};
test = {'Test8','Test9','Test10'};

maxstrain_10mm10cm = 0.156626506;
maxstrain_10mm15cm =0.159090909;
maxstrain_10mm20cm =0.164835165;
maxstrain_10mm25cm =0.17167382;
maxstrain_10mm30cm =0.174377224;
maxstrain_10mm40cm =0.178010471;

%% Loading 10mm 10cm data(Force,Pressure,t,state) for all lengths and kinks
% Note = 10cm is the cut length(lc), (lo = resting length)
lo = 8.3;
l620 = 7;
li = [8.3,7.975,7.65,7.325];
kink_p = [0 25 50 75];
for a = 1:length(kink)
    for b=1:length(test)
        BPA10mm10cm{b,a}=csvread(['10mm_10cm_',kink{a},test{b},'.csv'])
        BPA10mm10cm{b,a}(:,5) = 10; %cut length
        BPA10mm10cm{b,a}(:,6) = ones(length(BPA10mm10cm{b}),1)*lo;
        BPA10mm10cm{b,a}(:,7) = kink_p(a);
        BPA10mm10cm{b,a}(:,8) = li(a);
        BPA10mm10cm{b,a}(:,9) = l620;
    end
end

% %% 15cm
% lo = 13.2;
% l620= 11.1;
% li = [13.2	12.675	12.15	11.625]
% 
% 
% %% 20cm
% lo = 18.2;
% l620= 15.2;
% li = [18.2	17.45	16.7	15.95]
% 
% 
% 
% %% 25cm
% lo = 23.3;
% l620=19.3;
% li = [23.3	22.3	21.3	20.3]
% 
% 
% 
% %% 30cm
% lo = 28.1;
% l620 = 23.2;
% li = [28.1	26.875	25.65	24.425]
% 
% 
% 
% %% 40cm
% lo = 38.2;
% l620 = 31.4;
% li = [38.2	36.5	34.8	33.1]



