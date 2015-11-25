.. diffusionkit documentation master file, created by
   sphinx-quickstart on Mon Oct 26 10:48:55 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

--------
Overivew
--------

.. meta::
   :description: Overivew of Brainnetome Diffusion Kit


.. toctree::
   :maxdepth: 3

Brainnetome Diffusion Kit is a light one-stop cross-platform solution to dMRI data analysis. The package delivers a complete pipeline from data format conversion to preprocessing, from local reconstruction to fiber tracking, and from fiber statistics to visualization. Diffusion Kit was developed as a cross-platform framework, using ITK [1]_ for computation, VTK [2]_ for visualization, and Qt for GUI design. Both GPU and CPU computing were implemented for visualization to achieve high frame-rate, for rendering complex scene like whole brain tractographs in particular. The project was managed using the compiler-independent CMake [3]_, which is compatible with gcc/g++ and MS Visual Studio, etc. Well-established algorithms, such as the DICOM conversion tool dcm2nii by Chris Rorden [4]_ and the constrained spherical deconvolution (CSD) for HARDI reconstruction in MRtrix [5]_, were adopted with improved interface and user experience.

Key functions of the software
=============================

.. figure:: images/overall.png
   :width: 800 px
   :alt: The overall design framework of Diffusion Kit
   :align: center

   Figure 1. The overall design framework of Diffusion Kit

.. figure:: images/mainwindow.png
   :width: 800 px
   :alt: The main window of the software
   :align: center

   Figure 2. The main window of the software.

It should be noteworthy that, for all the computing steps provided in GUI, the called commands with the complete parameter list are displayed in a separate log window. Such a design is special for the users to keep in mind what he/she is doing, and furthermore, it could be directly copied into script (Bash, Python …) for batch processing.


.. include:: common.txt

.. [1] http://www.itk.org
.. [2] http://www.vtk.org
.. [3] http://www.cmake.org
.. [4] http://www.mccauslandcenter.sc.edu/mricro
.. [5] http://www.nitrc.org/projects/mrtrix
