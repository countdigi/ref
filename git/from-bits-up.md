# Git From the Bits Up

Review - there are 3 major types of objects in git, each identified by a SHA-1 value:
- Blob (represents a file)
- Tree (represents a directory)
- Commit (Contains its parent(s) commit id, a message, and a pointer to the top-level Tree object)

```
alias z='zlib-flate -uncompress'
alias blob='git hash-object -w --stdin'
```

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

