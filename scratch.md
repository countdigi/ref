# scratch


Singularity forked but I have a feeling the apptainer version will be the future as it is under the Linux Foundation Stewardship.
- <https://github.com/apptainer/apptainxer>


./mconfig --without-suid

Apptainer uses SIF files

SIF - Standard Interchange Format, called SIF, is a geospatial data exchange format. A standard or neutral format used to move graphics files between DOD Project 2851 and is currently codified in Content Standard for Digital Geospatial Metadata maintained by the Federal Geographic Data Committee.

If you want to have the best performance for unprivileged mounts of SIF files for multi-core applications, you can optionally install an improved performance version of `squashfuse_ll`.

Apptainer Dependencies on CentOS/RHEL:
```
# Install basic tools for compiling
sudo yum groupinstall -y 'Development Tools'

# Ensure EPEL repository is available
sudo yum install -y epel-release

# Install RPM packages for dependencies
sudo yum install -y \
    libseccomp-devel \
    squashfs-tools \
    squashfuse \
    fuse-overlayfs \
    fakeroot \
    /usr/*bin/fuse2fs \
    cryptsetup \
    wget git
```


## Deep Learning Illustrated: A Visual Interactive Guide to Artificial Intelligence

Hubel and Wiesel discovered that neurons receiving input from the eye are in general most responsive
to simple, straight edges (simple neurons). A given simple neuron responds optimally to an edge
at a particular, specific orientation. A large group of simple neuron together represent all
360 degrees of orientation. These simple neurons then pass the information on to more complex
neurons. A given complex neuron receives information that has already been processed by several
simple cells, so it is positioned to recombine multiple line orientations into a more complex
shape like a corner or a curve.

Through many hierarchically organized layers of neurons feeding information into increasingly
higher-order neurons, gradually more complex visual stimuli can be represented by the brain.

In the late 1970s the Japanese electrical engineer Kunihiko Fukushima proposed an analogous
architecture for machine vision, which he named the neocognitron.


- Fukushima referred to Hubel and Wiesel’s work explicitly in his writing. Indeed, his paper
  refers to three of their landmark articles on the organization of the primary visual cortex,
  including borrowing their “simple” and “complex” cell language to describe the first and
  second layers, respectively, of his neocognitron.

- By arranging artificial neurons in this hierarchical manner, these neurons—like their
  biological inspiration generally represent line orientations in the cells of the
  layers closest to the raw visual image, while successively deeper layers represent successively
  complex, successively abstract objects. To clarify this potent property of the neocognitron and
  its deep learning descendants, we go through an interactive example at the end of this chapter
  that demonstrates it.

wHILE THE NEOcognitron was capable of, for example, identifying handwritten characters,  the
accuracy and efficiency of Yann LeCun and Yoshua Bengio’s LeNet-5 model made it a significant
development. LeNet-5’s hierarchical architecture built on Fukushima’s lead and the biological
inspiration uncovered by Hubel and Wiesel. In addition, LeCun and his colleagues benefited
from superior data for training their model, faster processing power, and, critically, the
back-propagation algorithm.

Paris-born Yann LeCun is one of the preeminent figures in artificial neural network and deep
learning research. LeCun is the founding director of the New York University Center for Data
Science as well as the director of AI research at the social network Facebook.

Yoshua Bengio is another of the leading characters in artificial neural networks and deep
learning. Born in France, he is a computer science professor at the University of Montreal and
codirects the renowned Machines and Brains program at the Canadian Institute for Advanced Research.

Backpropagation, often abbreviated to backprop, facilitates efficient learning throughout the
layers of artificial neurons within a deep learning model. Together with the researchers’
data and processing power, backprop rendered LeNet-5 sufficiently reliable to become an early
commercial application of deep learning: It was used by the United States Postal Service to
automate the reading of ZIP codes written on mail envelopes.

In LeNet-5, Yann LeCun and his colleagues had an algorithm that could correctly predict the
handwritten digits that had been drawn without needing to include any expertise about handwritten
digits in their code.

The traditional machine learning approach is characterized by practitioners investing the bulk of
their efforts into engineering features. This feature engineering is the application of clever,
and often elaborate, algorithms to raw data in order to preprocess the data into input variables
that can be readily modeled by traditional statistical techniques.

