#!/bin/bash

echo "updating database"
oldnfiles=$(wc -l all_complete_strains.csv)
cp all_complete_strains.csv old_all_complete_strains.csv

echo  "running update script"
Rscript remake_cgfind_data.R
nfiles=$( wc -l new_complete_genomes_min.csv)
mv new_complete_genomes_min.csv all_complete_strains.csv
git commit -m "update database (old: $oldnfiles; new: $nfiles )"
