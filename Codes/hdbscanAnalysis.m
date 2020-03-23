%HDBSCAN python is called in this function
function hdbscanCluster=hdbscanAnalysis(DatasetName,MinClusterSizeHDBSCAN,MinSamplesHDBSCAN,Interest)
if exist('HDBSCANoutputsFirst','dir')==7 %It is used to make hdbscanCluster in hdbscanPostProcess function
    rmdir HDBSCANoutputsFirst s
end
mkdir HDBSCANoutputsFirst
copyfile(DatasetName, 'TempHDBSCANfile.txt')

fid1 = fopen('TempHDBSCANparameters.txt','wt');
fprintf(fid1, '%d\n', MinClusterSizeHDBSCAN);
fprintf(fid1, '%d', MinSamplesHDBSCAN);
fclose(fid1);

!C:\Users\marquislab\AppData\Local\Programs\Python\Python38-32\python.exe hdbscanImanThird.py

delete 'TempHDBSCANparameters.txt'
delete 'TempHDBSCANfile.txt'
hdbscanCluster=hdbscanPostProcess(Interest);

    
end