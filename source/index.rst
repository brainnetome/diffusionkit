.. diffusionkit documentation master file, created by
   sphinx-quickstart on Mon Oct 26 10:48:55 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

..
	 Welcome to DiffusionKit's documentation!
	 ========================================

	 Table of Contents
	 =================

Homepage
========

Welcome to Brainnetome DiffusionKit's Homepage
----------------------------------------------

|banner|

.. note:: 
 * a full pipeline for (pre-)processing and visualization for diffusion MRI data.
 * cross-platform support and a small installation size without 3rd party dependency.
 * utilize a graphical interface along with command-line programs that enables easy operation and batch processing.

Brainnetome DiffusionKit is a light one-stop cross-platform solution to dMRI data analysis. 
The package delivers a complete pipeline from data format conversion to preprocessing, 
from local reconstruction to fiber tracking, and from fiber statistics to visualization.

It was developed as a cross-platform framework, 
using VTK `[2] <reference.html#id2>`_ for visualization, and Qt for GUI design. 
Both GPU and CPU computing were implemented for visualization to achieve high frame-rate, 
for rendering complex scene like whole brain tractographs in particular. 
The project was managed using the compiler-independent CMake `[3] <reference.html#id3>`_, 
which is compatible with gcc/g++ and MS Visual Studio, etc. 
Well-established algorithms, such as the DICOM conversion tool dcm2nii by 
Chris Rorden `[4] <reference.html#id4>`_ and the constrained spherical deconvolution (CSD) for 
HARDI reconstruction in MRtrix `[5] <reference.html#id5>`_, 
were adopted with improved interface and user experience.

* Visit `Manual <document.html>`_ page for a complete list of usage instructions.
* Visit `Tutorial <tutorials.html>`_ page to take a look at how DiffusionKit can solve your practical problems.
* Visit `Screenshot <screenshot.html>`_ page to see how the GUI front-end looks like.
* Visit `Support <feedback.html>`_ page to submit comments, or email us at diffusion.kit@nlpr.ia.ac.cn .

*Please see the navigation sidebar to the left to begin.*

The citation of DiffusionKit could be:

* Sangma Xie, Liangfu Chen, Nianming Zuo and Tianzi Jiang, DiffusionKit: A Light One-Stop Solution for Diffusion MRI Data Analysis, *Journal of Neuroscience Methods*, 2016 (In press)

.. toctree::
   :maxdepth: 2
   :hidden:
   
   document.rst
   tutorials.rst
   screenshot.rst
   download.rst
   license.rst
   faq.rst
   feedback.rst

.. note:: Document last updated on |today|.

.. include:: common.txt

.. raw:: html

 <script type="text/javascript">
 $(window).load(function(){
 // $('.toctree-wrapper').hide();
 // $('.reference').css('font-size','10pt');
 // $('.fn-backref').css('font-size','10pt');
 $('h1').hide();
 // $('td').css('padding','2px');
 var elem = document.getElementsByClassName('admonition-title')[0];
 elem.innerHTML=' HIGHLIGHTS';
 });
 </script>
