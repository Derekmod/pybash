# TODO: startup script for cmd module.
MODULE_NAME="cmd"
if [ ! -e $PYBASH_DATA_DIR/$MODULE_NAME ]; then
  mkdir $PYBASH_DATA_DIR/$MODULE_NAME
fi

# command manipulation

pw "args = [alias.Argument('bvar name', 'string', False),
            alias.Argument('history args', 'string', False)]"
pw "pybash.registerAlias('z', 'get_prev_cmd', module_name='$MODULE_NAME', args=args)"
get_prev_cmd() {
  args=1
  if [ ! -z "$1" ]; then
    args="$1"
  fi
  re='^[0-9]+$'
  if [[ $args =~ $re ]]; then
    let args=args+1
  fi
  export _HST=$(history "$args")
  c=$(p "
hst=bvar._HST
line = hst.strip().split('\n')[0]
cmd = line[line.index(' ')+2:]
print(cmd)
")
  if [ ! -z "$2" ]; then
    p "bcmd('export $2=\"$c\"')"
  else
    echo "$c"
  fi
}

pw "pybash.registerAlias('zz', 'exec_prev_cmd', module_name='$MODULE_NAME', args=args[:1])"
exec_prev_cmd() {
  if [ -z "$_exec_prev_cmd_RECURSION_DEPTH" ]; then
    export _exec_prev_cmd_RECURSION_DEPTH=0
  fi
  if [ $_exec_prev_cmd_RECURSION_DEPTH -ge 3 ]; then
    echo "ERROR: recursive command '$(get_prev_cmd)'"
    export ERROR="PATIENCE_OVERFLOW"
    return
  fi
  let _exec_prev_cmd_RECURSION_DEPTH=_exec_prev_cmd_RECURSION_DEPTH+1
  prev_cmd="$(get_prev_cmd $1)"
  eval "$(get_prev_cmd $1)"
  if [ "$ERROR" = "PATIENCE_OVERFLOW" ]; then
    echo "$prev_cmd"
  fi
  _exec_prev_cmd_RECURSION_DEPTH=""
}


pybash_execute
