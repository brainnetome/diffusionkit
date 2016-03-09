#!/usr/bin/env bash

if [ ! -d atlas ]; then 
  if [ -f atlas.tar.gz  ]; then tar zxvf atlas.tar.gz
	else echo 'atlas.tar.gz file is required to bulid brain network'; exit 1; fi
fi

for file in `cat list.txt`; do
  # extract data to subject folder
  if [ -d $file/dwi.nii.gz ]; then cd $file; else tar zxvf $file.tar.gz; cd $file; fi

  # generate roi file to subject folder
  cp ../atlas/aal.nii.gz .
  cp ../atlas/aal.txt .
  cp ../atlas/roi.txt .
  cp ../atlas/mni152_FA.nii.gz .

  echo "
network.txt: dti_wb.trk roi
	bnnetwork -fiber dti_wb.trk -roi roi.txt -outfiber 0 -o network

roi: aal_r.nii.gz
	bnroisplit -i aal_r.nii.gz -o ./ -l aal.txt
	touch roi

aal_r.nii.gz: b0.nii.gz
	reg_aladin -ref dti_FA.nii.gz -flo mni152_FA.nii.gz -res mni152_FA_r.nii.gz -aff affine.txt
	reg_f3d -ref dti_FA.nii.gz -flo mni152_FA_r.nii.gz -res mni152_FA_r.nii.gz -aff affine.txt
	reg_resample -ref dti_FA.nii.gz -flo aal.nii.gz -res aal_r.nii.gz -aff affine.txt -inter 0
	cp aal.txt aal_r.txt
	#	bnviewer -volume b0.nii.gz -atlas aal_r.nii.gz # to visualize atlas (experimental)

eddy.nii.gz: dwi.nii.gz
	bneddy -i dwi.nii.gz -o eddy -ref 0

rotated_bvecs: eddy.nii.gz
	bnrotate_bvec -i dwi.bvec -log eddy.txt -o rotated_bvecs 

b0.nii.gz: eddy.nii.gz
	bncalc -i eddy.nii.gz -roi_rect 0 -o b0

nodif_brain_mask.nii.gz: b0.nii.gz
	bet2 b0.nii.gz nodif_brain -m nodif_brain_mask.nii.gz

seeds.nii.gz: dti.nii.gz
	bncalc -i dti_FA.nii.gz -dthr 0.3 -o seeds
	bncalc -i seeds -bin 0 -o seeds

dti.nii.gz: eddy.nii.gz rotated_bvecs nodif_brain_mask.nii.gz
	bndti_estimate -d eddy.nii.gz -b dwi.bval -g rotated_bvecs -m nodif_brain_mask.nii.gz -o dti -tensor 1 -eig 1

dti_wb.trk: dti.nii.gz nodif_brain_mask.nii.gz seeds.nii.gz 
	bndti_tracking -d dti.nii.gz -m nodif_brain_mask.nii.gz -s seeds.nii.gz -fa dti_FA.nii.gz -o dti_wb.trk
" > Makefile
	make -j2
  cd ..
done

