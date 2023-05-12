%% this function prints the name of the csv file I need for optimization| selected based on the diameter, length amd state

function data_chosen = data_select(diameter,lengths,kink,testnum,state)
    data_chosen =(sprintf('AllBPA%dmm%dcm_%s',diameter,lengths,state)); 
end


