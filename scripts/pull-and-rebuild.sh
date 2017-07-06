#!/bin/sh

branch=$1

./pull-playground.sh $branch || { echo "pull branch '$branch' failed"; exit 1; }
./rebuild-playground.sh || { echo "rebuilding playground for branch '$branch' failed"; exit 1; }
