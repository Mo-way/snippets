#!/bin/sh

# https://stackoverflow.com/questions/79400970/git-subtree-conflict-resolution

# Need to move this out  of the snippets repo!

# cleanup
gio trash mainrepo
gio trash childrepo

# Setup
mkdir mainrepo
cd mainrepo || { echo "cd failed script bogus"; exit 1; } 
git init
touch 1.txt 2.txt
git add . && git commit -m "Add 1, 2"

cd .. || { echo "cd failed script bogus"; exit 1; } 
mkdir childrepo

cd childrepo || { echo "cd failed script bogus"; exit 1; } 
git init
touch child.txt
git add . && git commit -m "add child txt"

# Actions
git subtree add -P mainrepoSub ../mainrepo/ main
cd mainrepoSub || { echo "cd failed script bogus"; exit 1; } 
rm 1.txt
git add . && git commit -m "Rm 1"

cd ../../mainrepo || { echo "cd failed script bogus"; exit 1; } 
echo "some edit" >> 1.txt
git add . && git commit -m "Edit 1 (which is deleted in child)"

cd ../childrepo || { echo "cd failed script bogus"; exit 1; } 
git subtree pull -P mainrepoSub ../mainrepo/ main


