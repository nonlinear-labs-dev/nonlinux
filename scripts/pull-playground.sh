#!/bin/sh

branch=$1

if [ -z "$branch" ]
then
    echo "branch argument missing"
    exit 1;
fi

(cd ../output/build/playground-HEAD || { echo "Could not find playground directory"; exit 1; }
git fetch origin $branch || { echo "Could not fetch branch $branch"; exit 1; }
git checkout $branch || { echo "Could not checkout branch $branch"; exit 1; }
git pull origin $1 || { echo "Could not pull branch $branch"; exit 1; })
