cd output/build/playground-HEAD
git pull
cd ../../../
rm -rf output/target/nonlinear/playground
make playground-clean-for-reconfigure
make playground-clean-for-rebuild
make playground-rebuild

