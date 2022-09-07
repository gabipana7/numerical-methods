
% Initializarea matricei Oraselor
N=40;
x=rand(1,N);
y=rand(1,N);
figure(1);
% Figura oraselor si un drum random prin ele
plot(x,y,'*-');
title('Cities configuration and a random path')

% Initializarea intervalului temporal si a pasului temporal
Ti=1;
Tf=0.001;
dT=0.001;

% La fiecare pas dT, realizez un numar nsteps de reconfigurari
nsteps=2000;

% Timp initial si counter
T=Ti;
cont=1;

tic 
  while T>Tf
    
    for j=1:nsteps
      
      poz=round(1+(N-4)*rand);

      xc=x;
      yc=y;
      
      % Algoritmul de randomizare este inversarea random a unor drumuri
      xc(poz+1)=x(poz+2);
      yc(poz+1)=y(poz+2);
      
      xc(poz+2)=x(poz+1);
      yc(poz+2)=y(poz+1);
      
      % Calculez lungimi de 4 segmente
      % Lungimea initiala
      L=sqrt((x(poz)-x(poz+1))^2+(y(poz)-y(poz+1))^2)+sqrt((x(poz+1)-x(poz+2))^2+(y(poz+1)-y(poz+2))^2)+sqrt((x(poz+2)-x(poz+3))^2+(y(poz+2)-y(poz+3))^2);
      
      % Lungimea finala
      Lc=sqrt((xc(poz)-xc(poz+1))^2+(yc(poz)-yc(poz+1))^2)+sqrt((xc(poz+1)-xc(poz+2))^2+(yc(poz+1)-yc(poz+2))^2)+sqrt((xc(poz+2)-xc(poz+3))^2+(yc(poz+2)-yc(poz+3))^2);
      
      % Diferenta
      DL=Lc-L;
      
      % Calculez probabilitate
      p=exp(-DL/T);
      
      % Daca p>rand atunci alege drumul nou 
      if p>rand
        x=xc;
        y=yc;
      end 
    
    end
    Temp(cont)=T;
    
    T=T-dT;
    
    length(cont)=0;
    
    % Calculeaza lungimea totala a drumului
    for j=1:N-1
      length(cont)=length(cont)+sqrt((x(j)-x(j+1))^2+(y(j)-y(j+1))^2);
    end 
    
    nsteps=1.003*nsteps;
    
    cont=cont+1;
    
  end
  toc 
figure(2);
plot(x,y,'*-')
title('Cities configuration and the optimal path');

figure(3);
plot(Temp,length)
xlabel('Temperature');
ylabel('Total length');



