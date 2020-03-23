import numpy as np
import hdbscan

X=np.genfromtxt('TempHDBSCANfile.txt')
Y=np.genfromtxt('TempHDBSCANparameters.txt')
MinClusterSize=int(Y[0])
MinSamples=int(Y[1])

clusterer = hdbscan.HDBSCAN(min_cluster_size=MinClusterSize,min_samples=MinSamples,
                            cluster_selection_method='eom',approx_min_span_tree=False,core_dist_n_jobs=1).fit(X)
                                                        
np.savetxt('HDBSCANoutputsFirst/Labels.txt',clusterer.labels_, fmt='%d',comments='')
np.savetxt('HDBSCANoutputsFirst/Persistence.txt',clusterer.cluster_persistence_,comments='')
np.savetxt('HDBSCANoutputsFirst/Probabilities.txt',clusterer.probabilities_,comments='')  