.. diffusionkit documentation master file, created by
   sphinx-quickstart on Mon Oct 26 10:48:55 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. meta::
   :description: Tutorial on Diffusion Kit

.. toctree::
   :maxdepth: 3

Map ROIs defined in one space to another individual space
=========================================

This is an example to map the ROI definitions (in the initial space, e.g. MNI 2mm space)  to an individual space.
Fox example, the source folder could be:

.. code-block:: bash

  nmzuo@:dp_classify$ tree
  .
  ├── bet_reg.sh
  ├── bet_reg_sub2std.sh
  ├── copy_data_from_231.sh
  ├── DP
  │   ├── DP_0001
  │   ├── DP_0002
  ......

where the fold for each subject could be:

.. code-block:: bash

  nmzuo@:DP_0001$ tree
  .
  ├── dwi
  │   ├── bval
  │   ├── bvec
  │   ├── bvec_rotated
  │   ├── DP_0001_dwi_eddy_b0.nii.gz
  │   ├── DP_0001_dwi_eddy.nii.gz
  │   ├── DP_0001_dwi_mask.nii.gz
  │   ├── DP_0001_dwi.nii.gz
  │   ├── dti_FA.nii.gz
  │   ├── dti_L1.nii.gz
  │   ├── dti_L2.nii.gz
  │   ├── dti_L3.nii.gz
  │   ├── dti_MD.nii.gz
  │   ├── dti.nii.gz
  │   ├── dti_RA.nii.gz
  │   ├── dti_V1.nii.gz
  │   ├── dti_V2.nii.gz
  │   └── dti_V3.nii.gz
  └── t1
      ├── DP_0001_t1_brain_mask.nii.gz
      ├── DP_0001_t1_brain.nii.gz
      └── DP_0001_t1.nii.gz

and `list_dp.txt` is the name list of the subjects as (the column other than the first one is the possible comment for the subject):

.. code-block:: bash

  ccm@:dp_classify$ cat list_dp.txt 
  DP_0001
  DP_0002 #no cerebellum
  ......

Then the following `bash code` is able to map the ROI in the standard space 
to the subject space (for each subject in `list_dp.txt`). Certainly the initial
ROI does not require to be in the standard space in this code.

.. code-block:: bash

  atlas='/datc/software/Brainnetome_Atlas/BN_Atlas_246_2mm.nii.gz' # Brainnetome Atlas in MNI space
  mni='/datc/software/fsl5.0/data/standard/MNI152_T1_2mm_brain.nii.gz'
  
  for dat in `cat list_dp.txt |awk '{print $1}' ` #only read the first column
  do
      echo $dat
      cpath='/datd/dp_classify'
      cpath=$cpath/${dat%%_*}/$dat/
      oldp=`pwd`
      cd $cpath
      echo 'aladin'
      reg_aladin -ref  t1/$dat'_t1_brain.nii.gz'   -flo $mni  -aff aff.txt -voff
      echo 'f3d'
      reg_f3d -ref t1/$dat'_t1_brain.nii.gz'    -flo $mni  -aff aff.txt -cpp cpp.nii.gz -maxit 3 -ln 2  -voff
      rm -f aff.txt
      echo 'aladin'
      reg_aladin -ref dwi/$dat'_dwi_eddy_b0.nii.gz'  -flo t1/$dat'_t1_brain.nii.gz'   -aff aff0.txt   -voff
  
      reg_resample -ref t1/$dat'_t1_brain.nii.gz'  -flo $atlas  -trans cpp.nii.gz -inter 0 -res jhu_t1.nii.gz  -voff
      reg_resample -ref dwi/$dat'_dwi_eddy_b0.nii.gz'  -flo jhu_t1.nii.gz -trans aff0.txt -inter 0 -res jhu_b0.nii.gz -voff
      rm -f aff0.txt cpp.nii.gz  outputResult.nii jhu_t1.nii.gz
      mv jhu_b0.nii.gz dwi/atlas_b0.nii.gz
      cd $oldp
  done
  


