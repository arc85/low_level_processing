#!/bin/bash

source ./bin/01_setup.sh
sbatch --mail-user=$USER_FOR_EMAIL ./bin/01a_stage1.sbatch
