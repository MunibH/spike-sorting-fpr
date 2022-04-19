function [times,spikes] = inhomogeneousPoissonSpikeTrainGenerator(dt, fr, duration, nTrials)

% A Poisson process is defined by: (here, N(t) is the number of events that have occurred 
% by time 't').
%
% 1) N(0)=0 - no spikes at 0 time
% 2) nonstationary - firing rate is a function of time (r(t))
% 3) independent - no history dependence for current time step 
% 4) Prob{N(h)=1} = lamba*h + prob(more than one spike in time window h)
% probability of more than one spike in time window h is extremely small
% for a typical spiking window of ~ 1 ms
% 5) r(t) must be nearly constant over each interval of length dt.


%%

if (nargin < 4)
    nTrials = 1;
end


times = 0:dt:duration;

assert(numel(fr)==numel(times),'Must specify firing rate for each point in time')

p_spike = rand(nTrials,numel(times));

fr_dt = repmat(fr*dt,nTrials,1);

spikes = (fr_dt) > p_spike;

spikes = spikes';

end % inhomogeneousSpikeTrainGenerator









