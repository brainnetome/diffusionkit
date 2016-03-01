.. diffusionkit documentation master file, created by
   sphinx-quickstart on Mon Oct 26 10:48:55 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. meta::
   :description: Tutorial on Diffusion Kit

.. toctree::
   :maxdepth: 3

Getting Started
===============

Preprocessing
-------------

Data Format Conversion
~~~~~~~~~~~~~~~~~~~~~~

Analyze format and Nifti format are the data formats that supported 
by DiffusionKit. If your image data is in DICOM format, you 
need to convert the data into Nifti format.

To convert DICOM format to Nifti format, please check the checkbox 
“DICOM to NIfTI” in the main window and input the data directory 
that contains DICOM files.

GUI-Frontend Usage

.. figure:: images/tut1_fig1.png
  :width: 360px
  :align: center

  Figure 1. Convert data format.

Command-Line Usage:

.. code-block:: bash

 $ dcm2nii -o /path/sub01 -f DTI /path/sub01/DTI

Eddy Current Correction
~~~~~~~~~~~~~~~~~~~~~~~

DiffusionKit has motion correction function which is implemented 
with a affine registration method. To correct the effect of 
head motion, please check the checkbox "Eddy Current Correction"
and import the original diffusion-weighted imaging data. 

GUI-Frontend Usage

.. figure:: images/tut1_fig2.png
  :width: 360px
  :align: center

  Figure 2. Eddy current correction.

Command-Line Usage:

.. code-block:: bash

 $ bneddy -i /path/sub01/DTI.nii.gz -o /path/sub01/DTI_eddy.nii.gz -ref 0

Skull Stripping
~~~~~~~~~~~~~~~

The next step is removal of extra-meningeal tissues from the 
MRI image of the whole head. The function of Skull Stripping 
is to delete non-brain tissues from an image of the whole head.
An accurate brain mask will accelerate the following reconstruction.

To achieve the mask of brain, please check the checkbox “Skull 
Stripping” and input the image (e.g. the b0 image) you want to operate.

GUI-Frontend Usage:

.. figure:: images/tut1_fig3.png
  :width: 360px
  :align: center

  Figure 3. Skull stripping.

Command-Line Usage:

.. code-block:: bash

 $ bet2 /path/sub01/DTI_eddy.nii.gz /path/sub01/DTI_eddy_brain.nii.gz -m /path/sub01/DTI_eddy_mask.nii.gz -f 0.5

Diffusion Model Estimation
--------------------------

DTI Estimation
~~~~~~~~~~~~~~

When we complete the preprocessing, we can do the job of DTI 
estimation. In this step, you can get diffusion tensor image 
and derived diffusion indexes (e.g. fractional anisotropy, mean 
diffusivity, radial anisotropy etc.) from the reconstruction.
For GUI-frontend, please change to the “Reconstruction” label 
and make sure the “Output Type” is DTI. Input the files into 
the boxes in the “Reconstruction” Panel according to the illustrations 
in Figure 4. 

GUI-Frontend Usage:

.. figure:: images/tut1_fig4.png
  :width: 360px
  :align: center

  Figure 4. DTI estimation.

Command-Line Usage:

.. code-block:: bash

 $ bndti_estimate -d /path/sub01/DTI_eddy.nii.gz -g /path/sub01/DTI.bvec -b /path/sub01/DTI.bval -m /path/sub01/DTI_eddy_mask.nii.gz -o /path/sub01/DTI_eddy_dti -tensor 1 -eig 1

HARDI Estimation (Optional)
~~~~~~~~~~~~~~~~~~~~~~~~~~~

