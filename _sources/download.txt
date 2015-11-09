.. diffusionkit documentation master file, created by
   sphinx-quickstart on Mon Oct 26 10:48:55 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

========
Download
========

Download Links
==============

.. |winlogo| image:: images/winlogo.jpg
.. |rellogo| image:: images/rellogo.jpg

|winlogo| `Windows Installer (x86-64) 
<http://www.brainnetome.org/dmri/DiffusionKitSetup_WIN64-v1.1.0.exe>`_

|winlogo| `Windows Installer (x86) 
<http://www.brainnetome.org/dmri/DiffusionKitSetup_WIN32-v1.1.0.exe>`_

|rellogo| `Linux Binary Package (x86) 
<http://www.brainnetome.org/dmri/DiffusionKitSetup_Linux_x86-64-v1.1.0.tar.gz>`_

System requirement
==================

Basically this software can run in any system, including 32/64-bit MS Windows/Linux OS, although currently we only tested and released the binary packages for Windows/Linux OS. The software is developed based on C/C++, and some platform independent packages, including ITK, VTK, and OpenCV, etc. However, for high-performance data processing and visualization, we recommend using 64-bit OS with multi-core CPU and standalone video card.

Install/Uninstall
=================

Please download the package from http://brainnetome.org/dmri , according to your own OS. Unpack the files to where you want and you can enjoy the software. The 64-bit OS is recommended for high-performance data processing. Each installation package is completely standalone so you DO NOT need to install ANY other dependency to run the software. If you encounter any dependency problem please DO `contact us <mailto:diffusion.kit@nlpr.ia.ac.cn>`_.

For MS Windows OS
-----------------

Double click the ``DiffusionKitSetup-v1.1.exe`` file and then choose the destination path according to the wizard. You may need to provide administrator permission if you want to put the files into the system path. Similarly, to uninstall you only need to hit the menu of “uninstall” in the MS Windows start menu.

For Linux OS
------------

:code:`Glibc>=2.2` is required. Download the ``DiffusionKitSetup-v1.1.tar.gz``, and then

.. code-block:: bash

 tar zxvf DiffusionKitSetup-v1.1.tar.gz 
 cd diffusionkit/bin
 ./bnviewer # (you can run the command in this way)

If you do not want to type the full path every time, you could add the path to the $PATH. Edit the ~/.bashrc file, then add the following line,

.. code-block:: bash

 export $PATH=$PATH:/your/path/to/diffusionkit

To uninstall the software, just manually remove the entire folder where you untar-ed the .tar.gz file.

That’s it! Enjoy the software now!

.. include:: common.txt