These techniques—such as regression, random forest, and support vector machine—are seldom
effective on unprocessed data, and so the engineering of input data has historically been a prime
focus of machine learning professionals.

Feature engineering—the transformation of raw data into thoughtfully transformed input
variables—often predominates the application of traditional machine learning algorithms. In
contrast, the application of deep learning often involves little to no feature engineering,
with the majority of time spent instead on the design and tuning of model architectures.

In general, a minority of the traditional ML practitioner’s time is spent optimizing ML models
or selecting the most effective one from those available. The deep learning approach to modeling
data turns these priorities upside down. The deep learning practitioner typically spends little to
none of her time engineering features, instead spending it modeling data with various artificial
neural network architectures that process the raw inputs into useful features automatically.


# Reference Stack

## Linux Kernel

When the kernel stops the execution of a process, it saves the current contents of several processor registers in the process descriptor.
- Instruction Pointer
- Stack and Base Pointer
- General Purpose
- Floating Point
- Process Control (Processor Status Word) - containing information about the CPU state
- Memory Management - used to keep track of the RAM accessed by the process

## Linux Definitions

- Process
  - An instance of a program in execution
  - The execution context of a running program
  - A process executes a single sequence of instructions in an address space which is the set of memory addresses that the process is allowed to reference

## Linux Concepts

- File
  - An information container structured as a sequence of bytes.
  - Only userspace programs interpret file structure (not the kernel)

- Directory
  - Special type file containing pointers to other files and directories

- Inode
  - Attributes defined by POSIX
    - Device ID
    - Inode Number
    - Type (Regular file, Directory, Symbolic Link, Block Device, Character Device,  Pipe,  Named Pipe, Socket)
    - Hard Link Counter
    - Length
    - User ID
    - Group  ID
    - Timestamps: (atime - last access, mtime - last modify, ctime - last inode change)
    - Access permissions (u, g, o) (rwx) plus suid sgid and sticky bits

- File Descriptor
  - Represents an interaction between a process and an opened file
  - While an open file object contains data related to that interaction
  - The same open file object may be identified by several file descriptors in the same process

- System Call
  - Each system call sets up the group of parameters that identifies the process request and then executes the hardware-dependent CPU instruction to switch from User Mode to Kernel Mode.

- Virtual Memory
  -  Main ingredient is notion of virtual address space.
  - When process uses virtual address the kernel and the MMU cooperate to find the actual physical location of the requested memory item
  - Today's CPUs include hardware circuits that automatically translate the virtual addresses into physical ones using Page Tables (usually 4K or 8K)

## Datascience Hierarchy of Needs

- AI, Deep Learning
- A/B Testing, Experimentation, Simple ML Algorithms
- Analytics, Metrics, Segments, Aggregates, Features, Training Data
- Cleaning, Anomaly Detection, Prep
- Reliable Data Flow, Infrastructure, Pipelines, ETL, Structured and Unstructured Data Storage
- Instrumentation, Login, Sensors, External Data, User Generated Content

## Statistics

Regression Analysis
- Set of statistical processes for estimating the relationships among variables.
- How dependent variable (criterion) changes when any one of independent variables is varied
- Includes many techniques for modeling and analyzing several variables, when the focus is on the relationship between:
  - Dependent variable
  - One or more independent variables or predictors

Null Hypothesis H(not) in Inferential Statistics
- General statement or default position of no relationship between two measured phenomena or no association among groups
- Generally assumed to be true until evidence indicates otherwise (innocent until proven guilty)

Hypothesis Testing
- Type I error - Rejection of a true null hypothesis (false positive)
- Type II error - Non-rejection of a false null hypothesis (false negative)

Correlation does not imply causation
- Refers to the inability to legitimately deduce cause-and-effect between two variables solely on observed association
- "Cum hoc ergo propter hoc"

Central Tendencies
- Mean
- Median
- Quantile - represents the value under which a certain percentage of the data lies  (median is 50%)

