#!/bin/bash -e

# usage ./gp-create.sh Polymer core-item [branch]

# IMPORTANT NOTE:
#  Unlike Polymer's own gp.sh script this script does not support an ignored `demo` folder. The advantage of this
#  script in my opinion is that you don't need to start from scratch each time (a simple bower update and push will do).

# Run in a parent directory passing in a GitHub org and repo name
org=$1
repo=$2
branch=${3:-"master"} # default to master when branch isn't specified

mkdir $repo
pushd $repo >/dev/null
git init
git checkout --orphan gh-pages
git remote add origin git@github.com:$org/$repo.git
echo "{
  \"name\": \"$2 documentation\"
}
" > bower.json
echo "{
  \"directory\": \"components\"
}
" > .bowerrc
# installing a wide set of useful elements, so that you can use those in demo's without requiring them in your bower file
bower install --save PolymerElements/paper-elements
bower install --save PolymerElements/iron-elements
bower install --save PolymerElements/neon-elements
bower install --save PolymerElements/gold-elements
bower install --save GoogleWebComponents/google-web-components
bower install --save $org/$repo#$branch

# redirect by default to the component folder
echo "<META http-equiv="refresh" content=\"0;URL=components/$repo/\">" >index.html

# send it all to github
git add -A .
git commit -am 'seed gh-pages'

git push -u origin gh-pages

popd >/dev/null
