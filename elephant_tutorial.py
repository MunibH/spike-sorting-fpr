import quantities as pq
from elephant import spike_train_generation as spkgen

spiketrain = spkgen.StationaryPoissonProcess(rate=50.*pq.Hz, t_start=0*pq.ms,
t_stop=1000*pq.ms).generate_spiketrain()