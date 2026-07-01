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
git clone "$REPO_URL"
git clone "https://github.com/fermi-lat/AnalysisThreads.git"

# --- Create Directory ---
cd "$TESTING_BASE"/test_results/
cd "$TESTING_BASE"/AnalysisThreads/SourceAnalysis


# Currently failing
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml=/home/fermi/FB_TESTING/test_results/esa6_result.xml -vv 6.ExtendedSourceAnalysis/*.ipynb
pytest -n auto --nbmake --nbmake-timeout=10000 --junitxml=/home/fermi/FB_TESTING/test_results/ulh2_result.xml -vv 2.UnbinnedLikelihood/*.ipynb
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml=/home/fermi/FB_TESTING/test_results/pul5_result.xml -vv 5.PythonUpperLimits/*.ipynb
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml=/home/fermi/FB_TESTING/test_results/pg8_results.xml -vv  8.PulsarGating/*.ipynb

# Should work, running in cicd -n auto
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml="$TESTING_BASE"/test_results/blh1_result.xml -vv 1.BinnedLikelihood/*.ipynb
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml="$TESTING_BASE"/test_results/plh3_result.xml -vv 3.PythonLikelihood/*.ipynb
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml="$TESTING_BASE"/test_results/splh4_result.xml -vv 4.SummedPythonLikelihood/*.ipynb
pytest -n auto --nbmake --nbmake-timeout=3000 --junitxml="$TESTING_BASE"/test_results/lap7_result.xml -vv 7.LATAperturePhotometry/*.ipynb
pytest -n auto --nbmake --nbmake-timeout=5000 --junitxml="$TESTING_BASE"/test_results/ed10_result.xml -vv 10.EnergyDispersion/*.ipynb
