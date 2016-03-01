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
  
Basic source for Bash (B-shell) and Python
------------------------------------------

If you want to use script for batch processing, we strongly recommend using Python, 
since it has nice grammar style and is portable for cross platform. 

The Python is easy to learn for basic use as a script language, 
although its powerful functions largely depend on 3rd party packages. To this 
end, we have several suggestions to begin with it. First, take a couple of hours 
to go through the primary Python grammars. There is a large bundle of free 
but kind tutorials from internet (Google “Python tutorial” or related keywords). 
You can choose the websites according to your preference. If you are a newbie of 
Python, don’t think about which version is appropriate for you and just use 
the latest version (Python>3.0) (In the current stage, you only need to note 
the difference of “print” function in different versions, which I think is not 
a smart change from version 3.0); and don’t waste money to buy a book since 
the materials from the internet are largely beyond your capacity. Several 
tutorial links are listed here:

For English users

1. https://en.wikibooks.org/wiki/A_Beginner%27s_Python_Tutorial, a short tutorial
2. http://askpython.com/, a short tutorial
3. http://www.learnpython.org/, an interactive sandbox

For Chinese users

1. http://www.runoob.com/python3/python3-tutorial.html, a nice tutorial
2. http://www.cnblogs.com/vamei/archive/2012/09/13/2682778.html, python and advanced
3. http://woodpecker.org.cn/abyteofpython_cn/chinese/, a complete reference

If you prefer to use shell script, like Bash, you can also find some 
entrances for tutorials. The shell script itself is easy to follow and it is 
a powerful tool to concatenate the underlying execution functions. It should be 
noted that the Bash script is only for * NUX system, so it is not 
suitable form cross-platforms. Several tutorial links are listed here:

For English users

1. http://linuxconfig.org/bash-scripting-tutorial, a short introduction
2. http://www.tldp.org/LDP/abs/html/, a complete tutorial
3. http://www.learnshell.org/, an interactive sandbox

For Chinese users

1. http://blog.jobbole.com/85183/, a short tutorial
2. https://serholiu.com/bash-by-example, several simple examples
3. http://c.biancheng.net/cpp/view/6998.html, a complete tutorial

  
