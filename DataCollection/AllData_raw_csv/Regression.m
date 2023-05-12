% regression to optimize equation

%k = readmatrix('OptimizingParameters.xlsx','Sheet','Model7_2')
diameter=10; lengths=30; test=10;
[diameter,lengths,lo,li,l620,kink,kmax,testnum,State,B0,B1] = choosedata(diameter,lengths,test);
strain = (lo - li)./lo;
max_strain = (lo - l620)./ lo;
relative_strain = strain./max_strain;

%%  creating regression matrix
for i = 1:2 %cycles P and DP. 
    x1 = li';
    y = B0(i,:)'; 
    X = [ones(size(y)) x1];
    c = regress(y,X);
    c


    % plot fit to compare
    figure(i)
    yfit = c(1) + x1*c(2);
    plot(x1,yfit);
    hold on
    plot(x1,y,'o')
    hold off
    xlabel('length (li)')
    ylabel('B1 - Slope')
end