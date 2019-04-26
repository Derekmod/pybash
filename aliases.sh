alias n="nano"
alias nano="atom"
alias e="emacs"
alias lsa="ls -a"
alias c="clear; "
alias h="echo "
alias rmf="rm -f"
alias a="alias"
alias py="python"

require _PYBASH
if require_fail; then return; fi

pw "args = [alias.Argument('bvar name', 'string', True)]"
pw "pybash.registerAlias('h.', 'echo_var', args=args)"
echo_var() {
  p "print(bvar.$1)"
}

pw "args = [alias.Argument('directory', 'string', False)]"
pw "pybash.registerAlias('d.', 'cd_ls', args=args)"
cd_ls() {
  cd $1
  ls
}

pw "args = [alias.Argument('directory', 'string', True)]"
pw "pybash.registerAlias('md', 'mkdir_cd', args=args)"
mkdir_cd() {
  mkdir $1
  cd $1
}

pw "pybash.registerAlias('pbr', 'pybash_reload')"
pybash_reload() {
  source $PYBASH_DIR/startup.sh
}

pw "args = [alias.Argument('filepath', 'string', True, 'path to script')]"
pw "pybash.registerAlias('pb_source', 'pybash_source', args=args)"
pybash_source() {
  source $1
  pybash_execute
}

pybash_execute
