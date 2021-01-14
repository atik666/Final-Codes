clear;clc;

Fs= 12000; %Sampling frequency
rpm=1797;        %rotor speed in rpm
speed=rpm/60;      %speed in Hz
data_cycle=3*Fs/speed;         %number of data/cycle

%load 'D:\OneDrive - Universiti Malaysia Pahang\Atik_Home\Data Files\EEMD-Huang-master\EEMD-Huang-master\base.mat';

load 'base.mat';

sample_duration=length(X097_DE_time)/Fs; 
%L=length(X097_DE_time)/floor(data_cycle);
L = 90;

signal = X097_DE_time(1:1200);
 
y = signal;       % load a signal.
num_IMF = 6;                      % numbers of IMF
NR = 10;                      % value of ensemble
Nstd = 0.2;                   % param to white noise
 
[modes] = eemd(y, num_IMF, NR, Nstd);


%% Extracting the original signal
for i = 1:size(modes, 1)
    original_sig(i,1) = sum(modes(i, 1:end));
end
%% Comparing the obtained signal with original signal
figure(1)
plot (original_sig);
figure(2)
plot(signal);