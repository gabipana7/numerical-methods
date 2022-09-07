clc;
clear all;

% Intializare grid spatio-temporal

% spatiu
xi = -5;
xf = 5;
Nx = 1000;

dx = (xf-xi)/Nx;
dx2 = dx*dx;

% temporal
ti = 0;
tf = 5;
Nt = 10000;

dt = (tf-ti)/Nt;

% Preinitializez matricea functiei si vectorii spati-timp
u = zeros(Nx+1,Nt+1);
t = zeros(1,Nt+1);
x = zeros(1,Nx+1);

% parametrul vascozitate
v = 0.01;

% Conditiile initiale 
for j = 1:Nx+1
    % Intializez vectorul spatiu
    x(j) = xi + (j-1)*dx;
    % Conditiile initiale - u(xi,0) = exp(-xi^2)
    u(j,1) = exp(-x(j)^2);
end

t(1) = ti;

% Evolutia ecuatiei
for n = 1:Nt
    u(1,n+1) = u(1,n) + dt * (-u(1,n)*(u(2,n)-u(1,n))/dx + v * (u(2,n)-2*u(1,n))/dx2);
    for i =2:Nx
        u(i,n+1) = u(i,n) + dt * (-u(i,n)*(u(i+1,n)-u(i-1,n))/dx + v * (u(i+1,n)-2*u(i,n)+u(i-1,n))/dx2);
    end
    u(Nx+1,n+1) = u(Nx+1,n) + dt * (-u(Nx+1,n)*(u(Nx+1,n)-u(Nx,n))/dx + v * (-2 * u(Nx+1,n)+u(Nx,n))/dx2);
    
    t(n+1) = t(n) +dt;
end

figure(1)
mesh(t,x,u)
xlabel('t')
ylabel('x')
zlabel('u')

figure(2)
p1 = plot(x,u(:,1));
hold on
p2 = plot(x,u(:,Nt+1));
hold off
legend([p1,p1],'starea initiala','starea finala')
    