Definitions
- Covariance - how two variables vary in tandem from their means
- Dispersion - refers to measures of how spread out our data is
- Range - The difference between the largest and smallest element
- Variance - How far a set of random numbers are spread out from their average value
- Population - any specific collection of objects of interest
- Sample - any subset or sub-collection of the population
- Census - when the sample consists of the whole population
- Measurement - a number or attribute computed for each member of a population or of a sample
- Sample Data - the collective measurements of a Sample's elements
- Parameter - A number that summarizes some aspect of the population as a whole
- Statistic - A number computed from the sample data

Degrees of Freedom
- A coin toss has 1 degree of freedom. If you get tails, you only need one piece of information to know that we didn't get heads.
- Categorical degrees of freedom = number of categories - 1 (red, green, yellow has 2 degrees of freedom)
- If you know the mean, last value in sample no longer independent since it can be derived based on all other values
- For tests like T or Chi-squared the more numbers you calculate reduces the degrees of freedom
# Whiteboard


Jargon
- Transfer Learning - Using a pretrained model for a task different to what it was originally trained for
- Fine Tuning - Transfer learning technique where weights of pretrained model are updated by training for a different task
  - Use one epoch to fit just those parts of model necessary to get the new random head to work w/ new dataset


Paperspace

```python
from fastai.vision.all import *

path = untar_data(URLs.PETS) / "images"

def is_cat(x): return x[0].isupper()

dls = ImageDataLoaders.from_name_func(
    path, get_image_files(path), valid_pct=0.2, seed=42, label_func=is_cat, item_tfms=Resize(224))

learn = cnn_learner(dls, resnet34, metrics=error_rate)
learn.fine_tune(1)
```
Cat/Dog Timings w/ Paperspace Gradient Tesla K80 Instance w/ 12GB of GPU Mem
```
epoch  train_loss  valid_loss  error_rate  time
0      0.162940    0.017871    0.006766    03:11
epoch  train_loss  valid_loss  error_rate  time
0      0.065747    0.027014    0.007442    02:33
```

`Path('/storage/data/oxford-iiit-pet/images')` - So it stores in persistent storage on Paperspace

`learn.export("/storage/model-1-cats-dogs.pkl")`

`du -sh /storage` - 3.2G

-----------------------------------------------------------------------------------------------------

```python
path = untar_data(URLs.CAMVID_TINY)

dls = SegmentationDataLoaders.from_label_func(
    path, bs=8, fnames = get_image_files(path / "images"),
    label_func = lambda o: path / "labels" / f"{o.stem}_P{o.suffix}",
    codes = np.loadtxt(path / "codes.txt", dtype=str)
)

learn = unet_learner(dls, resnet34)

learn.fine_tune(8)
```
Output:
```
epoch  train_loss  valid_loss  time
0      2.641862    2.140568    00:02

epoch  train_loss  valid_loss  time
0      1.624964    1.464210    00:02
1      1.454148    1.284032    00:02
2      1.342955    1.048562    00:02
```

```python
learn.show_results(max_n=6, figsize=(7,8))
```

-----------------------------------------------------------------------------------------------------

Note: We had to remove `/storage/data/imdb_tok` to get this to work (something corrupt inside)

```bash
!/bin/rm -rf /storage/data/imdb_tok
```

```python
from fastai.text.all import *

dls = TextDataLoaders.from_folder(untar_data(URLs.IMDB), valid='test', bs=32)
learn = text_classifier_learner(dls, AWD_LSTM, drop_mult=0.5, metrics=accuracy)
learn.fine_tune(4, 1e-2)
```

# vim: tabstop=4 shiftwidth=4 softtabstop=0 expandtab paste
# ref

## Luks Open

```
sudo cryptsetup luksOpen /dev/sdc1 scratch
sudo mount /dev/mapper/scratch /mnt
```

## Bash-Misc

Get the last command line argument (space before `-1` necessary):
```bash
echo "${@: -1}"
```

Close shell keeping all subprocess running.
```bash
disown -a && exit
```

## Bash-Startup

3 Types of Shells: Login, Interactive, Non-Interactive

Login Shell (SSH login, xterm with login shell option `-ls`, bash run with `--login|-l` option)
- Test:
  - `shopt -q login_shell`
- Startup
  - Source: `/etc/profile`
  - Source first found: `~/.bash_profile`, `~/.bash_login`, `~/.profile`

Interactive Shell
- Test:
  - `! shopt -q login_shell && echo $- | grep -q i`
