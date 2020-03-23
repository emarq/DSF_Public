====================================
How to cite:
====================================

====================================
Before starting:
====================================
(1) The methods and code are described in Ghamarian, Yu & Marquis, Morphological classification of dense objects in atom probe tomography data, Ultramicroscopy, 2020. 

(2) The current version of the DSF code is not the finalized one. The current version of the code cannot determine the crystallographic plane of dislocation loops.
The complete version of the code will be provided by April 2020.

(3) We tested the code for volumes containing up to 250000 atoms of interest, on Ubuntu 18.4 and Windows 10 operating systems. 


====================================
INSTALLATION of Python and required packages :
====================================
-------
For MAC:
-------
(1) Install python: to run the code in MATLAB, we need to install python because some parts of the calculations are done in python.
This link "https://docs.python-guide.org/starting/install/osx/" provides python 3.7.
(2) You must install the HDBSCAN package and its dependencies. 

To install a package (for instance, BeautifulSoup package version 3.2.0), use the command:
python -m pip install BeautifulSoup==3.2.0

You should see the following lines on your screen.
Collecting BeautifulSoup==3.2.0
  Downloading https://files.pythonhosted.org/packages/33/fe/15326560884f20d792d3ffc7fe8f639aab88647c9d46509a240d9bfbb6b1/BeautifulSoup-3.2.0.tar.gz
Building wheels for collected packages: BeautifulSoup
  Running setup.py bdist_wheel for BeautifulSoup ... done
  Stored in directory: /Users/ghamaria/Library/Caches/pip/wheels/09/f5/19/ba8e673d27909fd79928eccfbe8c1fdee0683d3b553870f6d1
Successfully built BeautifulSoup
Installing collected packages: BeautifulSoup
Successfully installed BeautifulSoup-3.2.0

The command "pip list" will show the installed packages. 

On how to install a specific version of a package, follow: This link (https://docs.python.org/2.7/installing/index.html).

-------
For PC 
-------
(1) Install python: to run the code in MATLAB, we need to install python because some parts of the calculations are done in python.
Please install python 3.7 from this link "https://www.python.org/downloads/release/python-2714/"
(2) Click on the Windows Start button and type CMD. Then go to the python directory using cd command.

(3) I got the list of installed python packages by executing the following commands in CMD.
import pip
installed_packages = pip.get_installed_distributions()
installed_packages_list = sorted(["%s==%s" % (i.key, i.version)
     for i in installed_packages])
print(installed_packages_list)

Install HDBSCAN package and its dependencies.

You can install packages with their specific version by using the commands mentioned here "https://docs.python.org/2.7/installing/index.html"
For instance, we can simply install package "BeautifulSoup" version 3.2.0 by running the following command.
C:\Python27>python -m pip install BeautifulSoup==3.2.0
Collecting BeautifulSoup==3.2.0
  Downloading https://files.pythonhosted.org/packages/33/fe/15326560884f20d792d3
ffc7fe8f639aab88647c9d46509a240d9bfbb6b1/BeautifulSoup-3.2.0.tar.gz
Building wheels for collected packages: BeautifulSoup
  Running setup.py bdist_wheel for BeautifulSoup ... done
  Stored in directory: C:\Users\Iman\AppData\Local\pip\Cache\wheels\09\f5\19\ba8
e673d27909fd79928eccfbe8c1fdee0683d3b553870f6d1
Successfully built BeautifulSoup
Installing collected packages: BeautifulSoup
  Found existing installation: BeautifulSoup 3.2.1
    Uninstalling BeautifulSoup-3.2.1:
      Successfully uninstalled BeautifulSoup-3.2.1
Successfully installed BeautifulSoup-3.2.0

This link (https://docs.python.org/2.7/installing/index.html) can help you learn how to install a specific version of a package.

====================================
DSF analysis:
====================================
The cluster analysis code is provided in the "DSF_code" folder. 

Remember to use "/" for a path in MAC and "\" for a path in PC
							
hdbscanAnalysis.m and debaclAnalysis.m files must be updated before running the code:				
-------
In MAC:
-------							
- update the following line in hdbscanAnalysis.m file based on your installation path
    !/usr/local/bin/python2.7 hdbscanImanSecond.py
- update the following line in debaclAnalysis.m based on your installation path
    !/usr/local/bin/python2.7 debaclImanSecond.py	
-------
In PC:
-------							
- update the following line in hdbscanAnalysis.m file based on your installation path
	!C:\Python27\python.exe hdbscanImanSecond.py
- update the following line in debaclAnalysis.m based on your installation path
    !C:\Python27\python.exe debaclImanSecond.py	
	
To run the code: (You must use MATLAB 2019b or later versions)

(1) open MATLAB and change its current directory to DSF_code
(2) put your pose file in the DSF_code directory
(3) open DSF4.mlapp and run it.


Please note that the hdbscanImanSecond.py file is also different between the MAC and PC versions.
In PC:
clusterer = hdbscan.HDBSCAN(min_cluster_size=MinClusterSize,min_samples=MinSamples,
          cluster_selection_method='eom',approx_min_span_tree=False,core_dist_n_jobs=1).fit(X)

In MAC:
clusterer = hdbscan.HDBSCAN(min_cluster_size=MinClusterSize,min_samples=MinSamples,
                            cluster_selection_method='eom',approx_min_span_tree=False).fit(X)
