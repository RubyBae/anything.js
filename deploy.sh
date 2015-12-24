#!/bin/bash
set -e # exit with nonzero exit code if anything fails

# inside this git repo we'll pretend to be a new user
git config user.name "Travis CI"
git config user.email "rennierab@gmail.com"

git checkout master
git stash
git stash apply
git add dist/anything.js
git add dist/anything.min.js
git commit -m "Update dist [ci skip]"

git checkout gh-pages
git stash pop
git add dist/anything.js
git add dist/anything.min.js
git commit -m "Update dist [ci skip]"

git push "https://${GITHUB_SECRET_TOKEN}@${GH_REF}" master > /dev/null 2>&1
git push "https://${GITHUB_SECRET_TOKEN}@${GH_REF}" gh-pages > /dev/null 2>&1
