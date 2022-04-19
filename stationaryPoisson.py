import quantities as pq
from elephant import spike_train_generation as spkgen
import matplotlib.pyplot as plt
import numpy as np

# Stationary Poisson Process

rate = 50
tStart = 0
tStop = 1000

nTrials = 10

refractoryPeriod = 2.5

spiketrain = spkgen.StationaryPoissonProcess(rate=rate*pq.Hz, t_start=tStart*pq.ms,
t_stop=tStop*pq.ms, refractory_period=refractoryPeriod*pq.ms).generate_n_spiketrains(nTrials,True)

spktm = dict()
isi = dict()
for i in range(len(spiketrain)):
    spktm[i] = spiketrain[i]
    isi[i] = np.diff(spktm[i])
    
    plt.scatter(spktm[i], np.ones(spktm[i].size) * (i+1))
    
plt.show()

isi_cat = list(isi.values())
isi_cat = np.hstack(isi_cat)

plt.hist(isi_cat,bins=30)
plt.axvline(x=2.5,c='r')
plt.show()