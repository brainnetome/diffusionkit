for file in `cat list.txt`
do
    cd $file
    #### First Step: Eddy correct the original DWI data. ####
    bneddy -i dwi.nii.gz -o eddy -ref 0

    #### Next: We'd better to rotate B-matrix according to the eddy correct log file. For more details, please refer to *** ####
    echo $file
    bn_rotate_bvec -i bvecs -log eddy.txt -o rotated_bvecs 

    #### Next: Get b0 image for brain mask using the command of bncalc ####
    bncalc -i eddy.nii.gz -roi_rect 0 -o b0

    #### Next: Get brain mask using the command of bet2 ####
    bet2 b0.nii.gz nodif_brain
    bet2 T1.nii.gz brain -f 0.3

    #### Next: We can achieve DTI related indices using the command bndti_estimate ####
    #### Next: We can achieve diffusion/fiber ODF using the command bnhardi_ODF_estimate/bnhardi_FOD_estimate ####
    bndti_estimate -d eddy.nii.gz -b bvals -g rotated_bvecs -m nodif_brain_mask.nii.gz -o dti -tensor 1 -eig 1
    bnhardi_ODF_estimate -d eddy.nii.gz -b bvals -g rotated_bvecs -m nodif_brain_mask.nii.gz -o spfi -lambda_sh 1e-8 -lambda_ra 1e-8
    bnhardi_FOD_estimate -d eddy.nii.gz -b bvals -g rotated_bvecs -m nodif_brain_mask.nii.gz -o csd


    #### Next: Whole brain fibertracking
    # To perform whole brain fibertracking, we select the voxels with an FA value greater than 0.2 as seeds.
    bncalc -i dti_FA.nii.gz -dthr 0.3 -o seeds
    bncalc -i seeds -bin 0 -o seeds

    # Perform whole brain fibertracking with tensor or diffusion/fiber ODF.
    bndti_tracking -d dti.nii.gz -m nodif_brain_mask.nii.gz -s seeds.nii.gz -fa dti_FA.nii.gz -o dti_wb.trk
    bnhardi_tracking -d spfi_EAP_profile.nii.gz -fa dti_FA.nii.gz -m nodif_brain_mask.nii.gz -s seeds.nii.gz -omp 1 -o spfi_wb.trk
    bnhardi_tracking -d csd.nii.gz -fa dti_FA.nii.gz -m nodif_brain_mask.nii.gz -s seeds.nii.gz -omp 1 -o csd_wb.trk

    #### Next: Constrcut brain networks
    #### warp AAL atlas into the individual diffusion space using reg_aladin and reg_f3d
    reg_aladin -ref dti_FA.nii.gz -flo brain.nii.gz -res brain_diff.nii.gz
    reg_aladin -ref brain_diff.nii.gz -flo ../ch2bet.nii.gz -res stand_diff -aff stand_diff_affine.txt -maxit 10 -ln 5
    reg_f3d -ref brain_diff.nii.gz -flo ../ch2bet.nii.gz -res stand_diff_warp.nii.gz -aff stand_diff_affine.txt -maxit 1000 -ln 5 -vel -fmask ../ch2bet.nii.gz -cpp
    reg_resample -ref brain_diff.nii.gz -flo ../aal.nii.gz -res aal_diff.nii.gz -trans outputCPP.nii -inter 0
    #### Split ROI
    i=1
    for roi in `cat ../roi.txt`
    do
        echo $roi
        echo $i
        bncalc  -i aal_diff.nii.gz -dthr $i -uthr $i -o $roi
        i=$(($i+1));
    done
    #### Construct brain network
    bnnetwork -fiber dti_wb.trk -roi ../roi.txt -outfiber 1 -o network 
    cd ..
done
