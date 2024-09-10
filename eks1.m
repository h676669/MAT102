y=-5:0.25:5;
x=-5:0.25:5;
[x,y]=meshgrid(x,y);
f=x.^2+y.^2;
surf(x,y,f);
xlabel('x');
ylabel('y');
zlabel('z');