
clear,clc,close all

%% generate spikes from a stationary poisson process

dt = 0.001;
firingRate = 50; % spikes per sec
duration = 1;    % num seconds to simulate
nTrials = 10;


[dat.times,dat.spikes] = homogeneousPoissonSpikeTrainGenerator(dt, firingRate, duration, nTrials);

rasterPlot(dat.times,dat.spikes);

%isi

dat.spiketimes = cell(nTrials,1);
dat.isi = cell(nTrials,1);
for trix = 1:nTrials
    dat.spiketimes{trix} = dat.times(dat.spikes(:,trix));
    dat.isi{trix} = diff([dat.spiketimes{trix} inf]);
end


isi = [dat.isi{:}];

figure;             
nBins = round(numel(unique(isi))/3);
histogram(isi,nBins);
hold on;
xline(0.0025,'r--')


%% generate spikes from a nonstationary poisson process

dt = 0.001;
duration = 1;    % num seconds to simulate
nTrials = 10;
time = 0:dt:duration;
% firingRate = 50.*(exp(time)); % spikes per sec, r(t) ~ exp(t) for demonstration purposes
% in actuality, to generate spikes with this method, r(t) should be nearly
% constant at each dt.
firingRate = 100.*((time-duration/2).^2) + 2;

[dat.times,dat.spikes] = inhomogeneousPoissonSpikeTrainGenerator(dt, firingRate, duration, nTrials);

rasterPlot(dat.times,dat.spikes);

dat.spiketimes = cell(nTrials,1);
dat.isi = cell(nTrials,1);
for trix = 1:nTrials
    dat.spiketimes{trix} = dat.times(dat.spikes(:,trix));
    dat.isi{trix} = diff([dat.spiketimes{trix} inf]);
end


isi = [dat.isi{:}];

figure;             
nBins = round(numel(unique(isi))/3);
histogram(isi,nBins);
hold on;
xline(0.0025,'r--')

















