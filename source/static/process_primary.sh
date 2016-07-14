#!/usr/bin/env bash
# This batch script is used to construct structural brain networks for a group of subjects using diffusion MRI data.
# The example data and files used in this script can be downloaded from http://diffusion.brainnetome.org/en/latest/download.html
# To run this script, you have to download the list file (list.txt), DWI data (Subject01 and Subject02) and atlas directory from the above link. 
# However, if you want to download only one subject data for saving time, you should delete one line of the list.txt file accordingly. 
# When you download all the files, you can get three compressed files (atlas.tar.gz, sub01.tar.gz and sub02.tar.gz) and a text file (list.txt) which
# contains subject ID. You'd better to make a directory (.e.g example) to run this tutorial script. And copy the three compressed files and list.txt
# into the example directory. The following steps should be done in the example directory. Uncompress the three conpressed file respectively. 
# Finally, your "example" should be as follows.
#path/example
#     ├── atlas
#     │   ├── aal.nii.gz
#     │   ├── aal.nii.lut
#     │   ├── aal.nii.txt
#     │   ├── aal_roi_024.txt
#     │   ├── aal_roi_090.txt
#     │   ├── BN_Atlas_246_1mm.nii.gz
#     │   ├── BN_Atlas_246.txt
#     │   └── ch2bet.nii.gz
#     ├── list.txt
#     ├── process_advanced.sh
#     ├── process_primary.sh
#     ├── sub01
#     │   ├── dwi.bval
#     │   ├── dwi.bvec
#     │   ├── dwi.nii.gz
#     │   └── t1.nii.gz
#     └── sub02
#         ├── dwi.bval
#         ├── dwi.bvec
#         ├── dwi.nii.gz
#         └── t1.nii.gz

# Now you can run this script in example directory.

# By Sangma Xie, Mar. 10, 2016 

for file in `cat list.txt`
do
    cd $file
    echo $file
    #### First Step: Eddy correct the original DWI data. 
    bneddy -i dwi.nii.gz -o eddy -ref 0

    #### Next: We'd better to rotate B-matrix according to the eddy correct log file. 
    bnrotate_bvec -i dwi.bvec -log eddy.txt -o rotated_bvecs 

    #### Next: Get b0 image for brain mask using the command of bncalc 
    bncalc -i eddy.nii.gz -roi_rect 0 -o b0

    #### Next: Get brain mask using the command of bet2 
    bet2 b0.nii.gz nodif_brain -m nodif_brain_mask.nii.gz
    bet2 t1.nii.gz brain -f 0.3

    #### Next: We can achieve DTI related indices using the command bndti_estimate
    bndti_estimate -d eddy.nii.gz -b dwi.bval -g rotated_bvecs -m nodif_brain_mask.nii.gz -o dti -tensor 1 -eig 1
    
    #### Next: We can achieve diffusion/fiber ODF using the command bnhardi_ODF_estimate/bnhardi_FOD_estimate (Optional) 
    #bnhardi_ODF_estimate -d eddy.nii.gz -b dwi.bval -g rotated_bvecs -m nodif_brain_mask.nii.gz -o spfi -lambda_sh 1e-8 -lambda_ra 1e-8
    #bnhardi_FOD_estimate -d eddy.nii.gz -b dwi.bval -g rotated_bvecs -m nodif_brain_mask.nii.gz -o csd


    #### Next: Whole brain fibertracking
    #### To perform whole brain fibertracking, we select the voxels with an FA value greater than 0.3 as seeds.
    bncalc -i dti_FA.nii.gz -dthr 0.3 -o seeds
    bncalc -i seeds -bin 0 -o seeds

    #### Perform whole brain fibertracking with tensor or diffusion/fiber ODF.
    bndti_tracking -d dti_tensor.nii.gz -m nodif_brain_mask.nii.gz -s seeds.nii.gz -fa dti_FA.nii.gz -o dti_wb.trk
    #### hardi_tracking is time consuming. It's not compulsory for constructing brain networks.
    #bnhardi_tracking -d spfi_EAP_profile.nii.gz -fa dti_FA.nii.gz -m nodif_brain_mask.nii.gz -s seeds.nii.gz -omp 1 -o spfi_wb.trk
    #bnhardi_tracking -d csd.nii.gz -fa dti_FA.nii.gz -m nodif_brain_mask.nii.gz -s seeds.nii.gz -omp 1 -o csd_wb.trk

    #### Next: Constrcut brain networks
    #### In the network construction, Node definition is the first step. In this example, we select ROIs in AAL atlas as node.
    #### Warp AAL atlas into the individual diffusion space using reg_aladin and reg_f3d
    #### 1: Register individual T1 image to individual diffusion space. If T1 image is not available in your dataset, you can skip this step. 
    reg_aladin -ref dti_FA.nii.gz -flo brain.nii.gz -res brain_diff.nii.gz
    #### 2: The coregistered T1 image is warped to the T1 tempalte (ch2bet.nii.gz) using reg_aladin and reg_f3d. If T1 image is not available in your
    ####    dataset, you can replace brain_diff.nii.gz  with nodif_brain.nii.gz in the following steps.
    reg_aladin -ref brain_diff.nii.gz -flo ../atlas/ch2bet.nii.gz -res stand_diff -aff stand_diff_affine.txt # -maxit 10 -ln 5
    reg_f3d -ref brain_diff.nii.gz -flo ../atlas/ch2bet.nii.gz -res stand_diff_warp.nii.gz -aff stand_diff_affine.txt -vel -fmask ../atlas/ch2bet.nii.gz -cpp # -maxit 1000 -ln 5 
    #### 3: Apply the transformation on the AAL atlas to warp the AAL template from MNI space to the DTI native space in which the discrete labeling values
    ####    were preserved by using a nearest neighbor interpolation method. 
    reg_resample -ref brain_diff.nii.gz -flo ../atlas/aal.nii.gz -res aal_diff.nii.gz -trans outputCPP.nii -inter 0
    #### Segment the cerebral cortex of each subject into 90 regions (45 for each hemisphere with the cerebellum excluded). In this step, you must use
    #### "aal_roi_090.txt" to get all the ROIs (cerebellum excluded).
    i=1
    for roi in `cat ../atlas/aal_roi_090.txt`
    do
        echo $roi
        echo $i
        bncalc  -i aal_diff.nii.gz -dthr $i -uthr $i -o $roi
        i=$(($i+1));
    done
    #### Construct brain network. Each region in roi text file represents a node of the network. Two AAL node regions i and j were considered to be connected
    #### if the reconstructed fiber bundles with two end points located in these two regions respectively were present. The number of the bundle connect two
    #### specfic regions is used as edge of the network. In addition, we output the mean FA and MD into the network text file for further analysis.
    #### The final networks are named as network_num.txt, network_fa.txt and network_md.txt.
    #### However, network construction is time consuming, we select 24 regions as node to construct a simple network. If you want to construct whole brain
    #### network you can replace all_roi_024.txt with aal_roi_090.txt to construct network with 90 nodes.
    bnnetwork -fiber dti_wb.trk -roi ../atlas/aal_roi_024.txt -outfiber 1 -o network 
    #bnnetwork -fiber dti_wb.trk -roi ../atlas/aal_roi_090.txt -outfiber 1 -o network 

    # This is a temporary solution to delete roi-wise .trk file while keep the globle tract (dti_wb.trk)
    rm -f ` ls *.trk|sed -e 's/dti_wb.trk/mmmmmmmmmm/g'  `

    cd ..
done

echo "Please check the results in the folder of each subject"
