#!/bin/sh

# Check to see if Homebrew is installed, and install it if it is not
command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew Now"; \
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }


if brew ls --versions sourcery > /dev/null; then
  echo "The 'sourcery' package is installed"
else
  brew install sourcery
fi

configs=`find . -name "*sourcery.yml"`
for config in $configs
do
  echo "sourcery --config $config"
  sourcery --config "$config" --prune --disableCache --quiet
done
