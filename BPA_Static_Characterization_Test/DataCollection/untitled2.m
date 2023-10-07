% Using one mat file to save all test 0 to test 10 as csv with proper
% naming

data = load('2022FEB02_20mm_10cm_Kinked13mm_Data.mat');
diameter = '20mm';
BPAlength = '10cm';
kinklength = '13mm';
testnames = ["Offset","Test1","Test2","Test3","Test4","Test5","Test6","Test7","Test8","Test9","Test10"];
for i=1:length(testnames)
    if testnames(i)=='Offset'
    str=sprintf('data.%s',testnames(1))
    csvname = sprintf('%s_%s_%s_%s.csv',diameter,BPAlength,kinklength,testnames(i))
    else 
    str =sprintf('data.%sData',testnames(i))
    csvname = sprintf('%s_%s_%s_%s.csv',diameter,BPAlength,kinklength,testnames(i))
    end
    csvwrite(csvname,eval(str))
end

