#!/bin/sh

# Check to see if Homebrew is installed, and install it if it is not
command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew Now"; \
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }


if brew ls --versions sourcery > /dev/null; then
  echo "The 'sourcery' package is installed"
else
  brew install sourcery
fi

if [ -z "$1" ]; then
    echo "Usage script.sh {PackageName}";
    echo "  Example: script.sh Calls";
    echo "      will create CantinaCalls package.";
    exit 0
fi

LCFL_NAME="$(tr '[:upper:]' '[:lower:]' <<< ${1:0:1})${1:1}"
MODULE_PACKAGE="./Packages/Cantina-ios-$LCFL_NAME/Package.swift";
MODULE_SOURCES="./Packages/Cantina-ios-$LCFL_NAME/Sources/Cantina$1";

if test -f "$MODULE_PACKAGE"; then
    echo "$MODULE_PACKAGE exists."
else
    echo "Will create module '$1' at '$MODULE_PACKAGE'";
    sourcery --args moduleName=$1 --output "$MODULE_PACKAGE" --templates "./Utils/SourceryModule/ModulePackage.stencil" --sources "./Utils/SourceryModule/"
    tail -n +4 "$MODULE_PACKAGE" > "temp.tmp"
    mv -f "temp.tmp" "$MODULE_PACKAGE"
fi

sh ./create-module.sh "$1" "$MODULE_SOURCES"
