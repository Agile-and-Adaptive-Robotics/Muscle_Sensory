data_chosen = cell(length(state),1)

for i= 1:length(state)
    data_chosen{i} = data_select(diameter,lengths,kink,testnum,state(i))
end