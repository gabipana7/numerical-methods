clear all;
clc;

% Initialize sites
N = 100;
Nit = 1000000;
Fs = rand(N,N);
distances=zeros(1,2*N);


% Counter
tic


% Transitionary period
for j=1:Nit
    [val,position]=min(Fs);
    [v,p]=min(val);
    xmin=position(p);
    ymin=(p);
    
    Fs(xmin,ymin)=rand;
    
    
    if xmin>1
        Fs(xmin-1,ymin)=rand;
    end
    
    if xmin<N
         Fs(xmin+1,ymin)=rand;
    end
    
    if ymin>1
        Fs(xmin,ymin-1)=rand;
    end
    
    if ymin<N
         Fs(xmin,ymin+1)=rand;
    end
              
end

% Initialize previos positions
xminp = xmin;
yminp = ymin;


% Actual simulation
for j=1:Nit
    [val,position]=min(Fs);
    [v,p]=min(val);
    xmin=position(p);
    ymin=(p);
    
    Fs(xmin,ymin)=rand;
    
    
    if xmin>1
        Fs(xmin-1,ymin)=rand;
    end
    
    if xmin<N
         Fs(xmin+1,ymin)=rand;
    end
    
    if ymin>1
        Fs(xmin,ymin-1)=rand;
    end
    
    if ymin<N
         Fs(xmin,ymin+1)=rand;
    end
    
    d(j) = sqrt((xmin-xminp)^2+(ymin-yminp)^2);
    
    % new previous positions
    xminp = xmin;
    yminp = ymin;
end

% Stop counter
toc

figure(1)
plot(d)

figure(2)
[~,edges] = histcounts(log10(d));
histogram(d,10.^edges)
set(gca, 'xscale','log')
xlabel('distance between sites with minimum Fs')
ylabel('number of appearances of this distance')

figure(3)
loglog(d)
set(gca,'Xdir','reverse')
ylabel('distance between sites with minimum Fs')
xlabel('number of appearances of this distance')