% elephant spike trains 
% find docs, rewrite code in matlab to learn
% https://elephant.readthedocs.io/en/latest/reference/spike_train_generation.html

% https://www.cns.nyu.edu/~david/handouts/poisson.pdf

% stationary poisson process
rate  = 20;                    % firing rate (Hz)
start = 0;                    % intital time point (s)
stop  = 10;                   % final time point (s)
refractory_period = 0.0025;   % refractory period (s)

% ensure no violations for a single unit
if rate * refractory_period >= 1
    error('Time b/w successive spikes must be larger than refractory period. Decrease firing rate or refractory period')
end

nExpectedSpikes = ceil( (stop-start) * rate );


% firing rate given refractory period
effective_rate = rate / (1 - rate * refractory_period);

% isi distribution
x = start:0.01:stop;
loc = refractory_period;
scale = 1 / effective_rate;
y = (x-loc) ./ scale;
isi_generator = exppdf(y) ./ scale;


