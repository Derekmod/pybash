# complex hooks and better file interaction
import pickle
import os

from _PYBASH.alias import Alias

DATA_DIR = os.path.join(os.environ['PYBASH_DATA_DIR'], '_PYBASH')
MODULE_NAME = '_PYBASH'

class _Holder(object):
    def __init__(self, map):
        self.__dict__ = dict(map)

bvar = _Holder(os.environ)

def bcmd(cmd):
    f = open(os.path.join(DATA_DIR, '__tmp.sh'), 'a')
    f.write(cmd + '\n')
    f.close()

def brun(filepath):
    bcmd('source ' + filepath + '; pybash_eval')

def brun_literal(filepath):
    src = open(filepath)
    dest = open(os.path.join(DATA_DIR, '__tmp.sh'), 'a')
    for line in src:
        dest.write(line)
    src.close()
    dest.close()

def cleanup_list_file(filename):
    items = {_ for _ in open(filename)}
    writer = open(filename, 'w')
    for item in items:
        writer.write(item + '\n')

ALIAS_INFO_PATH = os.path.join(DATA_DIR, '.aliases.pickle')
def registerAlias(name, value, module_name='', args=None, desc=None):
    new_alias = Alias(name, value, module_name, args, desc)
    # bcmd(new_alias.bashCommand())
    aliases = {}
    try:
        aliases = pickle.load(open(ALIAS_INFO_PATH, 'rb'))
    except IOError:
        pass

    if name not in aliases:
        aliases[name] = {}
        aliases[name][module_name] = new_alias
    else:
        prev_len = len(aliases[name])
        aliases[name][module_name] = new_alias
        if len(aliases[name]) > 1:
            new_alias.unique = False
            if prev_len == 1:
                genAmbiguousWrapper(aliases, name)
    bcmd(new_alias.bashCommand())
    pickle.dump(aliases, open(ALIAS_INFO_PATH, 'wb'), protocol=2)

def genAmbiguousWrapper(aliases, name):
    options = '\t'.join([mname+'.'+name for mname in aliases[name]])
    bcmd('''
alias {name}={name}_wrapper
{name}_wrapper() {{
  echo "AMBIGUOUS ALIAS: PLEASE USE ONE OF FOLLOWING"
  echo "{options}"
}}'''.format(**locals()) )

def bashAddAliases():
    try:
        aliases = pickle.load(open(ALIAS_INFO_PATH, 'rb'))
        for name in aliases:
            if not len(aliases[name]):
                del aliases[name]
                continue
            for module_name in aliases[name]:
                bcmd( aliases[name][module_name].bashCommand() )
            if len(aliases[name]) > 1:
                genAmbiguousWrapper(aliases, name)
    except Exception:
        pass

def getAliases():
    return pickle.load(open(ALIAS_INFO_PATH, 'rb'))
