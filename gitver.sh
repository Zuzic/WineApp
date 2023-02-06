#!/bin/sh

BRANCH_NAME=`git rev-parse --abbrev-ref HEAD`

if [ "$BRANCH_NAME" = "dev" ]; then
   echo `git rev-list --count HEAD ^master`
else
   echo `git rev-list --count HEAD ^dev`
fi
