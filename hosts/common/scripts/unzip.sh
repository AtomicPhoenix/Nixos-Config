#!/usr/bin/env bash

FILE="$1"
BASENAME=$(basename "$FILE")
FILENAME="${BASENAME%%.*}"
nix run nixpkgs#unzip "$FILE" -- -d "$PWD/$FILENAME" &&
	echo "Unzipped files to $PWD/$FILENAME"
