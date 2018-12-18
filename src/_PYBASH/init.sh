#!/bin/sh
# Tooling to modify pybash through shell.
# More hooks between bash and python
_MODULE_NAME="_PYBASH"
if [ ! -e $PYBASH_DATA_DIR/$_MODULE_NAME ]; then
  mkdir $PYBASH_DATA_DIR/$_MODULE_NAME
fi

# CREATING NEW MODULES

pw "
args = [alias.Argument('module_name', 'string', True)]
pybash.registerAlias(module_name='$_MODULE_NAME',
                     name='new_module',
                     value='pybash_new_module',
                     args=args,
                     desc='Creates a new pybash module with some starter files')
"
pybash_new_module() {
  if [ $# -lt 1 ]; then
    echo "USAGE: pybash_new_module [MODULE NAME]";
    return
  fi

  MODULE_DIR=$PYBASH_SRC_DIR/$1
  if [ -e $MODULE_DIR ]; then
    echo "MODULE ALREADY EXISTS"
    return
  else
    mkdir $MODULE_DIR
    touch $MODULE_DIR/std_addition.py

    INSTALL_FILE_PATH=$MODULE_DIR/install.sh
    echo "#!/bin/sh
# Installation file for $MODULE_DIR

echo $1 >> $$PYBASH_DATA_DIR/installed_modules.txt" > $INSTALL_FILE_PATH

    INIT_FILE_PATH=$MODULE_DIR/init.sh
    echo "# TODO: startup script for $1 module.
MODULE_NAME=\"$1\"
MODULE_DIR=\$_PYBASH_DATA_DIR/\$_MODULE_NAME
if [ ! -e \$MODULE_DIR ]; then
  mkdir \$MODULE_DIR
fi" > $INIT_FILE_PATH

    touch $MODULE_DIR/__init__.py

    README_FILE_PATH=$MODULE_DIR/README
    echo "Module: $1

# TODO: describe module

________________________ init.sh ________________________
# TODO: describe bash changes

____________________ std_addition.py ____________________
# TODO: describe pybash_eval changes" >> $README_FILE_PATH
  fi
}

pw "args = [alias.Argument('module name', 'string', True)]"
pw "pybash.registerAlias('pb_install', 'pybash_install_module', '$MODULE_NAME', args, 'Installs a pybash module')"
pybash_install_module() {  # [module name]
  module_dir=$PYBASH_SRC_DIR/$1
  if [ ! -e $module_dir ]; then
    echo "ERROR: module \"$1\" not found."
    return
  fi

  pybash_source $module_dir/install.sh
}

# MANUAL PYSTD MANAGEMENT

py_import_raw() {
  echo "\"$1\" added to pybash"
  echo "$1" >> $PYSTD_SRC_PATH
  echo "$1" >> $PYSTD_GEN_PATH
}

py_import() {
  ADDED_CODE=""
  if [ $# -lt 1 ]; then
    echo "USAGE: py_import [python module] [|class] [|as]";
    return
  elif [ $# -eq 1 ]; then
    ADDED_CODE="import $1"
  elif [ $# -eq 2 ]; then
    ADDED_CODE="from $1 import $2"
  else
    ADDED_CODE="from $1 import $2 as $3"
  fi
  py_import_raw $ADDED_CODE
}

# DOCUMENTATION

pw "pybash.getAliases()"

pw "args = [alias.Argument('name', 'string', True, 'Name of alias'),
    alias.Argument('value', 'string', True, 'Name of function that is called')]"
pw "pybash.registerAlias('pb_alias', 'pybash_alias', args=args)"
pybash_alias() { # [name] [value] (temporary)
  # PENDING: make alias temporary based on $3
  # FUTURE: PROMPT ARGS
  p "pybash.registerAlias('$1', '$2')"
}

pw "args = [alias.Argument('name', 'string', True)]"
pw "args.append( alias.Argument('module name', 'string', True) )"
pw "pybash.registerAlias('pb_unalias', 'pb_remove_alias', args=args, module_name='$_MODULE_NAME')"
pb_remove_alias() {  # [name] [module_name]
  p "aliases = pickle.load(open(pybash.ALIAS_INFO_PATH, 'rb') )
del aliases['$1']['$2']
if not len(aliases['$1']):
  del aliases['$1']
pickle.dump(aliases, open(pybash.ALIAS_INFO_PATH, 'wb') )"
}

pw "args = [alias.Argument('name', 'string', True),
    alias.Argument('module name', 'string', False)]"
pw "pybash.registerAlias('man', 'pybash_man', args=args)"
pybash_man() {
  p "
aliases = pybash.getAliases()
name = '$1'
module_name = '$2'
fail = False
if name in aliases:
  if len(aliases[name]) == 1:
    for _, alias in aliases[name].items():
      print(alias.fullDescription())
  else:
    if module_name in aliases[name]:
      print(aliases[name][module_name].fullDescription())
    else:
      fail = True
else:
  fail = True

if fail:
  # print('command man $1')
  bcmd('command man $1')
"
}


pybash_execute
