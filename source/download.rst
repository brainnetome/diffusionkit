.. diffusionkit documentation master file, created by
   sphinx-quickstart on Mon Oct 26 10:48:55 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

====================
Download and Install
====================

Download Links
==============

.. |winlogo| image:: images/winlogo.png
.. |rellogo| image:: images/rellogo.png
.. |linuxlogo| image:: images/linuxlogo.png

Latest Release (v1.3-r160923)
------------------------------

.. sidebar:: Previous Release

 See `Releases <https://github.com/brainnetome/diffusionkit/releases>`_ for our previously compiled packages.

.. toggle_table::
  :arg1: server in GitHub
  :arg2: server in China

.. toggle:: server in GitHub

  |winlogo| `Windows Installer (x86-64) 
  <https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160923/DiffusionKitSetup-WIN64-v1.3-r160923.exe>`_ [12.9 MB]

  |linuxlogo| `Linux Binary Package (x86-64) 
  <https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160923/DiffusionKitSetup-x86_64-v1.3-r160923.tar.gz>`_ [41.8 MB]

.. toggle:: server in China

  |winlogo| `Windows Installer (x86-64) 
  <http://ddl.escience.cn/ff/emKx?func=download>`_ [12.9 MB]

  |linuxlogo| `Linux Binary Package (x86-64) 
  <http://ddl.escience.cn/ff/emKy?func=download>`_ [41.8 MB]

Example Data and Test Script
----------------------------

.. toggle_table::
  :arg1: server in GitHub
  :arg2: server in China

.. toggle:: server in GitHub 

  * List File: `list.txt <https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160618/list.txt>`_ [12 Bytes]
  * Subject 01: `sub01.tar.gz <https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160618/sub01.tar.gz>`_ [87.1 MB]
  * Subject 02: `sub02.tar.gz <https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160618/sub02.tar.gz>`_ [85.5 MB]
  * Brain Atlas: `atlas.tar.gz <https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160618/atlas.tar.gz>`_ [1.57 MB]
  * Test Script [ `process_advanced.sh <https://raw.githubusercontent.com/brainnetome/diffusionkit/master/source/static/process_advanced.sh>`_ ] 
    [ `process_primary.sh <https://raw.githubusercontent.com/brainnetome/diffusionkit/master/source/static/process_primary.sh>`_ ] 

.. toggle:: server in China

  * List File: `list.txt <https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160618/list.txt>`_ [12 Bytes]
  * Subject 01: `sub01.tar.gz <http://ddl.escience.cn/ff/emBl?func=download>`_ [87.1 MB]
  * Subject 02: `sub02.tar.gz <http://ddl.escience.cn/ff/emBm?func=download>`_ [85.5 MB]
  * Brain Atlas: `atlas.tar.gz <http://ddl.escience.cn/ff/emBo?func=download>`_ [1.57 MB]
  * Test Script [ `process_advanced.sh <https://raw.githubusercontent.com/brainnetome/diffusionkit/master/source/static/process_advanced.sh>`_ ] 
    [ `process_primary.sh <https://raw.githubusercontent.com/brainnetome/diffusionkit/master/source/static/process_primary.sh>`_ ] 

And this is what we have in the data above::

 ├── atlas
 │   ├── aal.nii.gz
 │   ├── aal.nii.lut
 │   ├── aal.nii.txt
 │   ├── aal_roi_024.txt
 │   ├── aal_roi_090.txt
 │   ├── BN_Atlas_246_1mm.nii.gz
 │   ├── BN_Atlas_246.txt
 │   └── ch2bet.nii.gz
 ├── atlas.tar.gz
 ├── list.txt
 ├── process_advanced.sh
 ├── process_primary.sh
 ├── sub01
 │   ├── dwi.bval
 │   ├── dwi.bvec
 │   ├── dwi.nii.gz
 │   └── t1.nii.gz
 ├── sub01.tar.gz
 ├── sub02
 │   ├── dwi.bval
 │   ├── dwi.bvec
 │   ├── dwi.nii.gz
 │   └── t1.nii.gz
 └── sub02.tar.gz

We recommand users to follow the `Tutorial Page <tutorial_intro.html#getting-started>`_ for 
a step-by-step introduction of the functions within DiffutionKit.

IN A HURRY? Download all the data files (REQUIRED) above and run the Bash script `process_advanced.sh <https://raw.githubusercontent.com/brainnetome/diffusionkit/master/source/static/process_advanced.sh>`_  or `process_primary.sh <https://raw.githubusercontent.com/brainnetome/diffusionkit/master/source/static/process_primary.sh>`_. These two scripts have exactly the same functions, except that the primary one is for those who don't have too much background in Bash scripting and the advanced one is Makefile-based which avoids repeatly compiling the unchaged data in multiple compiles. Or simply run the following commands to do everything (for Linux ONLY).

