%Create optimization problem having diffexpr as objective function
function 

diffun = c(1)*X+c(2)+lambda;
%Solving using default solver
[sol,fval,exitflag,output] = solve(ssqprob,xo)