#!/bin/sh

(
    cd ../
    pwd
    rm -rf output/target/nonlinear/playground
    make playground-clean-for-reconfigure || { echo "clean-for-reconfigure failed"; }
    make playground-clean-for-rebuild || { echo "clean-for-rebuild failed"; }
    make playground-rebuild || { echo "rebuild failed"; exit 1; }
)
