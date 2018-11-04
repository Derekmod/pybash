from __future__ import absolute_import
from __future__ import division
from __future__ import print_function

import numpy as np
import os
import sys
import math
import pickle
from _PYBASH import pybash
from _PYBASH import pybash as pb
from _PYBASH.pybash import brun, bcmd, bvar
import _PYBASH.alias as alias
args = [alias.Argument('bvar name', 'string', True)]
pybash.registerAlias('h.', 'echo_var', args=args)
args = [alias.Argument('directory', 'string', False)]
pybash.registerAlias('d.', 'cd_ls', args=args)
args = [alias.Argument('directory', 'string', True)]
pybash.registerAlias('md', 'mkdir_cd', args=args)
pybash.registerAlias('pbr', 'pybash_reload')
args = [alias.Argument('filepath', 'string', True, 'path to script')]
pybash.registerAlias('pb_source', 'pybash_source', args=args)