DiffusionKit also includes advanced HARDI reconstructions which 
implemented with two types of HARDI methods, the Spherical 
Polar Fourier Imaging (SPFI) method and Constrained Spherical 
Deconvolution (CSD) methods. If you have DWI data with considerable 
number of gradient directions (more than 45 directions) and 
high b-value (larger than 2000) [ref], you can apply HARDI 
estimation to resolve crossing fibers in the reconstruction.
To call the HARDI reconstruction, change the “Output Type” to 
HARDI and select the HARDI method (SPFI or CSD) you want in 
the “Reconstruct Parameters” section. The compulsory parameters 
for HARDI estimation is data input and output. The example 
of parameters setting is illustrated in Figure 5&6.

GUI-Frontend Usage:

.. figure:: images/tut1_fig5.png
  :width: 360px
  :align: center

  Figure 5. HARDI estimation using SPFI method.

.. figure:: images/tut1_fig6.png
  :width: 360px
  :align: center

  Figure 6. HARDI estimation using CSD method.

Command-Line Usage:

.. code-block:: bash

 $ bnhardi_ODF_estimate -d /path/sub01/DTI_eddy.nii.gz -g /path/sub01/DTI.bvec -b /path/sub01/DTI.bval -m /path/sub01/DTI_eddy_mask.nii.gz -o /path/sub01/DTI_eddy_spfi
 $ bnhardi_FOD_estimate -d /path/sub01/DTI_eddy.nii.gz -g /path/sub01/DTI.bvec -b /path/sub01/DTI.bval -m /path/sub01/DTI_eddy_mask.nii.gz -o /path/sub01/DTI_eddy_fod

Tractography
------------

DiffusionKit provides the function of fibertracking which is 
implemented with a deterministic streamline method. You can 
perform tractography using the diffusion tensors reconstructed 
with DTI or diffusion/fiber ODFs reconstructed with SPFI/CSD.
To call the function of fibertracking, change the “Processing” 
Panel to “Tractography”. Select the data type (DTI or HARDI)
according to the data you used (tensor or diffusion/fiber ODF). 
Input the FA map acquired in DTI estimation to the box of “FA”. 
Provide the seeds image based on your research. For instance,
if you want to do whole brain fibertracking, you can input 
a whole brain mask in the box of “Seeds”. You can adjust other 
tracking parameters to satisfy your study. Please refer to 
the illustration in Figure 7&8 for more details.

GUI-Frontend Usage

.. figure:: images/tut1_fig7.png
  :width: 360px
  :align: center

  Figure 7. Fibe tracking based on DTI.

.. figure:: images/tut1_fig8.png
  :width: 360px
  :align: center

  Figure 8. Fiber tracking based on HARDI.

Command-Line Usage

.. code-block:: bash

 $ bndti_tracking -d /path/sub01/DTI_eddy_dti.nii.gz -m /path/sub01/DTI_eddy_mask.nii.gz -s /path/sub01/DTI_eddy_mask.nii.gz -fa /path/sub01/DTI_eddy_dti_FA.nii.gz -o /path/sub01/DTI_wb.trk
 $ bnhardi_tracking -d /path/sub01/DTI_eddy_dti.nii.gz -m /path/sub01/DTI_eddy_mask.nii.gz -s /path/sub01/DTI_eddy_mask.nii.gz -fa /path/sub01/DTI_eddy_dti_FA.nii.gz -o /path/sub01/DTI_wb.trk

Construction of brain networks
------------------------------

When we get connectivity data from tractography, we can consider 
construction of brain networks. A network is a collection of 
nodes and links (edges) between pairs of nodes. In structural 
brain networks, we select specific ROIs of brain as nodes and 
the number of fibers which end in the pair of ROIs or other 
derived diffusion indices as edges. DiffusionKit provides the 
function of bn_network to construct brain network using given 
ROIs and whole brain tractography achieved from last step. Only 
command-line usage is available for bn_network. A text file 
which contains the paths and ROI filenames is needed to input 
when performing bn_network. Please refer to the example script 
and example data for details.

Command-Line Usage

.. code-block:: bash

 $ bn_network -fiber /path/sub01/DTI_wb.trk -roi /path/sub01/roi.txt -outfiber 1 -o /path/sub01/network.txt


.. include:: common.txt





