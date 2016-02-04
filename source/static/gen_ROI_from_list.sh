#!/bin/bash
# This is to call the bncalc function to create a .nii.gz mask image
# from a list of ROI centers and radii
# Jan 7, 2016, by NMZUO

# The list.txt has the format as:
#  -2    38    36
#  65   -31    -9
#  12    36    20
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
    iCount=$((iCount+1))
done < $1

cp ${tmpfile}"000000".nii.gz  $4
for i in `seq 1 $(($iCount-1))`
do
    echo -e "$i \c"
    idx=`printf "%06d" $i`
    bncalc -i ${tmpfile}${idx}.nii.gz -mul $(($i+1)) -o ${tmpfile}${idx}.nii.gz 
    bncalc -i  $4  -add ${tmpfile}${idx}.nii.gz -o $4
done
echo "Done!"


