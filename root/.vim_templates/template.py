#!/usr/bin/env python

"""<FILENAME>

<FILENAME> implementation on python
"""

import os
import sys
import argparse

def main(arguments):

    parser = argparse.ArgumentParser(
        description     = __doc__,
        formatter_class = argparse.RawDescriptionHelpFormatter)
    parser.add_argument('-v', '--verbose', action = 'store_true', help = 'Makes this script verbose during its operation')
    parser.add_argument('destination_host', help = 'Destination host')

    args = parser.parse_args(arguments)

    try:
        bazinga(args.destination_host)
    except Exception as e:
        print('Error: ' + str(e))
        return -1
    return 0

def bazinga(destination_host):
    # # implementation here

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))

