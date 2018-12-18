PYBASH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# TODO: check if python installed

PYBASH_DATA_DIR=$PYBASH_DIR/data
<<<<<<< HEAD
if [ ! -e $PYBASH_DATA_DIR ]; then
=======
if ! [ -e $PYBASH_DATA_DIR ]; then
>>>>>>> dfdfcbd6a69206be157881511049b366e7b9a7b4
  mkdir $PYBASH_DATA_DIR
fi

if [ -e $PYBASH_DATA_DIR/.aliases.pickle ]; then
  rm $PYBASH_DATA_DIR/.aliases.pickle
fi

if [ -z "$PYBASH_IMPORTED" ]; then
  echo "
source $PYBASH_DIR/startup.sh
PYBASH_IMPORTED=1" >> ~/.bashrc
  source $PYBASH_DIR/src/_PYBASH/install.sh
  source $PYBASH_DIR/startup.sh
else
  echo "pybash already imported!"
fi
