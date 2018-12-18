PYBASH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

# TODO: check if python installed

PYBASH_DATA_DIR=$PYBASH_DIR/data
if [ ! -e $PYBASH_DATA_DIR ]; then
  mkdir $PYBASH_DATA_DIR
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
