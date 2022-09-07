clear all;
clc;

% Initialize sites
N = 100;
Nit = 10000000;
Fs = rand(1,100);
previousposition=1;
distances=zeros(1,N-1);

% Counter
tic

% Plot Fs
figure(1)
plot(Fs)


% Transitionary period
for j=1:Nit
    [val,position]=min(Fs);
    Fs(position)=rand;
    if position>1
        Fs(position-1)=rand;
    elseif position<N
        Fs(position+1)=rand;
    end
end


previousposition=position


% Simulation 
for j=1:Nit
    [val,position]=min(Fs);
    
    d = abs(previousposition-position);
    previousposition = position;
    Fs(position)=rand;
    if position>1
        Fs(position-1)=rand;
    elseif position<N
        Fs(position+1)=rand;
    end
    
    if d>0
        distances(d)=distances(d)+1;
        
    end
    
end

% End couter
toc

figure(2)
loglog(1:N-1,distances)
xlabel('distances between sites with Fs minimum')
ylabel('number of occurences of some distance')

figure(3)
plot(Fs)