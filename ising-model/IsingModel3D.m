clear all;
clc;

% Initialize  3D lattice
N=5;
S(N+2,N+2,N+2)=0;
J=1;

% Steps
Ntr = 100;
Nsteps = 1000;


% Initialize lattice spins
for i=2:N+1
    for j=2:N+1
        for k=2:N+1
            temp=rand;
            if temp>1/2
                S(i,j,k)=1;
            else
                S(i,j,k)=-1;
            end
        end
    end
end

S;

% Choose temperature range 
Ti = 15;
dT = 0.1;
Tf = 0.1;

% Start timer
tic 
counter=1;
T(counter)=Ti;
M(counter)=sum(sum(sum(S)));

while T>Tf
    
    mag=0;
    
    % Transitory period
    for k=1:Ntr
        x = round(2+(N-1)*rand);
        y = round(2+(N-1)*rand);
        z = round(2+(N-1)*rand);
        
        DE = 4*J*S(x,y,z)*(S(x-1,y,z)+S(x,y-1,z)+S(x+1,y,z)+S(x,y+1,z)+S(x,y,z-1)+S(x,y,z+1));
        P = exp ( -DE/T(counter));
        
        if P>rand
            S(x,y,z)=-S(x,y,z);
        end
        
    end
    
     % Actual iteration for Magnetization copmputing
    for k=1:Nsteps
        for j=1:N^3
            
            % Choose random site
            x = round(2+(N-1)*rand);
            y = round(2+(N-1)*rand);
            z = round(2+(N-1)*rand);
            
            % Calculate Energy Difference DE
            DE = 4*J*S(x,y,z)*(S(x-1,y,z)+S(x,y-1,z)+S(x+1,y,z)+S(x,y+1,z)+S(x,y,z-1)+S(x,y,z+1));
            % Probability to flip
            P = exp ( -DE/T(counter));
            
            % Choose random number and flip or not flip 
            if P>rand
                S(x,y,z)=-S(x,y,z);
            end
        end
        
        mag = mag + S;
        
    end
    
    counter = counter+1;
    T(counter) = T(counter-1) - dT;
    M(counter) = sum(sum(sum(mag(2:N+1, 2:N+1, 2:N+1))))/Nsteps;
end

S;

% End timer
toc

figure(1);
plot(T,M)
xlabel('temperature')
ylabel('magnetization')
    

