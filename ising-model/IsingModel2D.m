clear all;
clc;

% Initialize lattice
N=7;
S(N+2,N+2)=0;
J=1;

% Steps
Ntr = 10;
Nsteps = 100;


% Initialize lattice spins
for i=2:N+1
    for j=2:N+1
        temp=rand;
        if temp>1/2
            S(i,j)=1;
        else
            S(i,j)=-1;
        end
    end
end

S

% Impose periodic boundary conditions
S(1,:) = S(N+1,:);
S(N+2,:) = S(2,:);
S(:,1) = S(:,N+1);
S(:,N+2)= S(:,2);

S

% Choose temperature range
Ti = 7;
dT = 0.1;
Tf = 0.1;

% Start timer
tic 
counter=1;
T(counter)=Ti;
M(counter)=sum(sum(S));

while T>Tf
    
    mag=0;
    
    % Transitory period
    for k=1:Ntr
        x = round(2+(N-1)*rand);
        y = round(2+(N-1)*rand);
        
        DE = 4*J*S(x,y)*(S(x-1,y)+S(x,y-1)+S(x+1,y)+S(x,y+1));
        P = exp ( -DE/T(counter));
        
        if P>rand
            S(x,y)=-S(x,y);
        end
        
        S(1,:) = S(N+1,:);
        S(N+2,:) = S(2,:);
        S(:,1) = S(:,N+1);
        S(:,N+2)= S(:,2);
    end
    
     % Actual iteration for Magnetization copmputing
    for k=1:Nsteps
        for j=1:N^2
            
            x = round(2+(N-1)*rand);
            y = round(2+(N-1)*rand);

            DE = 4*J*S(x,y)*(S(x-1,y)+S(x,y-1)+S(x+1,y)+S(x,y+1));
            P = exp ( -DE/T(counter));

            if P>rand
                S(x,y)=-S(x,y);
            end

            S(1,:) = S(N+1,:);
            S(N+2,:) = S(2,:);
            S(:,1) = S(:,N+1);
            S(:,N+2)= S(:,2);
        end
        
        mag = mag + S;
        
    end
    
    counter = counter+1;
    T(counter) = T(counter-1) - dT;
    M(counter) = sum(sum(mag(2:N+1, 2:N+1)))/Nsteps;
end

S

% End timer
toc

figure(1);
plot(T,M)
xlabel('temperature')
ylabel('magnetization')
    
