#!/usr/bin/env python3

"""<FILENAME>

<FILENAME> implementation on python
"""

import os
import sys
import time
import argparse
import logging

def main(args):

    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "-v",
        "--verbose",
        action="store_true",
        help="Makes this script verbose during its operation",
    )
    parser.add_argument(
        "-l",
        "--logfile",
        dest="logfile",
        default=None,
        help="log file path. Stdout will be used otherwise.",
    )

    config = parser.parse_args(args)

    if config.logfile:
        logging.basicConfig(
            level=logging.INFO,
            filename=config.logfile,
            format="%(levelname)s :: %(message)s",
        )
    else:
        logging.basicConfig(level=logging.INFO, format="%(levelname)s :: %(message)s")

    logging.info("Process started.")
    start_time = time.time()

    status = 0
    try:
        process(config)
    except Exception as e:
        logging.error(
            f"Error: Caught exception of type {type(e)} with message: {str(e)}"
        )
        status = -1

    end_time = time.time()
    elapsed_time = end_time - start_time
    logging.info(f"Execution time: {elapsed_time:.2f} seconds")
    logging.info("Process finished.")

    return status

def process(config):
    # implementation here
    logging.info("Processing ...")

if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))

