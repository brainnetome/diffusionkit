.. diffusionkit documentation master file, created by
   sphinx-quickstart on Mon Oct 26 10:48:55 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. meta::
   :description: Tutorial on Diffusion Kit

.. toctree::
   :maxdepth: 3

Generate a ROI file from a given ROI list
=========================================

If you want to generate a roi.nii.gz file in the space of a reference :code:`ref.nii.gz`, 
with a given list of ROI coordinates and according weight value, 
where the radii are unified by the input radius :code:`r`, 
you can call the :code:`bncalc` function in-loop as the 
file `gen_ROI_from_list.sh </_static/gen_ROI_from_list.sh>`_. The content is as following:

.. code-block:: bash

  #!/bin/bash
  # This is to call the bncalc function to create a .nii.gz mask image
  # from a list of ROI centers and radii
  # Jan 7, 2016, by NMZUO
  
  # The list.txt has the format as:
  #  x     y     z    weightValue  # this could be used for color; set 1 by default
  #  -2    38    36   3.6
  #  65   -31    -9   -2.7
  #  12    36    20   4
  #  ......
  
  Usage(){
      echo ""
      echo "This is to call the bncalc function to create"
      echo "a .nii.gz mask image from a list of ROI centers."
      echo "Usage:"
      echo "bash gen_ROI_from_list.sh list.txt r  ref.nii.gz  outmask.nii.gz"
      echo -e "      list.txt\t\t The input list containing ROI coordinates (MNI mm)"
      echo -e "      r\t\t\t   The radius (mm) of each ROI"
      echo -e "      ref.nii.gz\t The reference image where the ROIs stay"
      echo -e "      outmask.nii.gz\t The output .nii.gz image"
  }
  
  if [ $# -lt 3 ]; then
      Usage
      exit 1
  fi
  
  tmpfile=$$"_tmp_"
  
  iCount=0
  while read line; do
      roi=($line)
      idx=`printf "%06d" $iCount`
      bncalc -i $3 -roi ${roi[0]},${roi[1]},${roi[2]},$2  -o ${tmpfile}${idx}.nii.gz
      if [ ${#roi[@]} -gt 3 ]; then
          bncalc -i ${tmpfile}${idx}.nii.gz  -mul ${roi[3]} -o ${tmpfile}${idx}.nii.gz
      fi
      iCount=$((iCount+1))
  done < $1
  
  cp ${tmpfile}"000000".nii.gz  $4
  for i in `seq 1 $(($iCount-1))`
  do
      echo -e "$i \c"
      idx=`printf "%06d" $i`
      if [ ${#roi[@]} -lt 4 ]; then
          bncalc -i ${tmpfile}${idx}.nii.gz -mul $(($i+1)) -o ${tmpfile}${idx}.nii.gz 
      fi
      bncalc -i  $4  -add ${tmpfile}${idx}.nii.gz -o $4
  done
  echo "Done!"
  rm -f ${tmpfile}??????.nii.gz
  
  
