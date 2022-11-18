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





# Git

## Quick

- `git diff [--color-words] [--ignore-space-change]`
- `git diff --stat --summary`

## Porcelain Commands

- `git add` - Add file contents to the index
- `git branch` - List, create, or delete branches
- `git branch` - Switch branches or restore working tree files
- `git clone` - Clone a remote repository into a new directory establishing a local copy
- `git commit` - Record changes to the repository
- `git diff` - Show changes between: working tree vs index (default), commit vs commit, index vs commit, etc.
- `git fetch` - Download objects and refs from a remote repository
- `git merge` - Join two or more development histories together
- `git mv` - Move or rename a file, directory, or symlink
- `git push` - Send new refs along with associated objects to a remote'
- `git rebase` - Re-attach local commits to the updated upstream head
- `git reset [--mixed {default} | --soft | --hard] [sha]` - Reset current HEAD to the specified state
- `git rm` - Remove files from the working tree and from the index
- `git status [--short]` - Show the working tree status

## Plumbing Commands

- `git commit-tree [-p <parent>...] [-m "<message>"] <tree>` - Creates new commit object based on `<tree>` and  prints new commit id on STDOUT
- `git cat-file [-t|-p]` - Show git object's type (`-t`) or contents (`-p` for pretty-print)
- `git hash-object` - Compute object ID and optionally create a blob from a file
- `git ls-files [--staged|-s]` - Show information about files in the index and working tree
- `git rev-parse <symbol>` - Get canonical sha for a symbol (e.g. HEAD) - does more but this is common use
- `git show-ref` - List references in a local repository
- `git write-tree` - Creates a tree object using the current index. The name of the new tree object is printed to standard output.

## Git Garbage Collection

Disable packing of objects under `.git/objects/` for a demonstration repository:

    git config gc.auto 0

## Git Reset

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


## Cat older version of a file

    git show <sha>:<file_path>

    git show bacff35:Dockerfiles/py

## Show files that changed between two version

    git diff --name-only [sha] [sha]

## Show remote branches

    $ git ls-remote --heads origin
    01844377b66ba96a8188fd12066f5745dcbae363        refs/heads/master
    78af9ae3cda1278620439bc097adabfbe23ee4c0        refs/heads/read_extractor

## One-liners

- `git config --global -l` - List all `~/.gitconfig` settings
- `git config --global --add user.name 'Mary Smith'` - Add user name to `~/.gitconfig`
- `git config --global --add user.email mary.smith@foo.com` - Add user email to `~/.gitconfig`

## Notes

The 3 Object Types

Blobs, Trees, and Commits

Blobs, Trees, and Commits are the three main classes of objects in a Git repository.

They are named by generating 40-byte, hexadecimal identifier (e.g. `f9e15d4dc7560c53ec6e12660c6414fbdcf5b5af`)
using a SHA-1 hash algorithm which reads their content.

