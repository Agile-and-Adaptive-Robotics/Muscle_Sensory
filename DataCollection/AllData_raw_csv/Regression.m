% regression to optimize equation

%k = readmatrix('OptimizingParameters.xlsx','Sheet','Model7_2')
diameter=10; lengths=13; test=10;
[diameter,lengths,lo,li,l620,kink,kmax,testnum,State,B0,B1] = choosedata(diameter,lengths,test);
strain = (lo - li)./lo;
max_strain = (lo - l620)./ lo;
relative_strain = strain./max_strain;

%%  creating regression matrix
x1 = (1-relative_strain)';
y = B1(1,:)'; 
X = [ones(size(y)) x1];
b = regress(y,X);


% plot fit to compare
figure
yfit = b(1) + x1*b(2);
plot(x1,yfit);
hold on
plot(x1,y,'o')
hold off
xlabel('1-relative strain')
ylabel('B1 - Slope')