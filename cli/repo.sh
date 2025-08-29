#!/bin/bash

# repo name
repo="g"

# repo desc
desc="A Streamlined Git Wrapper for Improved Continuous Integration"

# create remote repo
gh auth status
if [ $? -ne 0 ]; then
  gh auth login
fi

gh repo create "$repo" -d "$desc" --public

# create local repo
git init --initial-branch master .
git add .
git commit -m 'created repo'
git tag 0.0.1
git remote add origin "https://github.com/"$(git config user.name)"/$repo.git"
git push -u --follow-tags origin master

# official release branch
git checkout -b stable master
git push -u origin stable

# one dev branch per team
git checkout -b dev master
git push -u origin dev