.. toggle_table::
  :arg1: server in GitHub
  :arg2: server in China

.. toggle:: server in GitHub

  .. code-block:: bash
   
    # install DiffusionKit
    kitv='v1.3-r160618' ## This line should be changed according to the version you desired.
    kitname='DiffusionKitSetup-x86_64-'${kitv}
    wget https://github.com/brainnetome/diffusionkit/releases/download/${kitv}/${kitname}'.tar.gz'
    tar zxvf ${kitname}'.tar.gz'
    export PATH=$PATH:$(pwd)/${kitname}/bin
  
    # get the data and run!
    wget https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160618/list.txt
    wget https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160618/sub01.tar.gz
    wget https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160618/sub02.tar.gz
    wget https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160618/atlas.tar.gz
    wget https://raw.githubusercontent.com/brainnetome/diffusionkit/master/source/static/process_advanced.sh
    chmod +x process_advanced.sh
    ./process_advanced.sh	

.. toggle:: server in China

  .. code-block:: bash
   
    # install DiffusionKit 
    kitv='v1.3-r160923' ## CAUTION: This line should be changed according to the version.
    kitname='DiffusionKitSetup-x86_64-'${kitv}
    wget http://ddl.escience.cn/ff/emKy?func=download -O ${kitname}'.tar.gz'
    tar zxvf ${kitname}'.tar.gz'
    export PATH=$PATH:$(pwd)/${kitname}/bin
  
    # get the data and run!
    wget https://github.com/brainnetome/diffusionkit/releases/download/v1.3-r160618/list.txt
    wget http://ddl.escience.cn/ff/emBl?func=download -O sub01.tar.gz
    wget http://ddl.escience.cn/ff/emBm?func=download -O sub02.tar.gz
    wget http://ddl.escience.cn/ff/emBo?func=download -O atlas.tar.gz
    wget https://raw.githubusercontent.com/brainnetome/diffusionkit/master/source/static/process_advanced.sh
    chmod +x process_advanced.sh
    ./process_advanced.sh	

And more simpler way is to copy the code in the above panel (choose the server close to you) 
and save it as a file, such as `test-diffusionkit.sh <http://diffusion.brainnetome.org/en/latest/_static/test-diffusionkit.sh>`_, 
or `test-diffusionkit-china.sh <http://diffusion.brainnetome.org/en/latest/_static/test-diffusionkit-china.sh>`_.
and run to take a quick look how DiffusionKit can **BUILD A BRAIN NETWORK JUST A FEW MINUTES**!

System requirement
==================

Basically this software can run in any system, including 32/64-bit MS Windows/Linux OS, 
although currently we only tested and released the binary packages for Windows/Linux OS. 
The software is developed based on C/C++, and some platform independent packages, 
including VTK, and OpenCV, etc. 
However, for high-performance data processing and visualization, 
we recommend using 64-bit OS with multi-core CPU and standalone graphics card.

Install/Uninstall
=================

Please download the package from http://diffusion.brainnetome.org , 
according to your own OS. Unpack the files to where you want and you can enjoy the software. 
The 64-bit OS is recommended for high-performance data processing. 
Each installation package is completely standalone so you DO NOT need to 
install ANY other dependency to run the software. 
If you encounter any dependency problem please DO `contact us <mailto:diffusion.kit@nlpr.ia.ac.cn>`_.

For MS Windows OS
-----------------

Double click the ``DiffusionKitSetup-WIN64-v1.3-r160618.exe`` file and then choose the destination path 
according to the wizard. You may need to provide administrator permission 
if you want to put the files into the system path. 
Similarly, to uninstall you only need to hit the menu of “uninstall” in the MS Windows start menu.

For Linux OS
------------

:code:`Glibc>=2.2` is required. Download the ``DiffusionKitSetup-x86_64-v1.3-r160618.tar.gz``, and then

.. code-block:: bash

 tar zxvf DiffusionKitSetup-x86_64-v1.3-r160618.tar.gz
 export PATH=$PATH:`pwd`/DiffusionKitSetup-x86_64-v1.3-r160618/bin

You could add the path to the $PATH in the ~/.bashrc file, by adding the following line,

.. code-block:: bash

 export $PATH=$PATH:/your/path/to/diffusionkit

To uninstall the software, just manually remove the entire folder where you untar-ed the .tar.gz file.

The citation for DiffusionKit could be:

..

 Sangma Xie, Liangfu Chen, Nianming Zuo and Tianzi Jiang, **DiffusionKit: A Light One-Stop Solution for Diffusion MRI Data Analysis**, *Journal of Neuroscience Methods*, vol. 273, pp. 107-119, 2016. `[PDF] <https://raw.githubusercontent.com/brainnetome/diffusionkit/master/source/static/Xie_et_al_JNEUMETH_2016.pdf>`_  Currently available by http://authors.elsevier.com/a/1TeofbXTOhrs8.


.. include:: common.txt




