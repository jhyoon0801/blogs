#!/bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

hugo -t "grid-side" --buildDrafts

git add -A

if [ $# -eq 1 ]
  then msg="$1"
fi
git commit -m "$msg"

git push origin master

git subtree push --prefix=public git@github.com:jhyoon0801/blogs.git gh-pages
