.. diffusionkit documentation master file, created by
   sphinx-quickstart on Mon Oct 26 10:48:55 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

====
FAQs
====

1. Where can I download example data?
-------------------------------------

We provide a group of test data to test the software, and the data 
was also used in `[11] <reference.html#id11>`_ .

2. Why images and fibers are not properly aligned in my case?
-------------------------------------------------------------

This typically happens when nifti image headers are modified
before generating fiber.

In DiffusionKit, a command named :code:`bninfo` is provided to print out the header information
inside a NIfTI image. To check whether an NIfTI data is canonical::

 $ bninfo data.nii.gz

you would get::

 ...
 qform_i_orientation = 'Left-to-Right'
 qform_j_orientation = 'Posterior-to-Anterior'
 qform_k_orientation = 'Inferior-to-Superior'
 ...

This indicate that you are lucky. And the matrix that transforms voxels coordinates (I/J/K) to
physical locations (X/Y/Z) is orthogonal. However, it doesn't matter if this isn't true, 
the image can be converted with :code:`bnconvert`. With :code:`--reorient` argument, it
transforms the input image into orthogonal one with head information modified as well. ::

 $ bnconvert data_brain.nii.gz data_brain_r.nii.gz -r

.. warning::

 However, there would be problems if :code:`bnconvert` converts a 4D vector image, 
 e.g. tensor data, ODF/FOD data etc.

Usually, the reorient step should be taken when DICOM image is converted to NIFTI image, with
argument :code:`-r y`.

For more information, we recommand reading FSL's
`Orientation Explained <http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Orientation%20Explained>`_
and 
`Docs on qform and sform <http://nifti.nimh.nih.gov/nifti-1/documentation/nifti1fields/nifti1fields_pages/qsform.html>`_ to get a good understanding of orientation layout within NIfTI data format.

3. How to extract the gradient table if the dcm2nii/MRIcron fails?
------------------------------------------------------------------

The dcm2nii/MRIcron is useful to extract the gradient table for the DWI data. 
However, occasionally it fails to get the gradient table although it 
indeed get the NIFTI data from the DICOM images. 
Herein we provide a temporal solution by calling the Matlab/dicominfo 
which depends on a specified keyword dictionary.  

.. code-block:: matlab

  function findGrad(dcmfile)
  % This script is special to locate the individual grad directions
  % for each DICOM file, if the dicom2nii tool failed to extract them.
  % by NMZUO, Sept. 12, 2014
  
  % Change the following if still fails
  %prestr = 'DiffusionGradientOrientation';
  prestr = 'DiffusionGradient';
  
  myhdr = dicominfo(dcmfile);
  myfind = fieldnamesr(myhdr, prestr);
  iLen = length(myfind);
  iCount = 0;
  
  for i=1:iLen
     mystr = myfind{i};
     if strfind(mystr, prestr)
         iCount = iCount + 1;
         disp(['Field containing ' prestr ': ' num2str(iCount) ]);
         disp(mystr);
				 
         % to extract the grad directions
         eval(strcat('myhdr.', mystr))
     end
  end
  end

Please download the two files fieldnamesr.m and findGrad.m. 
The first one is to generate the full string of the keyword dictionary 
and second is to find the locations. If your problem remains unsolved, 
please `send us <diffusion.kit@nlpr.ia.ac.cn>`_ your data 
(only one 2D/3D DICOM image is enough) and then we will update our DICOM dictionary. 

.. include:: common.txt


