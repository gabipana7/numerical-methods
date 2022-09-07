clear all;
clc;

% Initialize lattice
N=7;
S(N+2,N+2)=0;
J=1;

% Steps
nflips = 1000;


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


% Choose temperature range
Ti = 10;
dT = 0.5;
Tf = 0.1;

% Start timer
tic 

T = Ti;
counter=1;

while T>Tf
    
    
    U(counter)=0;
    Energies(counter,:)= -4*N*N:1:4*N*N;
    fEnergies(counter,:) = 0*(-4*N*N:1:4*N*N);

    % Number of succesful spin flips at a given Temperature
    spinflips(counter) = 0;
    
    for i=1:nflips
        
        % Select a random spin
        x = round(2+(N-1)*rand);
        y = round(2+(N-1)*rand);
    
        Ei = Energy(S,N,J); % energy of the system with the unflipped spin 

        Scopy = S;
        Scopy(x,y) = - Scopy(x,y); % copy of the system with that flipped spin

        Ef = Energy(Scopy,N,J); % energy of the system with the flipped spin 

        DE=Ef-Ei; % Difference in energy betweeen the system with unflipped spin
                    % and system with flipped spin
                
        % probability to flip the sip exp(-DE/T)
        if exp(-DE/T)>rand
            S(x,y)=-S(x,y); % the actual flip spin 
            spinflips(counter)=spinflips(counter)+1; % we increase by 1 the number of flipped spins 
            U(counter)=U(counter)+Ef; % we add to the variable which is used to compute the average
                                      % energy the energy of the system after the flip; the actual average
                                      % energy will be obtained by dividing U to ssp - the number of succesful 
                                      % flipped spin s

            pos = find(Energies(counter,:)==Ef); % we find the energy Ef in the array of possible energies
            fEnergies(counter,pos)=fEnergies(counter,pos)+1; % we increse by 1 the frequency counter for that energy
        end
    end

    
    Temperature(counter) = T;
    T=T-dT;

    U(counter) = U(counter)/spinflips(counter);

    counter=counter+1;
end

S

% End timer
toc

% Figures
figure(1)
for j=1:counter-1
    plot(Energies(j,:),fEnergies(j,:)/sum(fEnergies(j,:)));
    xlabel('Energy - E')
    title(['Temperature=',num2str(Temperature(j))])
    pause(0.3)
end

figure(2)
plot(Temperature,U/(N*N))
xlabel('Temperature')
ylabel('Average Energy')

figure(3)
plot(Temperature,spinflips)
xlabel('Temperature')
ylabel('# of succesful spin flips')



function f=Energy(S,N,J)
    f=0;
    for j = 2:N+1
        for k = 2:N+1
            f=f-J*S(j,k)*(S(j-1,k)+S(j+1,k)+S(j,k-1)+S(j,k+1));
        end
    end
end

% Conclusions 

% At every Temperature the only accepted flips are those that minimize
% energy

% At high Temperature, the probability to accept spin flips is very high,
% almost all 1

% T lowers => the distribution of energy states that the Monte-Carlo
% simulations checks is narrower

% T lowers => the number of acceptes spin flips is smaller and smaller
% because it is not energetically favorable to change them anymore




