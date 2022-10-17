# Vim

## Quickref

- Replace and ensure it is case sensistive:
  - `%s/foo/bar/I`


## Dump

```vim

:for line in getline(1, '$') | echo line | endfor
:for line in getline(1, '$') | echo split(line, '\s\+') | endfor

:echo expand("~")      " home dir
:echo expand("%:p")    " absolute path
:echo expand("%:p:h")  " absolute path dirname
:echo expand("%:p:h:h")" absolute path dirname dirname
:echo expand("%:.")    " relative path
:echo expand("%:.:h")  " relative path dirname
:echo expand("%:.:h:h")" relative path dirname dirname

g: varname  The variable is global
s: varname  The variable is local to the current script file
w: varname  The variable is local to the current editor window
t: varname  The variable is local to the current editor tab
b: varname  The variable is local to the current editor buffer
l: varname  The variable is local to the current function
a: varname  The variable is a parameter of the current function
v: varname  The variable is one that Vim predefines

& varname  A Vim option (local option if defined, otherwise global)
&l: varname   A local Vim option
&g: varname   A global Vim option
@ varname   A Vim register
$ varname   An environment variable

if empty(result_string)
   echo "No result"
endif
```

## Quick Settings Embedded in Document

```
# vim: tabstop=4 shiftwidth=4 softtabstop=0 expandtab ft=snakemake
```

- `ruler`        - Display the current cursor position in the lower right corner
- `autoindent`   - Copy indent from current line when starting a new line
- `textwidth=n`  -  A longer line will be broken after white space to get X width
- `wrapmargin=n` - Number of characters from right border where wrapping starts.
- `expandtab`    - Expand tab characters (typed) into spaces
- `tabstop=n`    - Number of whitespaces used to display a tab character
- `smartindent`  - Auto-indent for programming structures like "{", etc...
- `shiftwidth=n` - Number of spaces to use for auto-indenting

Turn off indenting: `:setl noai nocin nosi inde=`

git clone https://github.com/pearofducks/ansible-vim ~/.vim/bundle/ansible-vim


## Programming

    function! FooBar(var)
      call OtherFunction(a:var)
    endfunction

  g: varname  The variable is global
  s: varname  The variable is local to the current script file
  w: varname  The variable is local to the current editor window
  t: varname  The variable is local to the current editor tab
  b: varname  The variable is local to the current editor buffer
  l: varname  The variable is local to the current function
  a: varname  The variable is a parameter of the current function
  v: varname  The variable is one that Vim predefines


$VIMRUNTIME (/usr/share/vim/)

Execute a register in ex.
    :@a

## Registers

  1. The unnamed register ""
  2. 10 numbered registers "0 to "9
  3. The small delete register "-
  4. 26 named registers "a to "z or "A to "Z
  5. four read-only registers ":, "., "% and "#
  6. the expression register "=
  7. The selection and drop registers "*, "+ and "~
  8. The black hole register "_
  9. Last search pattern register "/

## Opening files

Position the cursor over the filename and hit 'gf'


#### Movement commands to memorize
  H          first non-whitespace top of screen
  L          first non-whitespace bottom of screen
  M          first non-whitespace middle of screen
  +          first non-whitespace character next line
  -          first non-whitespace character previous line
  _          first non-whitespace character current line
  z{ENTER}   set current line at top of window
  z.         set current line at center of window
  z-         set current line at bottomo of window


#### Misc

  # NOTE: in vim you have to \% in ex
  e.g.:
     :6,33! awk '{printf "\%4s \%s\n", $1, $3}'

  # Ex mode
  CTRL-R "     # paste the contents of the last yanked command

  # Options
  set                    # show all options differing from default
  set all                # Show all options
  set no{option}         # Disable {option}
  set {option}={value}   # Set {option} to {value}

  ruler        # Display the current cursor position in the lower right corner
  autoindent   # Copy indent from current line when starting a new line
  textwidth=0  # A longer line will be broken after white space to get X width.
  wrapmargin=0 # Number of characters from right border where wrapping starts.
  expandtab    # Expand tab characters (typed) into spaces
  tabstop=8    # Number of whitespaces used to display a tab character
  smartindent  # Auto-indent for programming structures like "{", etc...
  shiftwidth=8 # Number of spaces to use for auto-indenting

