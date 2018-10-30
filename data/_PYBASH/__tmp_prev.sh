
alias .h.="h._wrapper"
.h._wrapper() {
  NARGS=$#
  if [[ $* == *-h* ]]; then
    echo ''
    echo 'alias .h.="echo_var"
USAGE: .h. [bvar name: string]
Module: ""
Arguments:
	bvar name <string>'
    return
  fi
  if [ $# -lt 1 ]; then
    echo "USAGE: .h. [bvar name: string]"
    return
  fi
  echo_var $*
}
alias h.="h._wrapper"
h._wrapper() {
  NARGS=$#
  if [[ $* == *-h* ]]; then
    echo ''
    echo 'alias h.="echo_var"
USAGE: h. [bvar name: string]
Module: ""
Arguments:
	bvar name <string>'
    return
  fi
  if [ $# -lt 1 ]; then
    echo "USAGE: h. [bvar name: string]"
    return
  fi
  echo_var $*
}

alias .d.="d._wrapper"
.d._wrapper() {
  NARGS=$#
  if [[ $* == *-h* ]]; then
    echo ''
    echo 'alias .d.="cd_ls"
USAGE: .d. (directory: string)
Module: ""
Arguments:
	directory <string>: (optional)'
    return
  fi
  if [ $# -lt 0 ]; then
    echo "USAGE: .d. (directory: string)"
    return
  fi
  cd_ls $*
}
alias d.="d._wrapper"
d._wrapper() {
  NARGS=$#
  if [[ $* == *-h* ]]; then
    echo ''
    echo 'alias d.="cd_ls"
USAGE: d. (directory: string)
Module: ""
Arguments:
	directory <string>: (optional)'
    return
  fi
  if [ $# -lt 0 ]; then
    echo "USAGE: d. (directory: string)"
    return
  fi
  cd_ls $*
}

alias .md="md_wrapper"
.md_wrapper() {
  NARGS=$#
  if [[ $* == *-h* ]]; then
    echo ''
    echo 'alias .md="mkdir_cd"
USAGE: .md [directory: string]
Module: ""
Arguments:
	directory <string>'
    return
  fi
  if [ $# -lt 1 ]; then
    echo "USAGE: .md [directory: string]"
    return
  fi
  mkdir_cd $*
}
alias md="md_wrapper"
md_wrapper() {
  NARGS=$#
  if [[ $* == *-h* ]]; then
    echo ''
    echo 'alias md="mkdir_cd"
USAGE: md [directory: string]
Module: ""
Arguments:
	directory <string>'
    return
  fi
  if [ $# -lt 1 ]; then
    echo "USAGE: md [directory: string]"
    return
  fi
  mkdir_cd $*
}

alias .pbr="pbr_wrapper"
.pbr_wrapper() {
  NARGS=$#
  if [[ $* == *-h* ]]; then
    echo ''
    echo 'alias .pbr="pybash_reload"
USAGE: .pbr 
Module: ""'
    return
  fi
  if [ $# -lt 0 ]; then
    echo "USAGE: .pbr "
    return
  fi
  pybash_reload $*
}
alias pbr="pbr_wrapper"
pbr_wrapper() {
  NARGS=$#
  if [[ $* == *-h* ]]; then
    echo ''
    echo 'alias pbr="pybash_reload"
USAGE: pbr 
Module: ""'
    return
  fi
  if [ $# -lt 0 ]; then
    echo "USAGE: pbr "
    return
  fi
  pybash_reload $*
}

alias .pb_source="pb_source_wrapper"
.pb_source_wrapper() {
  NARGS=$#
  if [[ $* == *-h* ]]; then
    echo ''
    echo 'alias .pb_source="pybash_source"
USAGE: .pb_source [filepath: string]
Module: ""
Arguments:
	filepath <string>: path to script'
    return
  fi
  if [ $# -lt 1 ]; then
    echo "USAGE: .pb_source [filepath: string]"
    return
  fi
  pybash_source $*
}
alias pb_source="pb_source_wrapper"
pb_source_wrapper() {
  NARGS=$#
  if [[ $* == *-h* ]]; then
    echo ''
    echo 'alias pb_source="pybash_source"
USAGE: pb_source [filepath: string]
Module: ""
Arguments:
	filepath <string>: path to script'
    return
  fi
  if [ $# -lt 1 ]; then
    echo "USAGE: pb_source [filepath: string]"
    return
  fi
  pybash_source $*
}