- Blob - The object that stores the contents of a file
- Tree - The object that stores the contents of a directory (references to files/blobs and sub-directories/trees
- Commit - The object that stores a point-in-time snapshot of the top-level tree and its blobs and sub-trees

Since objects are stored by their SHA-1 hash, files or directories with identical content will be stored as a single object.
This means when you copy a file or directory, Git will simply add an entry with the new file/directory name
pointing to the same object (blob/tree) with an identical SHA-1 hash.

History

Git creates revision history through a chain of commits.

A commit takes a snaphot of the working tree, adds a message, and links to the previous (parent) commit
establishing a chain of project revisions through time.

The first commit in a Git repository is called the root commit and is the only commit without a parent.

A branch is a named reference to a commit and defines the head of a branch of development.
The default branch is named 'master' but is not special.

HEAD points to the reference or commit which will be used as the parent for the next commit you make.
HEAD usually references a branch which in-turn points to the last commit for that branch of development.

When you are on a branch (i.e. HEAD points to the branch), each commit links to
the branch's head (last commit) and advances the branch head forward to the the new commit.
This establishes a chain or graph of revision history.

The 3 File Locations

Working Tree, Index, Repository

- Working Tree - A project's top level directory (e.g. ~/dev/projects/abc) and all files and sub-directories under it.

- Index - A temporary, dynamic area which allows incremental staging of changes made in the Working Tree
  to be added to the next commit.

- Repository - The special directory (usually named `.git/`) which contains the commit, tree, and blob objects
  which represent a project's revision history. Besides the objects, the repository maintains a HEAD pointer
  and one or more branch heads (e.g. 'refs/heads/master') representing a branch of development.


Collisions

- A SHA-1 collision become likely once you generate about 2^80 or 10^24 hashes (the birthday paradox
stipulates a collision becomes likely once you exhaust half of the keyspace).

If you have 1 million developers creating a total of 1 million files for each second of the day and night, it would take 38
billion years to generate that number of hashes. Note the sun will swallow the earth in about 7.6 billion years.

Nonethless, git is working on a backwards compatible replacement for the SHA-1 algorithm but it is going to take
time due to the way the code was originally tightly-couped to the SHA-1.





### From <http://ftp.newartisans.com/pub/git.from.bottom.up.pdf>

- Repository - a collection of commits, each of which is an archive of what the working tree looked like
  at a past date. It also defines HEAD which identifies the branch or commit the current working tree
  stemmed from. It contains a set of branches and tags, to identify certain commits by name.

- Working Tree - Any directory on your filesystem which has a repository associated with it (typically
  inciated by the presence of a sub-directory within it named .git/). It includes all the files and
  sub-directories in that directory.

- Commit - A snapshot of your working tree at some point in time. The state of HEAD at the time your
  commit is made becomes that commit's parent. This is what creates the notion of revision history.

- Branch - A branch is just a name for a commit and is also called a reference. It defines the "head"
  of a branch of development. The default branch name is 'master' although it is in no way special.

- Tag - A tag is similar to a branch but points to a specific commit and never changes.

- HEAD - Used by your repository to define what is currently checked out:
  - If you checkout a branch, HEAD symbolically refers to that branch, e.g. `HEAD -> refs/heads/master` indicating the branch should be updated after the next commit operation.
  - If you checkout a commit (e.g. `09ef`), HEAD refers to that commit only (detached HEAD). It usually occurs when you checkout a tag name as well (e.g. `v1.0`).


### Repository

A Git repository is a database containing all the information needed to retain and manage the revisions
and history of a project. Within a repository, Git maintains two primary data structures, the object store and the index. All of this repository data is stored at the root of your working directory in a hidden subdirectory named `.git`.

Git places only four types of objects in the object store: the blobs, trees, commits, and tags. These four atomic objects form the foundation of Git’s higher level data structures.

- Blobs (Binary Large Object) - Each version of a file is represented as a blob. Note a blob is simply a file
  named after the SHA-1 digest of its contents and contains no metadata such as its name or permissions.
- Trees - Represents one level of directory information including sub-tree identifiers or blob identifiers with their corresponding file path names and metadata.
- Commits - HOds metadata for each change introduced into the reository including the author, commiter, commit date, and message.  Internally it also contains the parent(s) commit identifiers and the top-level tree identifier.
- Tags - A human readable name pointing to a specific object, usually a commit.


### Index

The index is a temporary and dynamic binary file that describes the directory structure of the entire repository.
The index captures a versions of th eproject's overall structure at some moment in time.
The index allows a separation between incremental development steps and the committal of those changes.

As a developer, you usually use git add and delete to stage changes in the index. The index records
and retains those changes, keeping the safe until you are ready to commit them. You can also remove
or replace changes in the index. Thus, the index allows a gradual transition from one complex repository
state to another.

### SHA1

With 160 bits, you have 2^160 or about 10^48 (1 with 48 zeroes after it) possible SHA1 hashes. That number is just incomprehensibly huge. Even if you hired a trillion people to produce a trillion new unique blobs per second for a trillion years, you would still only have about 10^43 blobs.

If you hashed 2^80 random blobs, you might find a collision.

### Commit

The commit object contains:
- The id of a tree object (top-level directory)
- The name of author
- The name of committer (may be same as author)
- A commit message
- The commit id of its parent or parents if this is a merge commit

Example of a commit:

    $ git cat-file -p HEAD
    tree ddb89f101d6b8ac2c7eaef5aa932b4c54e9fbbfc
    parent ad1dd2c58bc33445cbefaa6e1caa4bef5de43961
    author Kevin Counts <counts@digicat.org> 1529775426 -0400
    committer Kevin Counts <counts@digicat.org> 1529775426 -0400

    Refactor multiply function

*Good Commit Message Suggestions*:
- Separate subject from body with a blank line
- Limit the subject line to 50 characters
- Capitalize the subject line
- Do not end the subject line with a period
- Use the imperative mood in the subject line ("Add hash algorithm" vs. "Added hash algorithm")
- Wrap the body at 72 characters

Example Commit Messages:
- "Fix rewind behavior when paused"
- "Refactor multiply function"
- "Add genomic parsing in scripts/parse-genome.py"

### File Clasifications in Git

- *Ignored* - A file that has been specified to be ignored in `~/.gitignore`, `.gitignore`, etc.
- *Tracked* - Any file already in the repository or any file that is staged in the index
- *Untracked* - Any file that is neither Tracked or Ignored. When you create a new file before you add it for the first time its untracked.

---

    Working (.)   Index (.git/index)    Repo (.git)
      ---- add ----->
                    --------- commit --->
      <--------------- checkout -----------

- You "git add" a file from working to index
- You "git commit" a file from index to repo
- You "git checkout" a file from repo to index to working directory

- Git Equilibrium: All files in a) Working Directory, b) Index, and c) tree in commit SHA that HEAD points to are the same


