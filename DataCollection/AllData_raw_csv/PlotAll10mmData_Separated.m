%plotting with conditions: separating pressurizing and depressurizing data
figure
plot(AllBPA10mm13cm(:,2),AllBPA10mm13cm(:,1))
xlabel('pressure (kPa)')
ylabel('Force (N)')

%% Plot with conditions
figure
idx_p = AllBPA10mm13cm(:,8)==1;
idx_dp = AllBPA10mm13cm(:,8)==0;
plot(AllBPA10mm13cm(idx_p,2),AllBPA10mm13cm(idx_p,1),'o')
figure
plot(AllBPA10mm13cm(idx_p,3),AllBPA10mm13cm(idx_p,1),'o');
figure
plot(AllBPA10mm13cm(idx_dp,2),AllBPA10mm13cm(idx_dp,1),'.')
figure
plot(AllBPA10mm13cm(idx_dp,3),AllBPA10mm13cm(idx_dp,1),'.');
