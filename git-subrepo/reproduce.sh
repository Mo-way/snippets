#!/bin/sh

# https://stackoverflow.com/questions/79400970/git-subtree-conflict-resolution


# Setup
mkdir mainrepo
cd mainrepo || echo "cd failed script bogus"
git init
touch 1.txt 2.txt
git add .
git commit -m "Add 1, 2"

cd .. || echo "cd failed script bogus"
mkdit childrepo
cd childrepo || echo "cd failed script bogus"
git subtree pull -P mainrepotest ../main-repo/ main
cd mainrepotest
rm 1.txt
git add .
git commit -m "Rm 1"
git subtree pull -P mainrepotest ../main-repo/ main


