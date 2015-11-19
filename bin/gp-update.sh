#!/bin/bash -e

# usage ./gp-update.sh iron-icon

repo=$1

pushd $repo >/dev/null

bower cache clean $repo

bower update

git add -A .
git commit -am 'Documentation update'
git push -u origin gh-pages

popd >/dev/null
