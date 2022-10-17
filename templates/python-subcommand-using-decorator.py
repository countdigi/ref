#!/usr/bin/env python3

import argparse
import namedtuple
import os
import re
import sys

#----------------------------------------------------------------------------------------------------
# functions
#----------------------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------------------
# cli
#----------------------------------------------------------------------------------------------------

cli = argparse.ArgumentParser(
    formatter_class=lambda prog: argparse.HelpFormatter(prog, max_help_position=28, width=132))

subparsers = cli.add_subparsers(dest="subcommand")

def argument(*name_or_flags, **kwargs):
    return ([*name_or_flags], kwargs)

def subcommand(args=[], parent=subparsers):
    def decorator(func):
        name = func.__name__.replace("sub_", "").replace("_", "-")
        parser = subparsers.add_parser(name, help=func.__doc__)
        for arg in args:
            parser.add_argument(*arg[0], **arg[1])
        parser.set_defaults(func=func)
    return decorator

#----------------------------------------------------------------------------------------------------

@subcommand([
    argument("--exclude-barcodes", metavar="file[,file...]", help="Filename(s) of barcodes to exclude"),
    argument("bundle_prefix"),
])
def sub_concat_barcodes(args):
    "Print commands to concatenate all files with the same barcode"
    pass

#----------------------------------------------------------------------------------------------------
# main
#----------------------------------------------------------------------------------------------------

if __name__ == "__main__":
    cli.add_argument("--option", action="store_true", help="Set option")

    args = cli.parse_args()

    if args.subcommand is None:
        cli.print_help()
    else:
        args.func(args)
