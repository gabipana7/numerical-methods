clear all;
clc;

% Initialize sites
N = 50;
Nit = 1000000;
D = zeros(N+2,N+2); 
redistributions(1:100*N^2) = zeros(1,100*N^2);

% Counter start time
tic 



% Transitory period
for j=1:Nit
    % Fist, choose a random desk where you place a document
    xpos = round(2+rand*(N-1));
    ypos = round(2+rand*(N-1));
    D(xpos,ypos) = D(xpos,ypos) + 1;
    counter = 1;
    
    % Check if it exceeds threshold ( Th=4)
    if D(xpos,ypos) > 3
        % Eliminate 4 documents from this position
        D(xpos,ypos) = D(xpos,ypos) -4;
        
        % And redistribute them to the neighbours ( left, right, front and
        % back)
        D(xpos-1,ypos) = D(xpos-1,ypos) +1;
        D(xpos+1,ypos) = D(xpos+1,ypos) +1;
        D(xpos,ypos-1) = D(xpos,ypos-1) +1;
        D(xpos,ypos+1) = D(xpos,ypos+1) +1;
        counter=2;
    end
    
    
    % Check for avalanches
    binary=1;
    
    while binary==1
        binary=0;
        
        for i=2:N+1
            for k=2:N+1
                
                % Check if there are 4 documents on this desk
                if D(i,k)>3
                    % eliminate 4 documents
                    D(i,k) = D(i,k) - 4;
                    
                    % and distribute them to the neighbours
                    D(i-1,k) = D(i-1,k) + 1;
                    D(i+1,k) = D(i+1,k) + 1;
                    D(i,k-1) = D(i,k-1) + 1;
                    D(i,k+1) = D(i,k+1) + 1;
                    
                    % Binary stays 1, look for avalanches further
                    binary = 1;
                    % Add to counter, because avalanche happened
                    counter = counter +1;
                end
            end
        end
    end
end 



% Actual simulation
for j=1:Nit
    
    counter=0;
    
    % Fist, choose a random desk where you place a document
    xpos = round(2+rand*(N-1));
    ypos = round(2+rand*(N-1));
    D(xpos,ypos) = D(xpos,ypos) + 1;
    counter = 1;
    
    % Check if it exceeds threshold ( Th=4)
    if D(xpos,ypos) > 3
        % Eliminate 4 documents from this position
        D(xpos,ypos) = D(xpos,ypos) - 4;
        
        % And redistribute them to the neighbours ( left, right, front and
        % back)
        D(xpos-1,ypos) = D(xpos-1,ypos) +1;
        D(xpos+1,ypos) = D(xpos+1,ypos) +1;
        D(xpos,ypos-1) = D(xpos,ypos-1) +1;
        D(xpos,ypos+1) = D(xpos,ypos+1) +1;
        counter=2;
    end
    
    % Check for avalanches
    binary=1;
    
    while binary==1
        binary=0;
        
        % Iterate through the desks, without the border(windows)
        for i=2:N+1
            for k=2:N+1
                
                % Check if there are 4 documents on this desk
                if D(i,k)>3
                    % eliminate 4 documents
                    D(i,k) = D(i,k) - 4;
                    
                    % and distribute them to the neighbours
                    D(i-1,k) = D(i-1,k) + 1;
                    D(i+1,k) = D(i+1,k) + 1;
                    D(i,k-1) = D(i,k-1) + 1;
                    D(i,k+1) = D(i,k+1) + 1;
                    
                    % Binary stays 1, look for avalanches further
                    binary = 1;
                    % Add to counter, because avalanche happened
                    counter = counter +1;
                end
            end
        end
    end
    % If avalanches happened, add one to the avalanche counter of the
    % respective size
    if counter > 0
        redistributions(counter) = redistributions(counter) + 1;
    end    
end 


% End time counter
toc

% Plot
figure(1)
loglog(1:100*N^2,redistributions);
xlabel('number of redistributions - desks visited')
ylabel('number of visits')

