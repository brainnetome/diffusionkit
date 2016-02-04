.. diffusionkit documentation master file, created by
   sphinx-quickstart on Mon Oct 26 10:48:55 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. meta::
   :description: File Formats in DiffusionKit

.. toctree::
   :maxdepth: 3

.. _Data Format:

-----------
Data Format
-----------

Input
-----

Since we apply the dcm2nii to unify the format of input data, 
it can support most types of DICOM files (in folders). 
Please refer to the author’s webpage for more information `[4] <reference.html#id4>`_. 
Please also get back to us if you encounter any problems.

Output
------

All the intermediate files are in compressed NIFTI format (.nii.gz). 
The final track file is in :code:`.trk` format. 
The :code:`.trk` format is from the 
`TrackVis <http://www.trackvis.org/docs/?subsect=fileformat>`_ 
`[17] <reference.html#id17>`_. 

Briefly, header section contains following information:

+-----------------+-----------+----------+----------------------------------------------+
| Name            | Data type | Bytes    | Comment                                      |
+=================+===========+==========+==============================================+
| id_string[6]    | char      | 6        | ID string for track file, "TRACK"            |
+-----------------+-----------+----------+----------------------------------------------+
| dim[3]          | short     | 6        | Dimension of the image volume.               |
+-----------------+-----------+----------+----------------------------------------------+
| voxel_size[3]   | float     | 12       | Voxel size of the image volume.              |
+-----------------+-----------+----------+----------------------------------------------+
|origin[3]        | float     | 12       | Origin of the image volume.                  |
+-----------------+-----------+----------+----------------------------------------------+
| n_scalars       | short     | 2        | Number of scalars saved at each track point  |
+-----------------+-----------+----------+----------------------------------------------+
| s_name[10][20]  | char      | 200      | Name of each scalar.                         |
+-----------------+-----------+----------+----------------------------------------------+
| n_properties    | short     | 2        | Number of properties saved at each track.    |
+-----------------+-----------+----------+----------------------------------------------+
| p_name[10][20]  | char      | 200      | Name of each property.                       |
+-----------------+-----------+----------+----------------------------------------------+
| vox_to_ras[4][4]| float     | 64       | 4x4 matrix for voxel to RAS                  |
+-----------------+-----------+----------+----------------------------------------------+
| reserved[444]   | char      | 444      | Reserved space for future version.           |
+-----------------+-----------+----------+----------------------------------------------+
| voxel_order[4]  | char      | 4        | Order of the original image data.            |
+-----------------+-----------+----------+----------------------------------------------+
| pad2[4]         | char      | 4        | Paddings.                                    |
+-----------------+-----------+----------+----------------------------------------------+
| orient_p[6]     | float     | 24       | Image orientation of the original image.     |
+-----------------+-----------+----------+----------------------------------------------+
| pad1[2]         | char      | 2        | Paddings.                                    |
+-----------------+-----------+----------+----------------------------------------------+
| invert_x        | uchar     | 1        | Inversion/rotation flags                     |
+-----------------+-----------+----------+----------------------------------------------+
| invert_y        | uchar     | 1        | As above.                                    |
+-----------------+-----------+----------+----------------------------------------------+
| invert_x        | uchar     | 1        | As above.                                    |
+-----------------+-----------+----------+----------------------------------------------+
| swap_xy         | uchar     | 1        | As above.                                    |
+-----------------+-----------+----------+----------------------------------------------+
| swap_yz         | uchar     | 1        | As above.                                    |
+-----------------+-----------+----------+----------------------------------------------+
| swap_zx         | uchar     | 1        | As above.                                    |
+-----------------+-----------+----------+----------------------------------------------+
| n_count         | int       | 4        | Number of tracks stored in this track file.  |
+-----------------+-----------+----------+----------------------------------------------+
| version         | int       | 4        | Version number. Current version is 2.        |
+-----------------+-----------+----------+----------------------------------------------+
| hdr_size        | int       | 4        | Size of the header, should be 1000.          |
+-----------------+-----------+----------+----------------------------------------------+

with data section in following format:

+----------+-----------+-----------+----------------------------------------------+
| Track    | Data type | Bytes     | Comment                                      |
+----------+-----------+-----------+----------------------------------------------+
| Track #1 | int       | 4         | Number of points in this track, as m.        |
|          +-----------+-----------+----------------------------------------------+
|          | float     | (3+n_s)*4 | Track Point #1.                              |
|          +-----------+-----------+----------------------------------------------+
|          | float     | (3+n_s)*4 | Track Point #2. Same as above.               |
|          +-----------+-----------+----------------------------------------------+
|          | float     | (3+n_s)*4 | Track Point #m. Same as above.               |
|          +-----------+-----------+----------------------------------------------+
|          | float     | n_p*4     | n_p float numbers                            |
+----------+-----------+-----------+----------------------------------------------+
| Track #2 | Same as above.                                                       |
+----------+-----------+-----------+----------------------------------------------+
| ...                                                                             |
+----------+-----------+-----------+----------------------------------------------+
| Track #n | Same as above.                                                       |
+----------+-----------+-----------+----------------------------------------------+

By default, we prefined two scalars (FA,MD) and three properties (length,FA,MD) 
in the generated .trk file, along with six additional values stored in :code:`reserved` section.
These are `version_num`, `num_fibers`, `mean_length`, `total_volume`, `tractFA`, `tractMD` values in 
:code:`float` type (single precision).

Again, please visit `DataFormat section on TrackVis.org <http://www.trackvis.org/docs/?subsect=fileformat>`_ for more detail.

.. include:: common.txt


