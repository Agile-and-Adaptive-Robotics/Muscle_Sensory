idx_P = (AllBPA10mm13cm(:,8) ==1)

plot(AllBPA10mm13cm(idx_P,3),AllBPA10mm13cm(idx_P,1),'o')

idx_DP = AllBPA10mm13cm(:,8) ==0
plot(AllBPA10mm13cm(idx_DP,3),AllBPA10mm13cm(idx_DP,1),'.')