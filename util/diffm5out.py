#!/usr/bin/python3

import sys, os
import os.path as opth

d0, d1 = sys.argv[1:]

L0 = [opth.join(d0, 'config.ini'), opth.join(d1, 'config.ini')]
L1 = [opth.join(d0, 'stats.txt'), opth.join(d1, 'stats.txt')]
#os.spawnl(os.P_WAIT, '/usr/bin/tkdiff', L0)
#os.spawnl(os.P_WAIT, '/usr/bin/tkdiff', L1)

os.system('tkdiff ' + opth.join(d0, 'config.ini') + ' ' + opth.join(d1, 'config.ini') + ' &')
os.system('tkdiff ' + opth.join(d0, 'stats.txt') + ' ' + opth.join(d1, 'stats.txt') + ' &')
