% y = xlsread('some.data');       % load a signal.
% num_IMF = 5;                      % numbers of IMF
% NR = 100;                      % value of ensemble
% Namp = 0.3;                   % param to white noise
% NampMax = 0.2                 % highest range of amp
% NampMin = 0.1                 % lowest range of amp


function [modes,residual] = ceemd(y, num_IMF, NR, NampMax, NampMin)
stdy = std(y);
if stdy < 0.01
    stdy = 1;
end
y = y ./ stdy;
siz = length(y);
modes = zeros(siz,num_IMF);
for k = 1:NR
    disp(['Ensemble number #' num2str(k)]);
    
    Namp = (NampMax-NampMin).*rand(1,1) + NampMin; % Generating random amp of white noise
    
    x = randn(1,siz); 
    x = x - mean(x); % genrating 0 mean and 1 std
    x = x -std(x);
    
    wn{k} = (x.*Namp);
   
    y1 = y + wn{k};
    y2 = y - wn{k};
    modes = modes + emd(y1,'MaxNumIMF',num_IMF);
    if Namp > 0 && NR > 1
        modes = modes + emd(y2,'MaxNumIMF',num_IMF);  
    end
end
modes = modes .* stdy ./ (NR);
if Namp > 0 && NR > 1
    modes = modes ./ 2;
end
residual =  y - sum(modes,2); % Residue of signal
end