# Ex

  # Delete blank lines
  :g/^$/ d

#-----------------------------------------------------------------------
# Movement
#-----------------------------------------------------------------------
|    Move the cursor to the column specified by the count.
%    Move the cursor to the matching parenthesis or brace.
^    Move the cursor to the first non-whitespace character.
(    Move the cursor to the beginning of a sentence.
)    Move the cursor to the beginning of the next sentence.
{    Move the cursor to the preceding paragraph.
}    Move the cursor to the next paragraph.
0    (Zero) Move the cursor to the first column of the current line.
B    Move the cursor back one word, skipping over punctuation.
E    Move forward to the end of a word, skipping over punctuation.
G    Go to the line number specified as the count.
W    Move forward to the beginning of a word, skipping over punctuation.
b    Move the cursor back one word. If the cursor is in the middle of
     a word, move the cursor to the first character of that word.
e    Move the cursor forward one word. If the cursor is in the middle of
     a word, move the cursor to the last character of that word.
h   Move the cursor to the left one character position.
j   Move the cursor down one line.
k   Move the cursor up one line.
l   Move the cursor to the right one character position.
w   Move the cursor forward one word. If the cursor is in the middle of
    a word, move the cursor to the first character of the next word.

# Color Names
Black
DarkBlue
DarkGreen
DarkCyan
DarkRed
DarkMagenta
Brown, DarkYellow
LightGray, LightGrey, Gray, Grey
DarkGray, DarkGrey
Blue, LightBlue
Green, LightGreen
Cyan, LightCyan
Red, LightRed
Magenta, LightMagenta
Yellow, LightYellow
White


# 2018-05 Vim

## Installation of vim plug

```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

```

Now add this to your `~/.vimrc`:

```
call plug#begin('~/.vim/plugged')
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'AlessandroYorba/Alduin' " colorscheme
Plug 'Townk/vim-autoclose'
Plug 'tpope/vim-fugitive'
call plug#end()

set laststatus=2

map ,n  :NERDTreeToggle<cr>

highlight clear
colorscheme alduin " AlessandroYorba/Alduin
highlight String ctermbg=none

```

Normal (Powerful Keys) Mode

```
<number><operation><modifier>
2dw = delete 2 words
2cw = change 2 words
dd = delete line
yy = yank a line
p = paste a line (below)
P = paste a line (above)
o = insert below
O = insert above
A = append
G = end of doc
1G = begin of doc


marks

m<marker>
ma - creates mark a (reference by 'a)
mb = creates mark b ....

'a - go to mark a
d'a - delete to mark a

<line_number>gg - goes to line
or
:<line_number>

:w<cr> writes file without quiting

```
# Vim

## Execute a register in ex.

    :@a

## Registers

- The unnamed register `""`
- 10 numbered registers `"0` to `"9`
- The small delete register `"-`
- 26 named registers `"a` to `"z` or `"A` to `"Z`
- four read-only registers `":`, `".`, `"%` and `"#`
- the expression register `"=`
- The selection and drop registers `"*`, `"+` and `"~`
- The black hole register `"_`
- Last search pattern register `"/`

Paste the contents of the last yanked command in register `"`:

    CTRL-r "

## Configuration

    set                    # show all options differing from default
    set all                # Show all options
    set no{option}         # Disable {option}
    set {option}={value}   # Set {option} to {value}

- `ruler`        - Display the current cursor position in the lower right corner
- `autoindent`   - Copy indent from current line when starting a new line
- `textwidth=n`  -  A longer line will be broken after white space to get X width
- `wrapmargin=n` - Number of characters from right border where wrapping starts.
- `expandtab`    - Expand tab characters (typed) into spaces
- `tabstop=n`    - Number of whitespaces used to display a tab character
- `smartindent`  - Auto-indent for programming structures like "{", etc...
- `shiftwidth=n` - Number of spaces to use for auto-indenting

## Ex

  # Delete blank lines
  :g/^$/ d