Working Tree - A working tree is any directory on your filesystem which has a repository associated
with it. It includes all the files and sub-directories in that directory.

Commit is a snapshot of your working tree at some point in time.

## Git from Scratch

Review - there are 3 major types of objects in git, each identified by a SHA-1 value:
- Blob (represents a file)
- Tree (represents a directory)
- Commit (Contains its parent(s) commit id, a message, and a pointer to the top-level Tree object)

---

Make a new example directory and cd into it, this will be your "working tree":

    $ mkdir -p ~/tmp/git-demo
    $ cd ~/tmp/git-demo

Create the git repository structure in the working tree:

    $ mkdir .git .git/refs .git/refs/heads .git/objects

Create HEAD pointing to master which we will populate later:

    $ echo 'ref: refs/heads/master' > .git/HEAD

Create one file in the working tree:

    $ echo '# Example Project' > README.md

Add the file to the object database:

    $ git hash-object -w README.md

We can now view it in the `.git` folder:

    $ ls -l .git/objects/e2/46619759aeee01194a8c19bf1d233e9730ce54
    -r--r--r--. 1 countskm countskm 34 Jun 28 17:12 .git/objects/e2/46619759aeee01194a8c19bf1d233e9730ce54

*NOTE: git uses the first 2 characters to create 256 "buckets" in the object store to make it easier for the fileystem*

View the `README.md` blob object type (`-t` means "show type):

    $ git cat-file -t e246619759aeee01194a8c19bf1d233e9730ce54
    blob

View the `README.md` blob contents (`-p` means "pretty print"):

    $ git cat-file -t e246619759aeee01194a8c19bf1d233e9730ce54
    # Example Project

Add an entry into the index associating `README.md` with its object ID:

    $ printf '100644 e246619759aeee01194a8c19bf1d233e9730ce54 0\tREADME.md' \
        | git update-index --index-info

- `100644` is its fileystem permissions
- `e246619759aeee01194a8c19bf1d233e9730ce54` is the blob with the contents of `README.md`
- `0` - is the version of the staged file (during merges, etc. the index might contain multiple versions)
- `README.md` - Associates the name README.md with the blob

To view the index:

    $ git ls-files --stage
    100644 e246619759aeee01194a8c19bf1d233e9730ce54 0       README.md

Create a new tree object by writing the index out:

    $ git write-tree
    ce33db99c45a68c7fb5132eaf50a9d5098db8883

Create the root commit (we set date to get a deterministic commit SHA-1 value):

    $ GIT_AUTHOR_DATE='01/01/2018 00:00:00' \
      GIT_COMMITTER_DATE='01/01/2018 00:00:00' \
      git commit-tree -m 'Initial commit' ce33db99c45a68c7fb5132eaf50a9d5098db8883

      7acd7eb37c429f8f2c5370475f10abd18423bda5

Finally put this commit id into the master branch:

    $ echo  7acd7eb37c429f8f2c5370475f10abd18423bda5 > .git/refs/heads/master

Verify the results:

    $ git log
    commit 7acd7eb37c429f8f2c5370475f10abd18423bda5
    Author: Kevin Counts <counts@digicat.org>
    Date:   Mon Jan 1 00:00:00 2018 -0500

        Initial commit

Review the directory structure:

    $ find .git/ -type f
    .git/refs/heads/master
    .git/index
    .git/objects/ce/33db99c45a68c7fb5132eaf50a9d5098db8883
    .git/objects/e2/46619759aeee01194a8c19bf1d233e9730ce54
    .git/objects/7a/cd7eb37c429f8f2c5370475f10abd18423bda5
    .git/HEAD


---

    alias z='zlib-flate -uncompress'
    alias blob='git hash-object -w --stdin'
