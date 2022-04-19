import neo
import quantities as pq
from elephant import spike_train_generation as spkgen
import matplotlib.pyplot as plt
import numpy as np

# nonstationary Poisson Process

rate = 50 # instantaneous rate, Hz
tStart = 0 # s
tStop = 1 # s
samplingRate = 1000 # Hz

times = np.arange(tStart,tStop,1/samplingRate)
rates = 50.*(np.exp(times));
rates = 100*((times-tStop/2)**2) + 2;

rates = neo.AnalogSignal(
      np.array(rates).reshape(-1,1) * pq.Hz,
      t_start=tStart * pq.s, sampling_rate=samplingRate * pq.Hz)

nTrials = 10

refractoryPeriod = 0.0025

spiketrain = spkgen.NonStationaryPoissonProcess(rates, refractoryPeriod*pq.s).generate_n_spiketrains(nTrials,True)

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
plt.axvline(x=0.0025,c='r')
plt.show()