- Startup
  - Source: `~/.bashrc`

Non-Interactive Shell
- Test: `! shopt -q login_shell && echo $- | grep -qv i`
- Startup
  - Source `${BASH_ENV}` if set

## Bash-Techniques

Intercept specific options and pass on the remainder:
```bash
argv=()

for arg in "$@"; do
  if [[ $arg = '-w' || $arg = '--wide' ]]; then
    format_opt="..."
  else
    argv=("${argv[@]}" "${arg}")
  fi
done

set -- "${argv[@]}" # Restore "$@" from argv
```

Find elements in list
```bash
  in_list() {
    local item=$1 list=$2
    [[ ${list} =~ (^|[[:space:]])${item}($|[[:space:]]) ]]
  }
```

## Git-Reset

All modes change `HEAD` to point to `<commit>`:

    git reset [--mixed {default} | --hard | --soft] <commit>

- Mixed: Resets index only. Changed files preserved in working tree but not marked for commit
- Hard: Resets index and working tree. Any changes to tracked files since `<commit>` are discarded
- Soft: Preserves index and working tree leaving changed files in "Changes to be commited"

To unstage all changes staged in the index (implies `git reset --mixed HEAD`) but keep them in working tree:

    git reset

If you have 4 local commits and you want to squash these into one, an easy way is:

    git reset --soft HEAD~4
    git commit --amend 'Commit message for consolidated commits'

## Git-WorkingDirectory

A file in the working directory may be in one of the following states:

- **Untracked** - File was never staged or committed (not in repository)
- **Tracked** - File commited and not staged (**Not shown in status**)
- **Staged** - File staged to be included in next commit
- **Modified** - File changed but change is not staged



## Python-Memory

Sizes (64-bit)
- PyObject - 16 bytes
- PyASCIIObject - 42 bytes
- PyCompactUnicodeObject - 72 bytes
- PyLongObject - 32 bytes

CPython memory allocator sites atop the system memory allocator (pymalloc). It only allocates memory blocks up to 256KB otherwise uses the os.

- Arenas - 256KB each - created with `mmap()` to reduce heap fragmentation
- Pools - 64 x 4KB in each arena - 32 classes of pools - containing uniform sized blocks at 16 bytes, 32, bytes, up to 512 byte
- Blocks - Contained in the Pools

- `id(a)` - yields the memory address for the object a


Examples:
```python
sys.getsizeof("") -> 49
sys.getsizeof("foo") -> 52
sys.getsizeof(list()) -> 72
sys.getsizeof(list((None,))) -> 104
sys.getsizeof(list((None, None))) -> 112 # Each element adds 8 bytes (plus size of element)
sys.getsizeof(dict(foo=None)) -> 248
```

## R

### Misc

- Import, Tidy, Iterate(Transform, Visualize, Model), Communicate
- `file.path(Sys.getenv('HOME'), 'work', 'foo') -> "/home/jsmith/work/foo"`
- `paste('foo', 'bar', sep=':') -> "foo:bar"`
- `paste0('foo', 'bar') -> "foobar"`
- `cat(paste('hello', 'world'), '\n')` # For printing raw strings without row numbers
- `data1 <- read.csv(url("http://stat.columbia.edu/~rachel/datasets/nyt1.csv"))`

### GGPlot

