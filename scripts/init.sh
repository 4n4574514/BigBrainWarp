#!/bin/bash/

# set up variables - change for your environment
export bbwDir=/data_/mica1/03_projects/casey/BigBrainWarp/
export cbigDir=/data_/mica1/03_projects/casey/CBIG-master/
export mnc2Path=/data_/mica1/01_programs/minc2/

# set template and download if not already there
icbmTemplate=$bbwDir/spaces/icbm/mni_icbm152_t1_tal_nlin_sym_09c_mask.mnc
if [[ ! -f $icbmTemplate ]] ; then
	cd $bbwDir/spaces/icbm/
	wget http://www.bic.mni.mcgill.ca/~vfonov/icbm/2009/mni_icbm152_nlin_sym_09c_minc2.zip
	unzip mni_icbm152_nlin_sym_09c_minc2.zip
	rm mni_icbm152_nlin_sym_09c_minc2.zip
fi

# download nonlinear transformation matrices (note: large files)
if [[ ! -f $bbwDir/xfms/BigBrain-to-ICBM2009sym-nonlin_grid_2.mnc ]] ; then
	mkdir $bbwDir/xfms/
	cd $bbwDir/xfms/
	wget https://packages.bic.mni.mcgill.ca/mni-models/PD25/mni_PD25_20190708_minc2.zip
	unzip mni_PD25_20190708_minc2.zip
	cp tranformation/BigBrain-to-ICBM2009sym* $bbwDir/xfms/
	rm -rf MRI
	rm -rf segmentation
	rm -rf tranformation
	rm subcortical-labels.csv
	rm mni_PD25_20190708_minc2.zip
fi

# download surfstat to dependencies if not already there
if [[ ! -d $bbwDir/dependencies/surfstat/ ]] ; then
	cd $bbwDir/dependencies/
	wget https://www.math.mcgill.ca/keith/surfstat/surfstat.zip
	unzip surfstat.zip -d surfstat
	rm -f surfstat.zip
fi

# make git ignore
if [[ ! -f $bbwDir/.gitignore ]] ; then
	cp $bbwDir/template_gitignore.txt $bbwDir/.gitignore
fi

# add to paths
export PATH=$bbwDir/scripts/:$mnc2Path:$PATH
export PATH=$bbwDir/scripts/:$PATH
export MATLABPATH=$bbwDir/scripts/:$MATLABPATH




