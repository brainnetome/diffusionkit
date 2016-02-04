.. diffusionkit documentation master file, created by
   sphinx-quickstart on Mon Oct 26 10:48:55 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

===
FAQ
===

1. Why images and fibers are not properly aligned?
--------------------------------------------------

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


.. include:: common.txt


