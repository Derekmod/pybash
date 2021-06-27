
from datetime import datetime
import os
import sys
import subprocess
import time
import math


TIMER_OVERHEAD = 1.5


def main():
    cmd = sys.argv[1:]
    formatted = format_cmd(cmd)
    # print(formatted)
    sp = subprocess.Popen(["/bin/bash", "-i", "-c", formatted])
    time_start = datetime.now()
    sp.communicate()
    # print("test")
    time_end = datetime.now()
    duration = (time_end - time_start).total_seconds() - TIMER_OVERHEAD
    print("\nDuration: %.1f seconds" % duration)
    pass


def format_cmd(cmd):
    ret = cmd[0]
    for arg in cmd[1:]:
        ret += f' "{arg}"'
    return ret


if __name__ == "__main__":
    main()
