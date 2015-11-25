.. diffusionkit documentation master file, created by
   sphinx-quickstart on Mon Oct 26 10:48:55 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. meta::
   :description: Tutorial on Diffusion Kit

.. toctree::
   :maxdepth: 3

-----------------------------------------
GUI Fornt-end of Data Processing Pipeline
-----------------------------------------

Preprocessing
=============

DICOM to NIFTI Conversion
-------------------------

Eddy Current Correction
-----------------------

.. _Skull_Stripping:

Skull Stripping
---------------

FSL's `BET (Brain Extraction Tool) <http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/BET>`_ is
integrated as part of the program, so that one can verify automatic skull stripping result 
by visualizing overlaying mask image upon original image.
See :ref:`Volume_Image_Overlay` on how to generate overlaid background images.

A threshold value that indicate 'fractional intensity' is exposed on the GUI,
so that one can adjust the threshold to get smaller/larger brain outline estimates.
Details on the implement can be found at 
`BET's UserGuide <http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/BET/UserGuide>`_.


Reconstruct
===========

Starting from this section, we provide three different approaches for diffusion MR data processing:

.. toggle_table::
  :arg1: DTI
  :arg2: SPFI
  :arg3: CSD

Click one of the options above to see guidelines on using the specific method for data processing.
				 
.. toggle:: DTI

 this is for dti

.. toggle:: SPFI

 this is for spfi

.. toggle:: CSD

 this is for csd


Fiber Tracking
==============


.. include:: common.txt
