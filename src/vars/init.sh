# TODO: startup script for vars module.
MODULE_NAME="vars"
MODULE_DIR=$PYBASH_DATA_DIR/$MODULE_NAME
if [ ! -e $MODULE_DIR ]; then
  mkdir $MODULE_DIR
fi

VAR_DIR=$MODULE_DIR/vars

if [ ! -e $VAR_DIR ]; then
  mkdir $VAR_DIR
fi

pw "args = [alias.Argument('var name', 'string', True),
            alias.Argument('value', 'any', True)]"
pw "pybash.registerAlias('x', 'save_var', module_name='$MODULE_NAME', args=args)"
save_var() {  # [var name] [value]
  echo $2 >> $VAR_DIR/$1
}

pw "args = [alias.Argument('var name', 'string', False),
            alias.Argument('bvar name', 'string', False)]"
pw "pybash.registerAlias('v', 'load_var', '$MODULE_NAME', args)"
load_var() {  # [var name] (output bvar)
  if [ $# -eq 0 ]; then
    echo "Available vars:"
    ls $VAR_DIR
    return
  fi

  varpath=$(varpath $1)
  if [ ! -e $varpath ]; then
    echo "Variable \"$1\" not found."
    return
  fi

  value=$(cat $varpath)
  if [ $# -ge 1 ]; then
    p "bcmd('$2=\"$value\"')"
  else
    echo $value
  fi
}

pw "args = [alias.Argument('var name', 'string', True),
            alias.Argument('-a', 'flag', False, 'switch to async editor')]"
pw "pybash.registerAlias('q.', 'edit_var', '$MODULE_NAME', args, 'edits a permanent variable')"
edit_var() {  # [var name] (-a)
  varpath=$(varpath $1)

  editor=$EDITOR
  async=""
  if [[ $* == *-a* ]]; then
    editor=$ASYNC_EDITOR
    async=1
  fi

  eval $editor $varpath
}

varpath() {  # [var name]
  echo $VAR_DIR/$1
}


##############  LOCAL VARS  ###############

edit_local_var() {  # [bvar name] (-a)
  varpath=$MODULE_DIR/__tmp_var

  editor=$EDITOR
  async=""
  if [[ $* == *-a* ]]; then
    echo "ASYNC UNIMPLEMENTED"
    #editor=$ASYNC_EDITOR
    #async=1
  fi

  echo $1 > $varpath
  eval $editor $varpath
  p "bcmd('$1=\"$(cat $varpath)\"')"
}
