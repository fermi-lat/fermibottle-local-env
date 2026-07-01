#!/bin/bash

# --- Configuration ---
ENV_NAME="fermi"                # Name of your conda environment
TESTING_BASE="${HOME}/shared-testing/"
REPO_URL="https://github.com/fermi-lat/ScienceTools.git" # URL of the repo

# --- Setup Conda ---
# Source conda.sh to allow activation within a script
# source "$CONDA_PATH/etc/profile.d/conda.sh" || echo "Conda path incorrect."
# /opt/anaconda/lib/python3.12/site-packages/conda/shell/etc/profile.d/conda.sh

mkdir -p "$TESTING_BASE"
mkdir -p "$TESTING_BASE"/test_results
cd "$TESTING_BASE"


# --- Git Clone ---
git clone "https://github.com/FermiSummerSchool/fermi-summer-school.git"

# Activate the environment
# Initialize conda for this shell session
# eval "$(conda shell.bash hook)"
# conda activate "$ENV_NAME"
# conda install ipykernel nb_conda_kernels  astropy junit-xml pytest -y

cd "$TESTING_BASE"
wget https://fermi.gsfc.nasa.gov/ssc/data/analysis/scitools/data/SummerSchool/Likelihood_rxj1713.tgz
tar -xvf Likelihood_rxj1713.tgz
rm -f Likelihood_rxj1713.tgz
cd Likelihood_rxj1713/
pytest --nbmake -n auto --nbmake-timeout=6000 --junitxml=${{ github.workspace }}/FB_TESTING/test_results/ss_real_exe_rxj1713_result.xml -vv Realtime_execution_RXJ1713.ipynb
cd ../
wget https://fermi.gsfc.nasa.gov/ssc/data/analysis/scitools/data/SummerSchool/Likelihood_rcw103.tgz
tar -xvf Likelihood_rcw103.tgz
cd Likelihood_rcw103/
pytest --nbmake -n auto --nbmake-timeout=6000 --junitxml=thub.workspace }}/FB_TESTING/test_results/ss_real_exe_rcw103_result.xml -vv Realtime_execution_RCW103.ipynb

cd ../fermi-summer-school/
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml="$TESTING_BASE"/test_results/data_quicklook_result.xml -vv Data_Exploration/*.ipynb
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml="$TESTING_BASE"/test_results/find_source_results.xml -vv Advanced_Topics/FindSource/*.ipynb
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml="$TESTING_BASE"/test_results/fss_like_adv_fermipy_result.xml -vv Likelihood_Advanced/Likelihood\ With\ fermiPy.ipynb  
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml="$TESTING_BASE"/test_results/fss_like_adv_curvature_result.xml -vv Likelihood_Advanced/Curvature\ Test.ipynb   
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml="$TESTING_BASE"/test_results/fss_like_adv_lightcurve_result.xml -vv Likelihood_Advanced/Lightcurve.ipynb  
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml="$TESTING_BASE"/test_results/fss_like_adv_sed_result.xml -vv Likelihood_Advanced/SED\ Stuff.ipynb
