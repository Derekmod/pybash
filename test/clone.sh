if [ $0 == "pybash/test/clone.sh" ]; then
    echo "Expected to run from pybash parent directory!!"
    exit
fi

# uninstall
rm -rf pybash_test
unset PYBASH_IMPORTED

# install
cp -r pybash/ pybash_test  # TODO: use export.sh instead
source pybash_test/install.sh
