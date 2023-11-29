#!/bin/sh

# Check to see if Homebrew is installed, and install it if it is not
command -v brew >/dev/null 2>&1 || { echo >&2 "Installing Homebrew Now"; \
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; }


if brew ls --versions sourcery > /dev/null; then
  echo "The 'sourcery' package is installed"
else
  brew install sourcery
fi


if brew ls --versions swiftlint > /dev/null; then
  echo "The 'swiftlint' package is installed"
else
  brew install swiftlint
fi

if brew ls --versions swiftgen > /dev/null; then
  echo "The 'swiftgen' package is installed"
else
  brew install swiftgen
fi

for var in "$@"
do
    if [ ! -z "$var" ] && ([ $var = "--clear" ] || [ $var = "-c" ]);
    then
        echo "\nStart generated files removing..."
        sh clear-generated.sh
        echo "All generated files was removed! \n"
    fi
done

sourcery --config ./module-dependency-sourcery.yml --disableCache --quiet

configs=`find . -name "*sourcery.yml"`
for config in $configs
do
  echo "sourcery --config $config"
  sourcery --config "$config" --prune --disableCache --quiet
done

configs=`find . -name "*swiftgen.yml"`
for config in $configs
do
  echo "swiftgen config run --config $config"
  swiftgen config run --config "$config"
done

./swiftformat .

swiftlint --fix
