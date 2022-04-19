function [times,spikes] = homogeneousPoissonSpikeTrainGenerator(dt, fr, duration, nTrials)

% A Poisson process is defined by: (here, N(t) is the number of events that have occurred 
% by time 't').
%
% 1) N(0)=0 - no spikes at 0 time
% 2) stationary - constant firing rate
% 3) independent - no history dependence for current time step 
% 4) Prob{N(h)=1} = lamba*h + prob(more than one spike in time window h)
% probability of more than one spike in time window h is extremely small
% for a typical spiking window of ~ 1 ms


%%

if (nargin < 4)
    nTrials = 1;
end

if fr*dt > 1
    error('probablity of spiking is greater than 1 at any given time step. lower dt or fr.')
end


times = 0:dt:duration;

p_spike = rand(nTrials,numel(times));

spikes = (fr*dt) > p_spike;

spikes = spikes';

end % homogeneousSpikeTrainGenerator









