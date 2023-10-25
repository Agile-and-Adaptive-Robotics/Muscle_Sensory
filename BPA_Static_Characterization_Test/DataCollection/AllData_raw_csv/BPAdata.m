%Processing BPA data for any BPAdiameter = '10mm', '20mm','40mm'
BPAdiameter = '10mm'
%function [BPAlengths,NumberofTotalDataRecordings,importcsv]=BPAdata(BPAdiameter)
  %makeglobal;
%importing all data for 10mm | 20mm| or 40mm
  BPAdiameter_dir = sprintf('%s*.csv',BPAdiameter);
  importcsv = dir(BPAdiameter_dir);
 
%Searching all resting lengths used in BPA data recording
  findlengths = strings;
    for i = 1:length(importcsv)
        BPA_alldatafiles(i)=convertCharsToStrings(importcsv(i).name);
        findlengths(i) = regexp(BPA_alldatafiles(i),'[0-9]{2}cm','match');
    end
      %showing all BPA lengths' data recordings. 
      findlengths = (findlengths');
      [numberofdata,BPAlengths]=findgroups(findlengths)
      NumberofTotalDataRecordings = length(importcsv);

%% Seach for all kinked lengths per lengths
lengthsearch_dir = strings;
%Creating strings for all lengths
for j = 1:length(BPAlengths)
    lengthsearch_dir(j) = sprintf('%s_%s*.csv',BPAdiameter,BPAlengths(j)) %lists all BPAdiameter_lengths
end








%%
lengthgrouped = cell(length(BPAlengths),1)
a=strings;

for k = 1:length(lengthsearch_dir)
    lengthgrouped{k} = dir(lengthsearch_dir(k))
    for l=1:length(lengthgrouped{k})
        a(l,k) = convertCharsToStrings(lengthgrouped{k}(l,1).name) %a contains ALL file names
    end
end

%finding the kinks in each length
BPAkinks = strings;
for k = 1:length(lengthsearch_dir)
    expression = '([KU][a-zA-Z0-9]+)';
    BPAkinks_search{k} = regexp(a(:,k),expression,'match')
    BPAkinks = convertCharsToStrings(BPAkinks_search)
end



