% plot(AllBPA10mm30cm(:,2),AllBPA10mm30cm(:,1))
% xlabel('Force')
% ylabel('Pressure')

%% 
mm10_cm13_unkink= AllBPA10mm13cm(AllBPA10mm13cm(:,5)==0,:);

plot(mm10_cm13_unkink(:,2),mm10_cm13_unkink(:,1))
