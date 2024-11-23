# CoRNN T1 Tractography
Tractography on T1-weighted MRI without diffusion MRI.


## Overview

This work is reproduced version of the research conducted by Leon Y. Cai's [CoRNN Tractography](https://github.com/MASILab/cornn_tractography).  
In this version, the model is trained with more data and used recent version of the packages.


## Authors and Reference

[Leon Y. Cai](mailto:leon.y.cai@vanderbilt.edu), Ho Hin Lee, Nancy R. Newlin, Cailey I. Kerley, Praitayini Kanakaraj, Qi Yang, Graham W. Johnson, Daniel Moyer, Kurt G. Schilling, Francois Rheault, and Bennett A. Landman. [Convolutional-recurrent neural networks approximate diffusion tractography from T1-weighted MRI and associated anatomical context](https://www.biorxiv.org/content/10.1101/2023.02.25.530046v1). Proceedings of Machine Learning Reseach. In press. 2023.


## Containerization of Source Code

    git clone https://github.com/yoonjongyeon/CoRNN_T1.git
    cd /path/to/repo/CoRNN_T1
    sudo singularity build /path/to/CoRNN_T1.sif Singularity

  Alternatively, a pre-built container can be downloaded [here](https://vanderbilt365-my.sharepoint.com/:f:/g/personal/jongyeon_yoon_vanderbilt_edu/Ei9uIkXI1DJKg38b6trXVhUBhtWTsiHHr6RY7NWrZ0qezw?e=rnIiaa).


## Preparation
Before running a container, output from [SLANT](https://github.com/MASILab/SLANTbrainSeg) and [WM learning (WML)](https://github.com/MASILab/WM_learning_release) TractSeg segmentations are needed.


## Command

    singularity run 
    -e 
    --contain
    -B <t1_file>:/data/T1.nii.gz
    -B <out_dir>:/data
    -B <slant_dir>:/data/slant
    -B <wml_dir>:/data/wml
    -B /tmp:/tmp
    --nv
    /path/to/CoRNN_T1.sif
    /data/T1.nii.gz
    /data/<out_name>
    --slant /data/slant
    --wml /data/wml
    [options]
    
* Binding `/tmp` is required with `--contain` when `--work_dir` is not specified.
* `--nv` is optional. See `--device`.

## Arguments and I/O

* **`<t1_file>`** Path on the host machine to the T1-weighted MRI with which tractography is to be performed in NIFTI format (either compressed or not).

* **`<out_dir>`** Path on the host machine to the *directory* in which the output tractogram will be saved.

* **`<out_name>`** *Name* (i.e., no directory) of the output tractogram with extension in trk, tck, vtk, fib, or dpy format.

* **`<slant_dir>`** Path on the host machine to the SLANT output directory.

* **`<wml_dir>`** Path on the host machine to the TractSeg WM Learning output directory.

## Options

* **`--help`** Print help statement.

* **`--device cuda/cpu`** A string indicating the device on which to perform inference. If "cuda" is selected, container option `--nv` must be included. Default = "cpu"

* **`--num_streamlines N`** A positive integer indicating the number of streamlines to identify. Default = 1000000

* **`--num_seeds N`** A positive integer indicating the number of streamlines to seed per batch. One GB of GPU memory can handle approximately 10000 seeds. Default = 100000

* **`--min_steps N`** A positive integer indicating the minimum number of 1mm steps per streamline. Default = 50

* **`--max_steps N`** A positive integer indicating the maximum number of 1mm steps per streamline. Default = 250

* **`--buffer_steps N`** A positive integer indicating the number of 1mm steps where the angle stopping criteria are ignored at the beginning of tracking. Default = 5

* **`--unidirectional`** A flag indicating that bidirectional tracking should not be performed. The buffer steps are NOT removed in this case. Default = Perform bidirectional tracking

* **`--work_dir /data/work_dir`** A string indicating the working directory to use. The location of the working directory on the host machine, `<work_dir>`, must also exist and be bound into the container with `-B <work_dir>:/data/work_dir` in the [command](#command). If the working directory contains previously generated intermediates, the corresponding steps will not be rerun. Default = create a new working directory in `/tmp`

* **`--keep_work`** A flag indicating that the intermediates in the working directory should NOT be cleared. Default = Clear working directory after completion

* **`--num_threads N`** A positive integer indicating the number of threads to use during multithreaded steps. Default = 1

* **`--force`** A flag indicating that the output file should be overwritten if it already exists. Default = Do NOT override existing output file

