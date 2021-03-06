#!/bin/bash

# cd into label dumpling dir.
cd ./tools/label-dumpling/ || exit

# Add fmt and clippy components.
rustup component add rustfmt
rustup component add clippy

# In the CI environment we need to copy the .env file for use by dotenv.
if [[ -z "${CI}" ]]; then
  echo "Not a CI environment, do not copy .env.example to .env"
else
  echo "In a CI environment, copy the .env.example to .env"
  cp .env.example .env || exit
fi

# checks
cargo fmt --all -- --check
cargo check --all --all-targets
cargo clippy --all --all-targets -- -D warnings
