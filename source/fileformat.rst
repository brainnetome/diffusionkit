.. diffusionkit documentation master file, created by
   sphinx-quickstart on Mon Oct 26 10:48:55 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. meta::
   :description: File Formats in DiffusionKit

.. toctree::
   :maxdepth: 3

.. _Data Format:

-----------
Data Format
-----------

Input
-----

Since we apply the dcm2nii to unify the format of input data, 
it can support most types of DICOM files (in folders). 
Please refer to the author’s webpage for more information `[4] <reference.html#id4>`_. 
Please also get back to us if you encounter any problems.

Output
------

All the intermediate files are in compressed NIFTI format (.nii.gz). The final track file is in .fiber/.fbr or .trk format, where the former is a short version of the later one. The .trk format is from the TrackVis `[17] <reference.html#id17>`_. 

The .fiber format is as following ::

 Brainnetome fiber tracking
 Version 1
 Number_Fiber 235
 Mean_Length(mm) 150
 Volume_Total(mm^3)  37020
 Mean_FA  0.6
 Mean_MD  0.07
 80 101.378 0.5 0.1
 110.758 148.574 124.982 0.166754 0.3
 111.253 148.68 123.688 0.198468 0.25

The first and second line indicates who produces the file and the version of the file format, and line 3 to line 7 characterize several main attributes of this fiber bundle. From line 8, fiber-wise node descriptions are presented; for example, for one fiber on line 8, [80 101.378 0.5 0.1] corresponds to the total number of nodes, length, mean FA and mean MD of this fiber. Starting from line 9, properties of each node of the fiber are described, e.g., [110.758 148.574 124.982 0.166754 0.3] denote x-, y- and z-coordinate, FA and MD of this node.

.. 
 .. [4] http://www.mccauslandcenter.sc.edu/mricro
 .. [17] http://trackvis.org

.. include:: common.txt


