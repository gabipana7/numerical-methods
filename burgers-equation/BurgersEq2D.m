clc;
clear all;

% Ecuatia Burgers 2D u(x,y,t)

% Intializare grid spatio-temporal

% spatiu x
xi = -5;
xf = 5;
Nx = 200;

dx = (xf-xi)/Nx;
dx2 = dx*dx;

% spatiu y
yi = -5;
yf = 5;
Ny = 200;

dy = (yf-yi)/Ny;
dy2 = dy*dy;

% temporal
ti = 0;
tf = 5;
Nt = 20000;

dt = (tf-ti)/Nt;

% Preinitializez matricea functiei si vectorii spati-timp
u = zeros(Nx+1,Ny+1,Nt/1000+1);
t = zeros(1,Nt+1);
x = zeros(1,Nx+1);
y = zeros(1,Ny+1);

% parametrul vascozitate
Re = 1000;

% Conditiile initiale 
for j = 1:Nx+1
    % Intializez vectorul spatiu x
    x(j) = xi + (j-1)*dx;
    for i = 1:Ny+1
        % Initializare vector spatiu y
        y(i) = yi + (i-1)*dy;
        % Conditiile initiale - u(xi,0) = exp(-xi^2)
        u1(j,i) = exp(-x(j)^2-y(i)^2);
    end
end

t(1) = ti;
u(:,:,1) = u1(:,:);

% u1(x,y) ~ timpul n
% u2(x,y) ~ timpul n+1
% Evolutia ecuatiei
k=1;
while k<Nt
    u2(1,1) = u1(1,1) + dt * (-u1(1,1)*(u1(2,1)-u1(1,1))/dx) + ...
        dt/Re * ((u1(2,1) - 2 *u1(1,1))/dx2 + (u1(1,2) - 2 *u1(1,1))/dy2);
   
    
    for j = 2:Nx
        for i = 2:Ny
            
            u2(j,i) = u1(j,i) + dt * (-u1(j,i)*(u1(j+1,i)-u1(j-1,i))/(2*dx))  + ...
                dt/Re * ((u1(j+1,i) - 2 *u1(j,i) + u1(j-1,i))/dx2 + (u1(j,i+1) - 2 *u1(j,i) + u1(j,i-1))/dy2);
        
        end
    end
    
    u2(Nx+1,Ny+1) = u1(Nx+1,Ny+1) + dt * (-u1(Nx+1,Ny+1)*(u1(Nx+1,Ny+1)-u1(Nx,Ny+1))/dx) + ... 
        dt/Re * ((-2 *u1(Nx+1,Ny+1) + u1(Nx,Ny+1))/dx2 + (-2 *u1(Nx+1,Ny+1) + u1(Nx+1,Ny))/dy2);
    
    % Salveaza din 1000 in 1000 iteratii
    if ~(mod(k,1000))
        u(:,:,(k/1000)+1) = u2(:,:);
    end
    
    % mareste k, continua while
    k=k+1;
    % timpul precedent devine timpul curent
    u1 = u2;

end

% Animation

obj = VideoWriter('burgers2D.avi');
obj.Quality = 100;
obj.FrameRate = 20;
open(obj);

hfig = figure(1);
pos = get(hfig, 'position');
set(hfig,'position',pos.*[.5 1 2 1])

subplot(1,2,1)
mesh(x,y,u(:,:,1))
title('Timp initial')
xlabel('x')
ylabel('y')
zlabel('u')

subplot(1,2,2)

for k= 1:(Nt/1000)
    mesh(x,y,u(:,:,k))
    title('Final Time')
    xlabel('x')
    ylabel('y')
    zlabel('u')
    drawnow
    view(90,0)
    f = getframe(gcf);
    writeVideo(obj,f)
end

obj.close()

