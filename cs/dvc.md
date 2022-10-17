# DVC Data Version Control

## Links

- <https://dvc.org/doc/>


## Notes

Must have git repo established:
```
dvc init

A  .dvc/.gitignore
A  .dvc/config
A  .dvc/plots/confusion.json
A  .dvc/plots/default.json
A  .dvc/plots/scatter.json
A  .dvc/plots/smooth.json
A  .dvcignore

```

```
$ cat .dvc/.gitignore
/config.local
/tmp
/cache
```

```
dvc add data/foo.txt
```

```
$ cat data.dvc
outs:
- md5: dd2a6587d562a1bb83e70434ae38b778.dir
  path: data
```


```
$ cat .gitignore
/data
```

```
$ dvc remote add -d origin ~/tmp/dvc/remote
```

```
$ cat .dvc/config
[core]
    remote = origin
    ['remote "origin"']
        url = /home/countskm/tmp/dvc/remote
```



