#!/usr/bin/env bash

# Copyright (C) 2012-2016 Brainnetome Center at CASIA
# Written by Liangfu Chen <liangfu.chen@nlpr.ia.ac.cn>
#            Sangma Xie   <smxie@nlpr.ia.ac.cn>

if [ ! -d atlas ]; then 
  if [ -f atlas.tar.gz  ]; then tar zxvf atlas.tar.gz
	else echo 'atlas.tar.gz file is required to bulid brain network'; exit 1; fi
fi

for file in `cat list.txt`; do
  # extract data to subject folder
  if [ ! -f $file/dwi.nii.gz ] || [ ! -f $file/t1.nii.gz ]; then tar zxvf $file.tar.gz; cd $file; else cd $file; fi

  # generate roi file to subject folder
  if [ ! -f aal.nii.gz ]; then cp ../atlas/aal.nii.gz . ; fi
  if [ ! -f aal.nii.txt ]; then cp ../atlas/aal.nii.txt . ; fi
  if [ ! -f aal_roi_024.txt ]; then cp ../atlas/aal_roi_024.txt . ; fi
  if [ ! -f aal_roi_090.txt ]; then cp ../atlas/aal_roi_090.txt . ; fi
  if [ ! -f ch2bet.nii.gz ]; then cp ../atlas/ch2bet.nii.gz . ; fi

  echo "
network.txt: dti_wb.trk roi
	bnnetwork -fiber dti_wb.trk -roi aal_roi_024.txt -outfiber 0 -o network -omp 2

roi: aal_r.nii.gz
	bnroisplit -i aal_r.nii.gz -o ./ -l aal.nii.txt
.PHONY: roi

brain.nii.gz: t1.nii.gz
	bet2 t1.nii.gz brain -f 0.3

aal_r.nii.gz: b0.nii.gz dti.nii.gz brain.nii.gz
	reg_aladin -ref dti_FA.nii.gz -flo brain.nii.gz -res brain_diff.nii.gz
	reg_aladin -ref brain_diff.nii.gz -flo ch2bet.nii.gz -res stand_diff -aff stand_diff_affine.txt
	reg_f3d -ref brain_diff.nii.gz -flo ch2bet.nii.gz -res stand_diff_warp.nii.gz -aff stand_diff_affine.txt -fmask ch2bet.nii.gz -cpp outputCPP.nii 
	reg_resample -ref brain_diff.nii.gz -flo aal.nii.gz -res aal_r.nii.gz -trans outputCPP.nii -inter 0

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

