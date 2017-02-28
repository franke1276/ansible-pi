#!/bin/bash
set -e

repo=$1
target=$2

date_str=$(date)
echo "--- run install $date_str ---"
echo "Repo: $repo "
echo "target: $target"

has_changes=false
if [ ! -e $target ]; then
  echo "no target found. Clone $repo to target"
  git clone "$repo" "$target"
  has_changes=true
  cd $target
  echo "repo checkout for the first time."
else
  cd $target
  hash=$(git rev-parse HEAD)
  git pull
  new_hash=$(git rev-parse HEAD)
  if [ "$hash" != "$new_hash" ]; then
    echo "repo has been changed."
    has_changes=true
  fi  
fi

if [ $has_changes ];then
  echo "run update:"
  bash ./update.sh
fi
echo "install finished. had changes: $had_changes"
