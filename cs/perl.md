# Perl Reference

## File Test

- `-M` Script start time minus file modification time, in days.
- `-A` Same for access time.
- `-C` Same for inode change time (Unix, may differ for other platforms)
- `-e` File exists.
- `-s` File has nonzero size (returns size in bytes).
- `-z` File has zero size (is empty).

## Command line arguments

- `$ARGV[0]` - first command line argument

## To install a perl module to a different directory.

```bash
PERL5LIB=/local/path perl Makefile.PL
```

## Get primary username and groupname

```perl
  print scalar getpwuid("$>"), "\n";
  print scalar getgrgid("$("), "\n";
```

## Print out atime, ctime, mtime on a file

```perl
  use File::stat;
  use POSIX qw(strftime);

  $file = $ARGV[0];

  $dateformat = "%Y.%m.%d %H:%M:%S";

  $atime = stat($file)->atime;
  $ctime = stat($file)->ctime;
  $mtime = stat($file)->atime;

  print "atime: $atime -> ",
        strftime ($dateformat, localtime($atime)), "\n";

```

## Strategy for a data cache using Storable

```perl
use Storable;

my $datastruct  = {};
my $cachedb     = $ENV{'HOME'} . "/.cachedb";
my $age_in_days = 0.9;

if (! -f $cachedb || -M $cachedb > $age_in_days) {
   $datastruct = get_new_datastruct();
   Storable::store($datastruct, $cachedb);
}
else {
    $datastruct = Storable::retrieve($cachedb);
}
```

## Print a random number

```perl
  srand (time ^ $$ ^ unpack "%L*", `ps | gzip`);
  print int(rand 60);
```


## Good modules

```perl
use Carp;
use Data::Dumper;
use File::Find;
use FindBin qw($Bin $Script);
use Getopt::Long;
use IO::File;
use List::Util qw(first max maxstr min minstr reduce shuffle sum);
use Pod::Usage;
use XML::Simple;

use lib "$Bin/../../lib"; # /admin/lib
use lib "$Bin/../lib";    # /admin/{module}/lib  - will override parent
```


## Getopt::Long

- `foo!` - Negatable with --nofoo and --no-foo
- `foo+` - Incremental
- `foo=i` - Integer
- `foo=s` - String
- `foo=s@` - Multiple strings

```perl
Getopt::Long::Configure("gnu_getopt");

my %arg = ();

my @options = qw(
    help|h
    man|manual|H
    debug|d
    verbose|v+;


GetOptions('h|help'       => \$opt_help,
           'H|man|manual' => \$opt_man,
           'v|verbose'    => \$opt_verbose,
           'V|version'    => \$opt_version,
           'f|file=s'     => \$opt_file,
          ) or pod2usage(-verbose => 0) && exit;

pod2usage(-verbose => 1) && exit if $opt_help;
pod2usage(-verbose => 2) && exit if $opt_man;
```

## Main

```perl
my @args  = @ARGV;
pod2usage(-verbose => 1) && exit unless @args;
```

## Options

```
-p  |Puts the code "while (<>) { }" around program and print. |
-n  |Puts the code "while (<>) { }" around program without printing. |
-a  |Auto split into array @F (used w/ "-n" or "-p"). |
-F{pattern} | Specify the pattern to split on if "-a" is used. |
-l  |Automatically chomp $/ then add back on for printing. |
-e  |Define program on the line. |
^-i{ext} |Files processed by the "<>" construct are to be edited in-place. |
```


## Time

```perl
use Time::Local;
$unixtime = timelocal($sec,$min,$hours,$mday,$mon,$year);
```

## Regex

Reference: <http://www.troubleshooters.com/codecorn/littperl/perlreg.htm>

```perl
$string !~ /match/ && { ... }
```

Run block if the string does not match.

```perl
$string =~ /match/ && { ... }
```

## Files/IO

```perl
Using IO::File
  my $fh = new IO::File("filename", "r")
      or confess ("could not open \'filename\');
  while (my $line = $fh->getline()) { ... }
  $fh->close();
```

Slurp a file w/ IO::File (this evals a Data::Dumper output file).

```perl
  my $fh = new IO::File(".dat", "r")
      or confess("Cannot read \'mask.dat\'.");
  eval(join('', $fh->getlines()));
  $fh->close();
```

Read all lines into an array, then process from the end to the start.

