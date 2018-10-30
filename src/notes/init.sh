# TODO: startup script for notes module.
_MODULE_NAME="notes"
_DATA_DIR=$PYBASH_DATA_DIR/$_MODULE_NAME
if [ ! -e $_DATA_DIR ]; then
  mkdir $_DATA_DIR
fi
export PYBASH__NOTES_DIR=$_DATA_DIR/notebooks
if [ ! -e $PYBASH__NOTES_DIR ]; then
  mkdir $PYBASH__NOTES_DIR
fi

pw "args = [alias.Argument('note name', 'string', True)]"
pw "args.append( alias.Argument('text', 'string', True) )"
pw "pybash.registerAlias('jot', 'add_note_item', module_name='$_MODULE_NAME', args=args)"
add_note_item() {
  p "
from notes.notebook import *
note = getNote('$1')
item = '$@'
item = item[item.index(' ')+1:]
note.addItem(item)
saveNote(note)"
}

pw "args = [alias.Argument('note name', 'string', False)]"
pw "args.append( alias.Argument('idx', 'int', False) )"
pw "args.append( alias.Argument('bvar', 'string', False) )"
pw "pybash.registerAlias('notes', 'read_note', module_name='$_MODULE_NAME', args=args)"
read_note() {
  if [ $# -lt 1 ]; then
    ls $PYBASH__NOTES_DIR
    return
  fi

  pw "from notes.notebook import *
note = getNote('$1')"
  if [ $# -ge 2 ]; then
    pw "s = note.items[$2]"
  else
    pw "s = note.render()"
  fi

  if [ $# -ge 3 ]; then
    pw "bcmd('$3=\"' + s + '\"')"
  fi
  p "print(s)"
}

pw "args = args[:2]"
pw "pybash.registerAlias('del_note', 'delete_note', module_name='$_MODULE_NAME', args=args)"
pw "pybash.registerAlias('notes_del', 'delete_note', module_name='$_MODULE_NAME', args=args)"
delete_note() {
  # TODO
  echo "NOT IMPLEMENTED"
}


pybash_execute
