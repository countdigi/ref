# Git Reference

## Links

[pro-git-book](https://git-scm.com/book/) |
[visual-git-guide](https://marklodato.github.io/visual-git-guide/index-en.html) |
[hackers-guide-to-git](https://wildlyinaccurate.com/a-hackers-guide-to-git) |
[video-git-concepts](https://www.youtube.com/watch?v=uR6G2v_WsRA) |
[video-git-concepts-2](https://www.youtube.com/watch?v=FyAAIHHClqI) |
[video-git-from-the-bits-up](https://www.youtube.com/watch)

## Quickref

### Top

- Cat older version of file:
  - `git show <sha>:<path>`

### General

- Show word-diff on CSV:
  - `git diff --word-diff-regex='[^:]+' <file>`
- Show only the commits which affected:
  - `<file>` - `git whatchanged <file>`
- Export as gzipped tarball: `git archive master | gzip > <name>.tar.gz`
- Force push with safety: `git push --force-with-lease`
- Filter branch: `git filter-branch --prune-empty --tree-filter 'rm -rf $(cat /full/path/to/large_files.txt | cut -d " " -f 2)' <REVLIST...>`
- Show diff of revisions: - `git log <ref>..<ref>` (e.g. `git log HEAD..origin/master`)
- Generate patch file: `git diff --no-prefix > <patchfile>`
- Apply patch: `patch -p0 < <patchfile>`
- List SHA of remote branches: `git ls-remote <remote>`
- Diff inline word changes: `git diff [--word-diff] [--color-words] [--ignore-space-change]`
- Show only files changed between two commits: `git diff --name-only <sha> <sha>`
- Show remote branches: `git ls-remote --heads <remote>`
- Show files that have changed only: `git diff --stat`
- Grep for term in all files among all commits: `git rev-list --all | cut -c1-8 | xargs git grep [-l] foo`
- Show git object: `git show --format=raw <sha>`
- Show which commit a reference point to: `git rev-parse [--short] master`
- Show which branches a commit is in: `git branch --contains d409ca7`

## Plumbing Commands
- `git commit-tree [-p <parent>...] [-m "<message>"] <tree>` - Creates new commit object based on `<tree>` and  prints new commit id on STDOUT
- `git cat-file [-t|-p]` - Show git object's type (`-t`) or contents (`-p` for pretty-print)
- `git hash-object` - Compute object ID and optionally create a blob from a file
- `git ls-files [--staged|-s]` - Show information about files in the index and working tree
- `git rev-parse <symbol>` - Get canonical sha for a symbol (e.g. HEAD) - does more but this is common use
- `git show-ref` - List references in a local repository
- `git write-tree` - Creates a tree object using the current index. The name of the new tree object is printed to standard output.

## List every reachable object with details sorted by size

```bash
git rev-list --objects --all | git cat-file --batch-check='%(objecttype) %(objectsize) %(objectname) %(rest)' | sort -n -k2,2
```

## Rewrite a repository

Run filter
```bash
git filter-branch --prune-empty --index-filter 'git rm -r --cached --ignore-unmatch big-file.txt' HEAD
```

Reclaim space:
```bash
git for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git update-ref -d
git reflog expire --expire=now --all
git gc --prune=now
```

## Diff merge example

```
*   afb7a7c (HEAD -> master) merge bug
*   |\
*   | * 9c28eba (bug) add 1 to d.txt
*   | * bac7cc1 add 1 to c.txt
*   * | 5e20447 add 1 to e.txt
*   |/
*   * 362b852 add 1 to b.txt
*   * 2d09549 add 1 to a.txt
```


Exclude changes reachable by master~ (5e20447) but include changes reachable from HEAD (9c28eba and bac7cc1) (short and long forms):
```bash
git diff master~..
git diff ^master~1 HEAD
```

## Deleting remote references

Branch
- Delete local: `git branch -d <branch>`
- Delete remote tracking branch: `git branch -r -d <branch>`
- Delete remote branch: `git push -d <remote> <branch>` (e.g. `git push -d origin dev-alpha`)

Tag
- Delete local tag: `git tag -d <tag>`
- Delete remote tag: `git push -d <remote> <tag>` (e.g. `git push -d origin stable`)

## Working with Forks

Add upstream:
```bash
git remote add upstream git@github.com:<user>/<repo>.git
```

Reset from upstream:
```bash
git fetch upstream
git rebase master upstream/master # OR git reset --hard upstream/master
git push origin master --force
```

## Git status

Run `git status` to view what state a file is in:

```
$ git status --short

|------ Column 1: Staging Area (Index)
 |------------------------------------- Column 2: Working Tree

??   file1.txt  # Untracked
A    file2.txt  # Staged new file
M    file3.txt  # Staged new change in tracked file
 M   file4.txt  # Modified (changed file but not staged)
 D   file5.txt  # Deleted from Working Directory but deletion not staged
D    file6.txt  # Deleted from Working Directory and deletion staged
```

## Git Repository

The `.git` directory. Contains all committed versions of the Working Tree, metadata, history, etc.

```
project_folder/ <--- Working Tree
  file1.txt
  file2.txt
  .git/         <---- Repository
    index       <---- Staging Area (Index)
    HEAD        <---- Points to tip of current branch commit ID
    refs/heads  <---- Holds local branch HEADs
    objects/    <---- Contains blob (file), tree (directory), and commit objects
```

## Git Directory

Newer versions of git use `git -C <dir>` but old invocation is:
```
GIT_DIR=<path> GIT_WORKING_TREE=${GIT_DIR} git <command> [options]
```

## Environmental Variables

- `GIT_AUTHOR_NAME`, `GIT_COMMITTER_NAME` - Overrides `user.name` in `.git/config`
- `GIT_AUTHOR_EMAIL`, `GIT_COMMITTER_EMAIL` - Overrides `user.email` in `.git/config`

## Object Model

The Git Model
- Locations of File Contents
  - Index
  - Working Tree
  - Repository
- Object Types of Repository
  - Blob - File
  - Tree - Directory
  - Commit - Pointer to Tree and previous Commit(s)
- Pointers for structure
  - `HEAD` - The local branch head we point to ("You Are Here")
  - Local Branch (e.g. `refs/heads/<branch>`)
  - Remote Branch (e.g. `refs/remotes/<remote>/<branch>`)

Naming
- The name of a blob, tree, or commit is derived from its content using SHA-1 hash algorithm (Use `git hash-object`)
- SHA-1 is a 160-bit bash represented as a 40-byte hexadecimal identifier (e.g. `f9e15d4dc7560c53ec6e12660c6414fbdcf5b5af`)

## File States

- **Ignored** - A file that has been specified to be ignored in `~/.gitignore`, `.gitignore`, etc.
- **Tracked** - Any file already in the repository or any file that is staged in the index
- **Untracked** - Any file that is neither Tracked or Ignored. When you create a new file before you add it for the first time its untracked.

```
Working (.)   Index (.git/index)    Repo (.git)
 |--- add ----->
                |--------- commit --->
 <--------------- checkout ----------|
```

- `git add` - Working to Index
- `git commit` - Index to Repository
- `git checkout` - Repository to Index to Working

## Config

Log Power Alias
```
[alias]
l = log --color --all --decorate --graph \
    --pretty='format:%C(blue)%h%C(reset) %C(yellow)%d%C(reset) %C(cyan)%s%C(reset) %C(green)(%cr by %an)%C(reset)'
```
Output Example:
```
$ git l
* 2614623  (HEAD -> master, origin/master) Update (2 hours ago by Kevin Counts)
* a34c3ab  Update (12 days ago by Kevin Counts)
* ... etc.
```

- Always try to rebase when pulling from master: `git config branch.master.rebase true`
- Enable color: `git config --global color.ui true`
- Set name and email:
  - `git config --global user.name 'Jane Doe'`
  - `git config --global user.email jane.doe@gmail.com`
- Set whitespace checking: `git config --global core 'whitespace=fix,-indent-with-non-tab,trailing-space,cr-at-eol'`

## Reset


## Git Garbage Collection

Disable packing of objects under `.git/objects/` for a demonstration repository:

    git config gc.auto 0

## Git Reset

Change `HEAD` to point to `[commit]`

Mode Differences:
  - `--mixed` - Resets index only. Changed files preserved in working tree but not marked for commit
  - `--hard` - Resets index and working tree. Any changes to tracked files since `<commit>` are discarded
  - `--soft` - Preserves index and working tree leaving changed files in "Changes to be commited"

Invocation: `git reset [--mixed|--hard|--soft] [commit]`
- Default mode is `--mixed`
- Default commit is `HEAD`

Typing `git reset` by itself is the same as `git reset --mixed HEAD`:
- Resets `HEAD` to point to `HEAD` so no change
- Removes changes staged in the index

If you have 4 local commits and you want to squash these into one, an easy way is:
```bash
git reset --soft HEAD~4
git commit --amend 'Commit message for consolidated commits'
```

## Definitions

**Branch** - A named reference to a commit and defines the head of a branch of development.  The default branch is named `master` but is not special.

**Head** - Points to the reference or commit which will be used as the parent for the next commit you make.  HEAD usually references a branch which in-turn points to the last commit for that branch of development.  When you are on a branch (i.e. HEAD points to the branch), each commit links to the branch's head (last commit) and advances the branch head forward to the the new commit.  This establishes a chain or graph of revision history.

**Working Tree** - A project's top level directory (e.g. ~/dev/projects/abc) and all files and sub-directories under it.

**Index** - A temporary, dynamic area which allows incremental staging of changes made in the Working Tree to be added to the next commit.

**Repository** - The special directory (usually named `.git/`) which contains the commit, tree, and blob objects which represent a project's revision history. Besides the objects, the repository maintains a HEAD pointer and one or more branch heads (e.g. 'refs/heads/master') representing a branch of development.

**Repository** - a collection of commits, each of which is an archive of what the working tree looked like at a past date. It also defines HEAD which identifies the branch or commit the current working tree stemmed from. It contains a set of branches and tags, to identify certain commits by name.

**Working Tree** - Any directory on your filesystem which has a repository associated with it (typically inciated by the presence of a sub-directory within it named .git/). It includes all the files and sub-directories in that directory.

**Commit** - A snapshot of your working tree at some point in time. The state of HEAD at the time your commit is made becomes that commit's parent. This is what creates the notion of revision history.

**Branch** - A branch is just a name for a commit and is also called a reference. It defines the "head" of a branch of development. The default branch name is 'master' although it is in no way special.

**Tag** - A tag is similar to a branch but points to a specific commit and never changes.

**HEAD** - Used by your repository to define what is currently checked out:
- If you checkout a branch, HEAD symbolically refers to that branch, e.g. `HEAD -> refs/heads/master` indicating the branch should be updated after the next commit operation.
- If you checkout a commit (e.g. `09ef`), HEAD refers to that commit only (detached HEAD). It usually occurs when you checkout a tag name as well (e.g. `v1.0`).

**Blob** - Each version of a file is represented as a blob. Note a blob is simply a file named after the SHA-1 digest of its contents and contains no metadata such as its name or permissions.

**Tree** - Represents one level of directory information including sub-tree identifiers or blob identifiers with their corresponding file path names and metadata.

**Commits** Holds metadata for each change introduced into the reository including the author, commiter, commit date, and message.  Internally it also contains the parent(s) commit identifiers and the top-level tree identifier.

**Tag** - A human readable name pointing to a specific object, usually a commit.

**Index** The index is a temporary and dynamic binary file that describes the directory structure of the entire repository.  The index captures a versions of th eproject's overall structure at some moment in time.  The index allows a separation between incremental development steps and the committal of those changes.

## Other

- `<tree-ish>` Indicates a tree, commit or tag object name
  - A command that takes a `<tree-ish>` argument ultimately wants to operate on a `<tree>` object but
    automatically dereferences `<commit>` and `<tag>` objects that point at a `<tree>`.

- `<commit-ish>` Indicates a commit or tag object name
  - A command that takes a `<commit-ish>` argument ultimately wants to operate on a `<commit>` object but
    automatically dereferences `<tag>` objects that point at a `<commit>`.

The Three Trees
- HEAD - Last commit snapshot, next parent
- Index - Proposed next commit snapshot
- Working Directory - Sandbox


HEAD is the pointer to the current branch reference, which is in turn a pointer to the last commit made on that branch. That means HEAD will be the parent of the next commit that is created. It’s generally simplest to think of HEAD as the snapshot of your last commit on that branch.

Index - We’ve also been referring to this concept as Git’s “Staging Area” as this is what Git looks at when you run git commit.

Finally, you have your working directory (also commonly referred to as the “working tree”). The other two trees store their content in an efficient but inconvenient manner, inside the .git folder. The working directory unpacks them into actual files, which makes it much easier for you to edit them. Think of the working directory as a sandbox, where you can try changes out before committing them to your staging area (index) and then to history.

$ git help -g

The common Git guides are:
   attributes          Defining attributes per path
   cli                 Git command-line interface and conventions
   core-tutorial       A Git core tutorial for developers
   cvs-migration       Git for CVS users
   diffcore            Tweaking diff output
   everyday            A useful minimum set of commands for Everyday Git
   glossary            A Git Glossary
   hooks               Hooks used by Git
   ignore              Specifies intentionally untracked files to ignore
   modules             Defining submodule properties
   namespaces          Git namespaces
   repository-layout    Git Repository Layout
   revisions           Specifying revisions and ranges for Git
   tutorial            A tutorial introduction to Git
   tutorial-2          A tutorial introduction to Git: part two
   workflows           An overview of recommended workflows with Git

A tree-ish (like a tree) indicates a tree, commit, or tag object name - all commit-ish objects are tree-ish
A commit-ish (like a commit) indicates a commit or tag object name





