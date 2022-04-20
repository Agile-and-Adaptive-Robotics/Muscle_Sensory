% Function to plot all BPA data per diameter 

%function BPAdataplot(BPAdiameter)
BPAdiameter = '10mm'
%BPAlengths = 
BPAdiameter_dir = sprintf('%s*.csv',BPAdiameter)
importcsv = dir(BPAdiameter_dir)

for i = 1:length(importcsv)
    BPA_alldatafiles(i) = convertCharsToStrings(importcsv(i).name);
end

%%
lengthgroupeddata = cell(length(BPAlengths),1)%groupping data by length
BPAgroupedlength =strings;
for j = 1:length(BPAlengths)
    exp = sprintf('%s_%s*.csv',BPAdiameter,BPAlengths(j))
    lengthgroupeddata{j} = dir(exp)

    labelBPA = sprintf('%s_%s',BPAdiameter,BPAlengths(j))
    
%     
    for k = 1:length(lengthgroupeddata{j}) %find all the kink lengths
    BPAgroupedlength(k) = convertCharsToStrings(lengthgroupeddata{k}.name)
    end

end




