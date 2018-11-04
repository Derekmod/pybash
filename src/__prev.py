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

aliases = pybash.getAliases()
name = 'jot'
module_name = ''
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
  # print('command man jot')
  bcmd('command man jot')

