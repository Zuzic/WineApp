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
    echo "Usage script.sh {ModuleName} {output/path}";
    echo "  Example: script.sh Auth ./Packages/streamscloud-ios-authUI/Sources/StreamsAuthUI/Module/";
    exit 0
fi

if [ -z "$2" ]; then
    echo "Usage script.sh {ModuleName} {output/path}";
    echo "  Example: script.sh Auth ./Packages/streamscloud-ios-authUI/Sources/StreamsAuthUI/";
    exit 0
fi

MODULE_FILE="$2/Assembly/$1Module.swift";
MODULE_DEP_FILE="$2/Assembly/$1ModuleDependecy.swift";
MODULE_OUT_FILE="$2/Assembly/$1ModuleOutput.swift";
MODULE_YML_FILE="$2/sourcery.yml";
MODULE_LOGGER_FILE="$2/Assembly/Logger.swift";

if test -f "$MODULE_FILE"; then
    echo "$MODULE_FILE exists."
else
    echo "Will create module '$1' at '$MODULE_FILE'";
    sourcery --args moduleName=$1 --output "$MODULE_FILE" --templates "./Utils/SourceryModule/Module.stencil" --sources "./Utils/SourceryModule/"
    tail -n +4 "$MODULE_FILE" > "temp.tmp"
    mv -f "temp.tmp" "$MODULE_FILE"
fi


if test -f "$MODULE_DEP_FILE"; then
    echo "$MODULE_DEP_FILE exists."
else
    echo "Will create module dependencies at '$MODULE_DEP_FILE'";
    sourcery --args moduleName=$1 --output "$MODULE_DEP_FILE" --templates "./Utils/SourceryModule/ModuleDependency.stencil" --sources "./Utils/SourceryModule/"
    tail -n +4 "$MODULE_DEP_FILE" > "temp.tmp"
    mv -f "temp.tmp" "$MODULE_DEP_FILE"
fi


if test -f "$MODULE_OUT_FILE"; then
    echo "$MODULE_OUT_FILE exists."
else
    echo "Will create module output at '$MODULE_OUT_FILE'";
    sourcery --args moduleName=$1 --output "$MODULE_OUT_FILE" --templates "./Utils/SourceryModule/ModuleOutput.stencil" --sources "./Utils/SourceryModule/"
    tail -n +4 "$MODULE_OUT_FILE" > "temp.tmp"
    mv -f "temp.tmp" "$MODULE_OUT_FILE"
fi

if test -f "$MODULE_YML_FILE"; then
    echo "$MODULE_YML_FILE exists."
else
    echo "Will create module sourcery.yml at '$MODULE_YML_FILE'";
    sourcery --args moduleName=$1 --output "$MODULE_YML_FILE" --templates "./Utils/SourceryModule/sourcery.stencil" --sources "./Utils/SourceryModule/"
    tail -n +2 "$MODULE_YML_FILE" > "temp.tmp"
    mv -f "temp.tmp" "$MODULE_YML_FILE"
fi

if test -f "$MODULE_LOGGER_FILE"; then
    echo "$MODULE_LOGGER_FILE exists."
else
    echo "Will create module logger at '$MODULE_LOGGER_FILE'";
    sourcery --args moduleName=$1 --output "$MODULE_LOGGER_FILE" --templates "./Utils/SourceryModule/Logger.stencil" --sources "./Utils/SourceryModule/"
    tail -n +4 "$MODULE_LOGGER_FILE" > "temp.tmp"
    mv -f "temp.tmp" "$MODULE_LOGGER_FILE"
fi

sh ./generate.sh
