function [hdbscanCluster,noise]=hdbscanAnalysis_OnSelected(Points,MinClusterSizeHDBSCAN,MinSamplesHDBSCAN,hdbscanProbabilityThreshold)
    if exist('HDBSCANoutputsFirst','dir')==7 %It is used to make hdbscanCluster in hdbscanPostProcess function
        rmdir HDBSCANoutputsFirst s
    end
    mkdir HDBSCANoutputsFirst
    writematrix(Points,'TempHDBSCANfile.txt','Delimiter','tab') 
    writematrix([MinClusterSizeHDBSCAN;MinSamplesHDBSCAN],'TempHDBSCANparameters.txt')

    !C:\Users\marquislab\AppData\Local\Programs\Python\Python38-32\python.exe hdbscanImanThird.py
    
    delete 'TempHDBSCANparameters.txt'
    delete 'TempHDBSCANfile.txt'
    [hdbscanCluster,noise]=hdbscanPostProcess_OnSelected(Points,hdbscanProbabilityThreshold);

    rmdir HDBSCANoutputsFirst s
end