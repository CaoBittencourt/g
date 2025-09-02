#!/bin/sh

# repo name
repo="repoName"

# repo desc
desc="repoDescription"

# create readme file
echo "# $repo: $desc" > ../README.md

# create gitignore file
touch .gitignore

# create remote repo
gh repo create "$repo" -d "$desc" --private

# create local repo
git init --initial-branch master .
git add .
git commit -m 'initial commit'
git remote add origin "https://github.com/"$(git config user.name)"/$repo.git"
git push -u origin master

# official release branch
git checkout -b stable master
git push -u origin stable

# one dev branch per team
git checkout -b dev master
git push -u origin dev

# only keep dev branch locally
git branch -D master
git branch -D stable