- Cheatsheet: <https://github.com/rstudio/cheatsheets/blob/master/data-visualization-2.1.pdf>
- ggplot2 implements the grammar of graphics (“The Layered Grammar of Graphics”, <http://vita.had.co.nz/papers/layered-grammar.pdf>)
- `ggplot2::mpg` - test data containing US EPA data on 38 models of car
- facets - subplots that each display one subset of the data, e.g. `+ facet_wrap(~ class, nrow=2)` or `+ facet_grid(drv ~ cyl)`
- `geom_functions`: `geom_smooth`, `geom_point`
- Model:
  ```
  ggplot(data=<DATA>) +
    (<GEOM_FUNCTION>(mapping=aes(<MAPPINGS>), stat=<STAT>, position=<POSITION>) +
    <COORDINATE_FUNCTIONS> +
    <FACET_FUNCTIONS> +
    <SCALE_FUNCTIONS> +
    <THEME_FUNCTION>
  ```

```R
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
```

### Packages

Fail if any package install fails:
```R
withCallingHandlers(install.packages("notapackage"), warning=function(w) stop(w))
```

List installed packages and versions:
```R
ip <- as.data.frame(installed.packages()[,c(1,3:4)])
rownames(ip) <- NULL
ip <- ip[is.na(ip$Priority), 1:2, drop=FALSE]
print(ip, row.names=FALSE)
```

`devtools::install_github("tidyverse/ggplot2")`

### Parallel

```
library(parallel)

cl = makeForkCluster(4)
output <- clusterApply(cl, 1:8, function(x) x + 1)
output_2 <- clusterApply(cl, 1:8, function(x) Sys.getpid())
output_2
```

### Rocker
- Website: <https://www.rocker-project.org>
- Github: <https://github.com/rocker-org>
- Docker Images:
  - r-ver (Version-stable base R and src build tools) - <https://hub.docker.com/r/rocker/r-ver/tags>
  - rstudio (Adds rstudio) - <https://hub.docker.com/r/rocker/rstudio/tags>
  - tidyverse (Adds tidyverse and devtools) - <https://hub.docker.com/r/rocker/tidyverse/tags>
  - verse (Adds tex and publishing related packages) - <https://hub.docker.com/r/rocker/verse/tags> (PREFERRED)



## UNIX-Time

- `/usr/bin/time --format='\n/usr/bin/time elapsed:%E mem:%MK cpu:%P cmd:%C\n'`


## Unicode

- Unicode is a character set, UTF-8 is an encoding
- Unicode is 1.1M code points (110K assigned)
- A character set is a list of characters with unique numbers (these numbers are sometimes referred to as "code points")
- UTF-8 8-bit Unicode Transformation Format
  - Developed by Ken Thompson and Rob Pike
  - Each character can range from 1 to 4 bytes
  - 1 byte encoding is compatible with 127-bit ASCII
  - Multi-byte
    - 1 byte: 07 bits - `U+0000 to U+007F` (`0xxxxxxx`)
    - 2 byte: 11 bits - `U+0080 to U+07FF` (`110xxxxx 10xxxxxx`)
    - 3 byte: 16 bits - `U+0800 to U+FFFF` (`1110xxxx 10xxxxxx 10xxxxxx`)
    - 4 byte: 21 bits - `U+10000 to U+10FFFF` (`11110xxx 10xxxxxx 10xxxxxx 10xxxxxx`)

In python3:
```python
s = "Hi \u2119\u01b4\u2602\u210c\xf8\u1f24"
type(s)
str

b = b"Hello World"
type(b)
bytes
```


## Vim

- File name modifiers: `%:.` (filename relative to cwd) `%:p` (full path) `%:h` (head of filename) `%:t` (tail of filename)
- `expand('%')`

## ZZ-Notes

- Open addressing (closed hasing) <https://en.wikipedia.org/wiki/Open_addressing> - A method of collision resolution in hash tables resolved by
  probing or searching through alternate locations in the array (the probe sequence) until either
  the target record is found, or an unused array slot is found, which indicates that there is no
  such key in the table. Well-known probe sequences include:
  - Linear Probing - in which the interval between probes is fixed — often set to 1
  - Quadratic Probing - in which the interval between probes increases quadratically (hence, the indices are described by a quadratic function)
  - Double Hashing - in which the interval between probes is fixed for each record but is computed by another hash function

Probabilistic Data Structures
- Bloom Filter - Test if an element is definitely NOT a member of a set (e.g. articles a user has not read, akamai one-hit wonders)
- HyperLogLog - Approximate number of distinct elements
- Count–min Sketch - Approximate the frequency of an event in stream of events
- MinHash - Estimate how how similar two sets are

Machine Learning
- Supervised - Apply what has been learned past (labels) to new data using to predict future events
- Unsupervised - Infer a function to describe a hidden structure from unlabeled data
- Semi-supervised - Use small amount of labeled data and a large amount of unlabeled data
- Reinforcement - Interacts with its environment by producing actions and discovers errors or rewards

LLVM (Low Level Virtual Machine) - A backend compiler meant to build compiler on top of it. It
deals with optimizations and production of code adapated to the target architecture

CLang - A front end which parses C, C++, and Objective C code and translates it into a representation suitable for LLVM

Backus-Naur Form - Anotation technique for context-free grammars

Context-Free Grammar has four components:
- A set of terminal symbols (tokens)
- A set of nonterminals (syntactic variables)
- A set of productions (normterminal -> [terminal|nonterminal]...)
- A designation of one of the nonterminals as the start symbol
- E.g. A list of digits separated by plus or minus signes (9 - 5 + 2)
  ```
  list -> list + digit
  list -> list - digit
  list -> digit
  digit -> 0|1|2|3|4|5|6|7|8|9
  ```

An Abstract Syntax Tree compresses out all the unnecessary information from the Syntax Parse Tree.  Certain tokens such as
parenthesis, etc. are no longer needed because the tree implicitly communicates that information. Suppress details of the E.g.:
```
plus -> 5 |
          -> plus -> 2 3
```

---------

Recursive Descent Example
```
// Grammar
// E -> T | T + E
// T -> int | int * T | (E)

bool term(TOKEN tok) { return *next++ == tok; }

bool E1() { return T(); }
bool E2() { return T() && term(PLUS) && E(); }

bool E() { TOKEN *save = next; return (next = save, E1()) || (next = save, E2()); }

bool T1() { return term(INT); }
bool T2() { return term(INT) && term(TIMES) && T(); }
bool T3() { return term(OPEN) && E() && term(CLOSE); }

bool T() { TOKEN *save = next; return (next = save, T1()) || (next = save, T2()) || (next = save, T3()); }
```

A problem arises w/ recursive descent and the code `int * int`
- The parse gets rejected because we really needed to backtrack even though we never failed and try the second production of T
- We need full backtracking to have a general recursive descent algorithm
- See "left factoring"
- Recursive Descent parsing does not work with left-recursive grammars

Predictive Parser
- Like recursive descent but parser can "predict" which production to use
  - By looking at the next few tokens
  - No backtracking
  - They accept LL(k) grammars (First L is left-to-right, Second L is left-most derivation, k=n tokens lookahead usually 1 so LL(1))

---------

- Example
  ```
  bool term(TOKEN tok) { return *next++ == tok; }
  ```
- For production `E -> T`: `bool E1() { return T(); }`
- For production `E -> T + E`: `bool E2() { return T() && term(PLUS) && E(); }`
- For all productions of E (with backtracking):
  ```
  bool E() {
    TOKEN *save = next;
    return (next = save, E1()) || (next = save, E2()); } /* first next = save for uniformity, not needed */
  }
  ```

----

Linear Regression - A linear approach to modeling the relationship between a dependent variable and one or more independent
variables.

Dependent variable - values are studied under the hypothesis that they depend, by some law or rule (e.g. by a mathematical
function) on the values of other variables.

Independent variable - not seen as depending on any other viarable in the scope of the experiment (e.g. time, space, density, mass)

R squared is the proportion of variation in the response variable explained by the regression model. The values of R squared
range from 0 to 1; small values indicate that the model does not fit the data well.

R,  the  multiple  correlation  coefficient,  is  a  measure  of  the  strength  of  the linear  relationship  between  the
response  variable  and  the  set  of  explanatory variables.  It  is  the  highest  possible  simple  correlation  between
the  response variable  and  any  linear combination  of  the  explanatory  variables


----

Boolean Identities
```
- P == P | P  - Idempotence of OR
- P == P & P - Idempotence of AND
- P | Q == Q | P - Commutativity of OR
- P & Q == Q & P - Commutativity of AND
- (P | Q) | R == P | (Q | R) - Associativity of OR
- (P & Q) & R == P & (Q & R) - Associativity of AND
- !(P | Q) = !P & !Q - DeMorgan's Law
- !(P & Q) = !P | !Q - DeMorgan's Law
- P & (Q | R) == (P & Q) | (P & R) - Distributitivity of AND over OR
- P | (Q & R) == (P | Q) & (P | R) - Distributitivity of OR over AND
- P | TRUE == TRUE
- P & FALSE == False
- P | FALSE == P
- P & TRUE == P
- P | !P == TRUE
- P & !P == FALSE
- P == !(!P) - Double Negation
- P -> Q == !P | Q - Implication
- P <-> Q == (P -> Q) & (Q -> P) - Equivalence
- (P & Q) -> R == P -> (Q -> R) - Exportation
- (P -> Q) & (P -> !Q) == !P - Absurdity
- (P -> Q) == (!Q -> !P) - Contrapositive
```

Binary Operations
- Shift Left (n) - Has effect of multiplying by 2^n
- Shift Right (n) - Has effect of dividng by 2^n
- Xor x y - Sets register to 0 (efficient setting of 0)

Endianess
- Ordering of bytes of a word in memory or transmission (orientation of bits in a single byte never varies)
- Example for 32-bit word `0x12345678`
- Little Endian - LSB is placed at lowest address ([LSB] `0x78`, `0x56`, `0x34`,`0x12` [MSB]) - x86, x64
- Big Endian - MSB is placed at lowest address ([MSB] `0x12`, `0x34`, `0x56`, `0x78` [LSB]) - SPARC, PowerPC

To convert from decimal, divide by 2 taking the remainder which will be 0 or 1 and reverse, e.g.:
```python
def decimal_to_binary(num):

    binary_rep = []

    while num > 1:
        binary_rep.append(num % 2)
        num = num // 2

    binary_rep.append(num % 2)

    print("".join(map(str, binary_rep[::-1])))
```

Two's Complement
- In the binary numbering system, radix complement = twos complement, dminished radix complement = ones complement
- In the decimal numbering system, radix complement = tens complement, diminished radix complement = nines complement
- Example showing that we can view the highest bit as a negative value in the radix complement:
  ```
  -4 2 1
  --------
   1 0 0    -4
   1 0 1    -3
   1 1 0    -2
   1 1 1    -1
   0 0 0     0
   0 0 1     1
   0 1 0     2
   1 1 1     3
  ```
- Negate: Invert all bits and add one (e.g. -2 to 2: 1110 -> 0001 + 1 = 0010 , 2 to -2: 0010 -> 1101 + 1 = 1110)
- Addition: Add the two numbers and drop the carry bit (after checking for overflow)
- Subtraction: For x - y, negate y (subtrahend) and add it x (minuend)
- Overflow occurs during addition if both have same sign and result has opposite sign

----

Floating Point (IEEE 754)
- Single Precision 32-bits - 1 signed bit, 8-bits exponent, 23 bits mantissa
- Double Precision 64-bits - 1 signed bit, 11-bits exponent, 52 bits mantissa

- Base2 representation of 1/10 is 0.00011[0011...] infinite repeating
- So 0.1 + 0.2 is represented in python as: 0.30000000000000004

Stuff
- Busy Beaver
- Ackermann

In recursive descent
- At each step, many choices of production to use
- Backtracking used to undo bad choices

Predictive Parser LL(1)
- At each step, only once choice of production

With the grammar:
- E -> T + E | T
- T -> int | int * T | (E)

- A predictive parser will look one ahead for E production and see T and T or for the second production int and int
- We need to left-factor the grammar by eliminating the common prefixes

Left-factored Grammar:
- E -> T X
- X -> + E | Epsilon
- T -> int Y | (E)
- Y -> * T | Epsilon

LL1 Parsing Table
---------------------

```
   int          *        +       (       )       $
E | TX        |        |       | TX    |       |
X |           |        | + E   |       | eps   | eps
T | int Y     |        |       | (E)   |       |
Y |           |   * T  | eps   |       | esp   | eps
```

---

Principle of Locality - If one memory address is accessed most likely another address close by will be accessed soon

Cache Line - unit of data transfer between the cache and main memory (typically 64 bytes)

Mathematics
- Eratosthenes
  - Sieve of Eratosthenes - a system for finding prime numbers
  - Calculation of Earth circumference (very accurate) by using the shadow of well in Syrene (0 degrees) and pole Alexandria (7.12 degrees) during summer solstice
- Trigonometry
  - Ratios of sides of a right angle triangle
    - Sine - opposite / hypotenuseopposite / adjacentopposite / adjacent
    - Cosine - adjacent / hypotenuse
    - Tangent - opposite / adjacent

Dijkstra
- Algorithm for shortest path between two points - uses weighted edges and priority queue - does not account for direction
