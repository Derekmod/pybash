# Sets up all global pybash variables
# Then sets up base pybash functions
# Then initializes all pybash modules
# + loads aliases

export PYBASH_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
export PYBASH_SRC_DIR=$PYBASH_DIR/src
export PYBASH_DATA_DIR=$PYBASH_DIR/data

export PYTMP_PATH=$PYBASH_SRC_DIR/__tmp.py
export PYTMP2_PATH=$PYBASH_SRC_DIR/__prev.py
export PYSTD_SRC_PATH=$PYBASH_SRC_DIR/pystd_src.py
export PYSTD_GEN_PATH=$PYBASH_DATA_DIR/pystd_gen.py
export MODULE_LIST_PATH=$PYBASH_DATA_DIR/installed_modules.txt

if [ ! -e $PYBASH_DATA_DIR ]; then
  mkdir $PYBASH_DATA_DIR
fi

if [ ! -e $PYBASH_DATA_DIR/installed_modules.txt ]; then
  source $PYBASH_SRC_DIR/_PYBASH/install.sh
fi
touch $PYBASH_DATA_DIR/__tmp.sh

_pybash_eval_raw() {
  echo "$@" > $PYTMP_PATH
  python3 $PYTMP_PATH
  rm -f $PYTMP_PATH
}

alias p="pybash_eval"
pybash_eval() {
  pybash_write "$@"
  pybash_execute
}

pybash_execute() {
  if [ ! -e $PYTMP_PATH ]; then
    return
  fi
  mv $PYTMP_PATH $PYTMP2_PATH
  python3 $PYTMP2_PATH

  BASH_CMD_PATH=$PYBASH_DATA_DIR/__tmp.sh
  BASH_OLD_CMD_PATH=$PYBASH_DATA_DIR/__tmp_prev.sh
  while [ -e $BASH_CMD_PATH ]; do
    mv -f $BASH_CMD_PATH $BASH_OLD_CMD_PATH
    source $BASH_OLD_CMD_PATH
  done
}

alias pw="pybash_write"
pybash_write() {
  if [ ! -e $PYTMP_PATH ]; then
    cp -f $PYSTD_GEN_PATH $PYTMP_PATH
  fi
  echo "$@" >> $PYTMP_PATH
}

pybash_source() {
  source $1
  pybash_execute
}

REQUIRE_FAIL=0
require() {
  if [ $# -lt 1 ]; then
    echo "USAGE: require [module name]"
    return
  fi
  MODULE_GATE_NAME="__$1""_IMPORTED"
  if [ -z "${!MODULE_GATE_NAME}" ]; then
    echo "REQUIRE ERROR: module '$1' not imported"
    REQUIRE_FAIL=1
  fi
}

require_fail() {
  if [ $REQUIRE_FAIL -eq 0 ]; then
    return 1
  else
    REQUIRE_FAIL=0
    return 0
  fi
}

# setup pystd
cp $PYSTD_SRC_PATH $PYSTD_GEN_PATH
_pybash_eval_raw "
import os
for line in open('$MODULE_LIST_PATH'):
  module_name = line.strip()
  os.system('cat {src} >> {std}'.format(src='$PYBASH_SRC_DIR' + '/' + module_name + '/std_addition.py',
                                        std='$PYSTD_GEN_PATH') )
"

# initialize all modules
pybash_eval "
for line in open('$MODULE_LIST_PATH'):
  module_name = line.strip()
  brun('$PYBASH_SRC_DIR/' + module_name + '/init.sh')
  bcmd('__' + module_name + '_IMPORTED=1')
  print(module_name)
"

# load custom aliases
source $PYBASH_DIR/aliases.sh
