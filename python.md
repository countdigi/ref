# Python Reference

- Awesome Reference: <https://github.com/vinta/awesome-python>
- Comprehensive Python Cheetsheat: <https://gto76.github.io/python-cheatsheet/>
- Memory Profiler: <https://github.com/pythonprofilers/memory_profiler>

## Packing and Unpacking

- Packing
  - Used in function def (`def func(*args):` or `def func(**aDict):`)
  - Convert positional args into list
  - Convert keyword args into dictionary
- Unpacking
  - Used in function call (`func(*aList)` or (`func(**aDict)`)
  - Convert list into positional arguments
  - Convert dictionary into named arguments

## Dynamic Filter

```python
def build_clinvar_db(fname, ids=set(), filters=[]):
    db = {}

    with gzip.open(fname, "rt", encoding="utf-8") as f:
        header = f.readline().lstrip("#").rstrip("\n").split("\t")
        header[header.index("RS# (dbSNP)")] = "dbSNP_ID"
        header[header.index("nsv/esv (dbVar)")] = "dbVar_ID"

    Record = collections.namedtuple("Record", header)

    with gzip.open(fname, "rt", encoding="utf-8") as f:
        next(f)
        for line in f:
            fields = line.rstrip("\n").split("\t")
            record = Record(*fields)

            if ids and record.VariationID not in ids:
                continue

            if all(getattr(record, filter[0]) in filter[1] for filter in filters):
                db.setdefault(record.VariationID, []).append(record)

    return db

```

## Check Memory of Object

Also see: <https://github.com/pythonprofilers/memory_profiler>

Checking for size of simple objects is easy but you must recursively add the memory usage
so this gets difficult as the level of complexity grows, e.g.:


```python
from sys import getsizeof as g

alist = ["foo", "bar"]
adict = {"foo": [1, 2], "bar": [3, 4]}

print(g(alist) + sum(g(x) for x in alist))

print(g(adict) +
      sum(g(l) for l in adict.items()) +
      sum(g(x) for l in adict.items() for x in l))

192
672
```


## Quick Test

```python
import unittest

def test_eq(a, b):
    try:
        unittest.TestCase().assertEqual(a, b)
    except Exception as e:
        print(e)

test_eq("foo", "bar")
```

## Inline Test

```python
import unittest

def func_to_test(arg):
    if arg % 2 == 0:
        return True
    else:
        return False

class Test(unittest.TestCase):
    def setUp(self):
        self.entries = [
            ["eqt/us/tsm", 80],
            ["fix/us/bnd", 20],
        ]

    def test_a(self):
        self.assertEqual(func_to_test(2), True)

    def test_b(self):
        self.assertEqual(func_to_test(3), False)

if __name__ == "__main__":
    unittest.main()
```

## Generic Boilerplate

```python
import argparse
import inspect
import os
import sys

DEBUG = int(os.environ.get('DEBUG', 0))

def debug(msg, level=1, trace=False):
    if level <= DEBUG:
        if trace:
            file, line, function = inspect.getouterframes(inspect.currentframe(), 2)[1][1:4]
            print(f"DEBUG({file}:{line}@{function}): {msg}", file=sys.stderr)
        else:
            print(f"DEBUG: {msg}", file=sys.stderr)


def main(argv):
    parser = argparse.ArgumentParser(os.path.basename(__file__))

    mex_group = parser.add_mutually_exclusive_group()
    mex_group.add_argument("--by-barcode", action="store_true")
    mex_group.add_argument("--by-prefix", action="store_true")

    parser.add_argument("--flag", action="store_true")
    parser.add_argument("--option", metavar="OPTION_VALUE")

    parser.add_argument("parameter", metavar="PARAMETER_VALUE")

    if len(sys.argv) > 1:
        args = parser.parse_args(sys.argv[1:])
    else:
        parser.print_help()

if __name__ == "__main__":
    main(sys.argv)
```

## Argparse

<https://docs.python.org/3/library/argparse.html>

```python
import argparse

parser = argparse.ArgumentParser('tabutil', formatter_class=argparse.ArgumentDefaultsHelpFormatter)

parser.add_argument('--version', action='version', version=version())

parser.add_argument('--input-separator', action='store', dest='input_separator', default='\t')
parser.add_argument('--output-separator', action='store', dest='output_separator', default='\t')

subparsers = parser.add_subparsers()
subparsers.required = True
subparsers.dest = 'command'

col = subparsers.add_parser('col', help='col --help')

col.set_defaults(func=subcommand_col)

col.add_argument('--append', action='store', metavar='FILE', dest='append')

if len(sys.argv) > 1:
    args = parser.parse_args(sys.argv[1:])
    args.func(args)
else:
    parser.print_help()
    sys.exit(1)
```

## Time

Print current time
```python
import time
time.strftime('%FT%T') == '2018-04-23T09:36:06'
```

Convert date string to date object
```python
from datetime import datetime
dt = datetime.strptime('2018-04-23T09:36:06', '%Y-%m-%dT%H:%M:%S')
```
# ref/python.md

invert grouped map

    with open('../usermap.yaml') as f:
        d = yaml.load(f.read())

    usermap = { user: group for group in d.keys() for user in d[group]}

datetime.datetime.today().strftime('%Y-%m') == '2017-07'

autovivification

    import collections

    dict_of_lists = collections.defaultdict(list)
    dict_of_dicts = collections.defaultdict(dict)

multiprocessing

    import multiprocessing as mp
    import sys

    import pandas as pd
    import numpy as np

    df = pd.DataFrame({'a': [1, 2, 3, 4], 'b': [5, 6, 7, 8]})

    def f(df):
        return df.a.values + df.b.values

    pool = mp.Pool(4)

    print(pool.map(f, np.array_split(df, 4)))

    # outputs: [array([6]), array([8]), array([10]), array([12])]

main-wrapper:

    if __name__ == '__main__':
        main()


    import seaborn as sns
    subset = tz_counts[:10]
    sns.barplot(y=subset.index, x=subset.values)

---

    time_zones = [rec['tz'] for rec in records if 'tz' in rec]

---

    from collections import Counter
    counts = Counter(time_zones)
    counts.most_common(10)

---

    import collections

    test_db = collections.OrderedDict([
        ('a', { 'chr': 'X',  'pos': '1234' }),
        ('d', { 'chr': '9', 'pos': '95060' }),
        ('c', { 'chr': '1',  'pos': '5060' }),
        ('e', { 'chr': '10', 'pos': '9490' }),
        ('b', { 'chr': 'X',  'pos': '123' }),
    ])

    print(sorted(test_db.values(), key=lambda v: (v['chr'], v['pos'])))


---

    import os
    import sys
    import pprint

    print os.environ['HOME']

    myself = os.path.abspath(sys.argv[0])

    base = os.path.dirname(myself)

    pprint.pprint(data)

    sys.stderr.write('Message: {}\n'.format(message))

## Strings

    s = "foo bar"
    s = 'foo bar'
    s = r"c:\dir\new"                     # raw (== 'c:\\dir\\new')
    s = """Hello
          world"""
    s.join(" baz")
    n = len(s)
    "Ala ma {} psy i {} koty".format(2,3)
    "Square root of 2 is equal to {:.2f}".format(math.sqrt(2))

## Lists

    L = [1, 2, 3, 4, 5]
    L[0]                                  # single position
    L[0:3]                                # the first three elements
    L[-2:]                                # the last two elements
    L[1:4] = [7,8]                        # substitute
    del L[2]                              # remove elements
    L.append(x)                           # x is a value
    L.remove(x)
    L.extend(L2)                          # or: L3 = L + L2
    L.pop()                               # simple stack (with append)
    L.sort()
    x in L                                # does L contain x?
    L.index(x)                            # index of the first occurrence
    [x*2 for x in L if x>2]               # list comprehensions
    Tuples:

## Dictionaries

    D = {'f1': 10, 'f2': 20}              # dict creation
    D = dict(f1=10, f2=20)

    keys = ('a', 'b', 'c')
    D = dict.fromkeys(keys)               # new dict with empty values

    for k in D: print(k)                  # keys
    for v in D.values(): print(v)         # values
    for k, v in D.items():                # tuples with keys and values
    list(D.keys())                        # list of keys
    sorted(D.keys())                      # sorted list of keys

    D = {}
    D[(1,8,5)] = 100                      # 3D sparse matrix
    D.get((1,8,5))
    D.get((1,1,1), -1)


## Sets

    S = {1,3,5}
    L = [1, 3, 1, 5, 3]
    S = set(L)                            # set([1, 3, 5])
    if (3 in S):
    S1+S2, S1-S2, S1^S2, S1|S2

## Loops

    for x in range(6):                    # 0, 1, 2, 3, 4, 5
    for x in range(1,6):                  # 1, 2, 3, 4, 5
    for x in range(1,6,2):                # 1, 3, 5

    for k,v in D.items():
        print("D[{}]={}".format(k,v))     # D[f1]=10  D[f2]=20

    L = [1, 3, 5]
    for i,v in enumerate(L):              # (index,value)
    for x,y in zip(L1,L2):                # returns tuples
    for i in sorted(set(L)): print(i)     # sorted set from a list
    for x in reversed(L1):

## Pip install local package

    $ pip install pip --upgrade

    $ pip install mypackage --no-index --find-links file:///srv/pkg/mypackage

    $ pip install --download-cache $HOME/depot pymongo

    $ ~/.dx/venv/bin/pip install --download-cache ~/.dx/cache/python -r requirements.txt

## File I/O

    with open(filename) as f:
        for line in f:
            a, b, c, d = str.split(line.strip(), '\t')

## Process (module subprocess)

    res = subprocess.call(["hostname","-f"], stderr=subprocess.DEVNULL)
    res = subprocess.call("ps axu | grep ^root", shell=True)
    output = subprocess.check_output(["mycmd", "myarg"],universal_newlines=True)

## Module os:

    os.pathsep    os.sep          os.pardir       os.curdir       os.linesep

    os.startfile("index.html")
    os.popen("ps ax").readlines()
    os.listdir("/usr/local")              # ['bin', 'etc', ...]
    os.glob("*.txt")                      # ['test.txt', 'out.txt', ...]

## Module os.path

    os.path.split("/usr/bin/go.sh")       # ('/usr/bin', 'go.sh')
    os.path.join("/usr/bin", "go.sh")     # '/usr/bin/go.sh'
    os.path.splitext("/usr/bin/go.sh")    # ('/usr/bin/go', '.sh')
    os.path.abspath("../bin/go.sh")       # '/usr/bin/go.sh'
    os.path.isfile("go.sh")

    for (dir, subdirs, files) in os.walk("/tmp"):
        for f in files: print(f)

## Exceptions

    try:
        raise TypeError("arg")
    except (RuntimeError, NameError):
        pass                              # empty instruction (NOP)
    except:
        info = sys.exc_info()
        print(info[0])
        print(info[1])
        traceback.print_tb(info[2])
        raise
    else:
        ...                               # no exception but before finally
    finally:                              # on the way out
        ...                               # unhandled exc, release resources

---

    print("Error!", file=sys.stderr, flush=True)

---

    import yaml

    with open(filename) as f:
        data = yaml.load(f)

## Parsing Arguments

    import argparse
    parser = argparse.ArgumentParser('program_name')
    parser.add_argument('hostspec', nargs='+', metavar='HOSTSPEC')
    options = parser.parse_args(argv)
    debug_pp("options", options)

decorators
  - https://wiki.python.org/moin/PythonDecoratorLibrary
  - Python Decorators I: http://www.artima.com/weblogs/viewpost.jsp?thread=240808
  - Python Decorators III: A Decorator Build System (http://www.artima.com/weblogs/viewpost.jsp?thread=241209)

decorator-example:

    from functools import wraps

    def tags(tag_name):
        def tags_decorator(func):
            @wraps(func)
            def func_wrapper(name):
                return "<{0}>{1}</{0}>".format(tag_name, func(name))
            return func_wrapper
        return tags_decorator

    @tags("p")
    def get_text(name):
        return "Hello " + name

    print get_text.__name__ # get_text
    print get_text.__doc__ # returns some text
    print get_text.__module__ # __main__

decorator-toggle:

    def benchmark(func):
        if not <config.use_benchmark>:
            return func
        def decorator():
        # fancy benchmarking
        return decorator

decorators
  - https://wiki.python.org/moin/PythonDecoratorLibrary
  - Python Decorators I: http://www.artima.com/weblogs/viewpost.jsp?thread=240808
  - Python Decorators III: A Decorator Build System (http://www.artima.com/weblogs/viewpost.jsp?thread=241209)

decorator-example:

    from functools import wraps

    def tags(tag_name):
        def tags_decorator(func):
            @wraps(func)
            def func_wrapper(name):
                return "<{0}>{1}</{0}>".format(tag_name, func(name))
            return func_wrapper
        return tags_decorator

    @tags("p")
    def get_text(name):
        return "Hello " + name

    print get_text.__name__ # get_text
    print get_text.__doc__ # returns some text
    print get_text.__module__ # __main__

decorator-toggle:

    def benchmark(func):
        if not <config.use_benchmark>:
            return func
        def decorator():
        # fancy benchmarking
        return decorator

snippet:

    #!/usr/bin/env python

    import re

    with open('grub') as f:
        for line in f.readlines():
            text = line.strip()
            if re.match(r'^GRUB_CMDLINE', text):
                p = re.compile('rd\.md\.uuid=[^\s]*')
                m = p.findall(text)
                print(' '.join(sorted(m)))

# Python


## Number String Conversion

Formatting an integer into 5 digit zero filled decimal:

    print '{0:05d}'.format(x)

## Nested list comprehension

     words = [ 'one two', 'three four' ]

     [letter
      for word in words
      for letter in word.split(' ')] == ['one', 'two', 'three', 'four']

      ' '.join(''.join(MORSE_CODE[letter] for letter in word.split(' '))
                                          for word in morseCode.strip().split('   '))


## mmap

    import mmap
    with open('huge_file.txt') as f:
        mm = mmap.(f.fileno(), 0)
        print(mm[-1000:]) # print last 1000 bytes


## invert grouped map

    with open('../usermap.yaml') as f:
        d = yaml.load(f.read())

    usermap = { user: group for group in d.keys() for user in d[group]}

## time

    import time
    time.strftime('%FT%T') == '2018-04-23T09:36:06'

---

    from datetime import datetime
    date_obj = datetime.strptime('2018-04-23T09:36:06', '%Y-%m-%dT%H:%M:%S')

## main function example

    import argparse
    import os
    import sys

    def main(argv):
        p = argparse.ArgumentParser(description='Description')

        p.add_argument('--version', action='version', version='%(prog)s 2.0')

        # Option with argument

        p.add_argument('--value', dest='value', action='store',
                       default='foo', help='Explanation of option')

        # Flag

        p.add_argument('--feature', dest='feature', action='store_false',
                       default=True, help='Explanation of flag')

        # Positional argument

        p.add_argument('filename', metavar='<fname>', type=str)

        args = parser.parse_args(argv)


    BASE = os.path.join(os.path.dirname(os.path.abspath(__file__)), '..')

    if __name__ == '__main__':
        main(sys.argv[1:])

## slurping tab-separated file

    with open(fname) as f:
        for line in f:
            fields = str.strip().split('\t')
            a, b, c, d =  fields

## os.path

    os.path.split("/usr/bin/go.sh")       # ('/usr/bin', 'go.sh')
    os.path.join("/usr/bin", "go.sh")     # '/usr/bin/go.sh'
    os.path.splitext("/usr/bin/go.sh")    # ('/usr/bin/go', '.sh')
    os.path.abspath("../bin/go.sh")       # '/usr/bin/go.sh'
    os.path.isfile("go.sh")


## os.walk

    def print_dirs(path):
        for (dirname, subdirs, files) in os.walk(path):
            print(dirname + '/')
            for subdir in subdirs:
                print_dirs(subdir)
            for f in files:
                print(os.path.join(dirname, f))

    print_dirs('tmp')

## exceptions

    try:
        raise TypeError("arg")
    except (RuntimeError, NameError):
        pass                              # empty instruction (NOP)
    except:
        info = sys.exc_info()
        print(info[0])
        print(info[1])
        traceback.print_tb(info[2])
        raise
    else:
        ...                               # no exception but before finally
    finally:                              # on the way out
        ...                               # unhandled exc, release resources

## pretty print

    import pprint
    pp = pprint.PrettyPrinter(width=20, depth=2)

    pp.pprint(a)

    {'foo': [1, 2, 43],
    'one': 2,
    'two': 3}

## decorators

    from functools import wraps

    def tags(tag_name):
        def tags_decorator(func):
            @wraps(func)
            def func_wrapper(name):
                return "<{0}>{1}</{0}>".format(tag_name, func(name))
            return func_wrapper
        return tags_decorator

    @tags("p")
    def get_text(name):
        return "Hello " + name

    get_text('foo') == '<p>Hello foo</p>'

## decorator toggle

    def benchmark(func):
        if not <config.use_benchmark>:
            return func
        def decorator():
            # fancy benchmarking
        return decorator

## regular expression

Good Cheatsheet: <https://www.dataquest.io/blog/large_files/python-regular-expressions-cheat-sheet.pdf>

Note `r'<regex>'` maintains literals for metacharacters like `\s` or `\w` which would otherwise be escaped by python string.

    import re

    contactInfo = 'Doe, John: 555-1212'
    match = re.search(r'\w+, \w+: \S+', contactInfo)

    m.group(0) == 'Doe, John: 555-1212'
    m.group(1) == 'Doe'
    m.group(2) == 'John'
    m.group(3) == '555-1212'

## pickle example

Useful for bioniformatics files like `<SNPdb>.bcp.gz` with hundreds of millions of lines but
we only care about a subset that matches a criteria.
The next run will be much faster by loading cached result of the subset.

    import gzip
    import os
    import pickle

    db = {}

    if os.path.isfile(cache_fname):
        with open(cache_fname, 'rb') as f:
            db = pickle.load(f)
    else:
        with gzip.open(data_fname, 'rt', encoding='utf-8') as f:
            for line in f:
                k, *v = line.strip().split('\t')
                if meets_criteria(k, v):
                    db[k] = v

        if cache_fname:
            with open(cache_fname, 'wb') as f:
                pickle.dump(db, f)