```perl
@lines = <FILE>;
while ($line = pop @lines) { ... }
```

Or store an array of lines in reverse order.

```perl
@lines = reverse <FILE>;
foreach $line (@lines) { ... }
```

Opening file for writing:

```perl
if (open(LOGFILE, "> message.log")) {
    print LOGFILE ("This is message number 1.\n");
    print LOGFILE ("This is message number 2.\n");
    close(LOGFILE);
}
```

Print all files in cwd whose name ends in pl.

```perl
opendir(DIR, ".");
@files = sort(grep(/pl$/, readdir(DIR)));
closedir(DIR);
foreach (@files) {
    print("$_\n") unless -d;
}
```

## Ranges

To skip ranges of text, use the .. operator. This operator is
documented in perlop. The following examples illustrate different
ways of collapsing runs of newlines. The first example eliminates
all blank lines.

```bash
perl -ne 'print unless /^$/../^$/' input
```

## XML

Translate an XML tree to a perl data structure. ForceArray indicates
you want nested elements represented by arrays even if there is only one.
This is highly suggested in the documentation and makes things consistent
to traverse.

```perl
use XML::Simple;
my ($xml_structure) = XML::Simple::XMLin($xml_tree, ForceArray => 1);
```

If this was the XML structure:

```xml
<config logdir="/var/log/foo/" debugfile="/tmp/foo.debug">
  <server name="sahara" osname="solaris" osversion="2.6">
    <address>10.0.0.101</address>
    <address>10.0.1.101</address>
  </server>
  <server name="gobi" osname="irix" osversion="6.5">
    <address>10.0.0.102</address>
  </server>
  <server name="kalahari" osname="linux" osversion="2.0.34">
    <address>10.0.0.103</address>
    <address>10.0.1.103</address>
  </server>
 </config>
```

This would be the data structure converted w/ XMLin:

```perl
$xml_structure =
  {
     'logdir'        => '/var/log/foo/',
     'debugfile'     => '/tmp/foo.debug',
     'server'        => {
         'sahara'        => {
             'osversion'     => '2.6',
             'osname'        => 'solaris',
             'address'       => [ '10.0.0.101', '10.0.1.101' ]
          },
          'gobi'          => {
              'osversion'     => '6.5',
              'osname'        => 'irix',
              'address'       => [ '10.0.0.102' ]
          },
          'kalahari'      => {
              'osversion'     => '2.0.34',
              'osname'        => 'linux',
              'address'       => [ '10.0.0.103', '10.0.1.103' ]
          }
      }
  };
```

## List installed modules

```bash
perl -MCPAN -e 'CPAN::Shell->r'
```

## Extract unique elements of an array

```perl
%seen = ( );
@uniq = grep { ! $seen{$_} ++ } @list;
```

##  Default value for variable

```perl
$color ||= 'black';
```

## Processing a list with map

This function is specifically aimed at those situations when you want
to process a list of values, to create some kind of related list. For
example, to produce a list of square roots from a list of numbers:

```perl
my @sqrt_results = map { sqrt $_ } @results;
```

## Commify series

```perl
  sub commify_series {
    (@_ == 0) ? ''                                      :
    (@_ == 1) ? $_[0]                                   :
    (@_ == 2) ? join(" and ", @_)                       :
                join(", ", @_[0 .. ($#_-1)], "and $_[-1]");
  }
```

## Perl as a Filter

The following code iterates over STDIN or a file if specified as an argument.

```perl
while (<>) {
    # do something
}
```

Translates into:

```perl
unshift(@ARGV, "-") unless @ARGV;

while ($ARGV = shift @ARGV) {
    unless (open(ARGV, $ARGV)) {
        warn "Can't open $ARGV: $!\n";
        next;
    }
    while (defined($_ = <ARGV>)) {
        # ...
    }
}
```

## Print password

``bash
perl -F: -lane 'print $F[0] if !/^#/' /etc/passwd
```

## Eliminate Blank Lines

```bash
perl -ne 'print unless /^$/../^$/' file
```

## Install alternate locationa

```bash
PERL5LIB=/local/path perl Makefile.PL
```

## Print a random number from 0 to 60

```bash
perl -e 'srand (time ^ $$ ^ unpack "%L*", `ps | gzip`); print int(rand 60) ;'
```

## Print hex

```bash
perl -e 'printf ("%02X", $decimal)';
```

