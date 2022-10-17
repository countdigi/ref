# ref/powertools.md


Using process substitution to turn output file into stdout stream

    consul snapshot save >( aws s3 cp - s3://bucket-of-consulation/$(date +%Y%m%d) )

gnu parallel

    http://ftp.gnu.org/gnu/parallel/parallel-latest.tar.bz2 # no el6 package - ./configure && make install

    cat /tmp/transfer.log \
      | parallel --will-cite -j 5 \
        rsync -avzm  --relative --stats --safe-links --ignore-existing --human-readable {} 192.168.1.2:/data/ > result.log

parallel copy

    find Files/ -type d  \
      | parallel  'mkdir -p /BKP/{}' \
          && find Files/ -type f  | parallel 'rsync -a {} MKD/$(dirname {})'

automatically sync current git project with remote host while editing

    while true; do rsync -vR \
      $(git ls-files | inotifywait -q -e modify -e attrib -e close_write --fromfile - --format '%w') user@host:dest/dir/
    done

compare files and size of two paths

    path_a=/labdata/teddy/\_archive
    path_b=/archive/labdata/teddy/\_archive

    sudo find ${path_a} -type f -printf '%p:%s\n' | sed "s|${path_a}/||" | sort > /var/tmp/find-a.txt
    sudo find ${path_b} -type f -printf '%p:%s\n' | sed "s|${path_b}/||" | sort > /var/tmp/find-b.txt

    diff /var/tmp/find-a.txt /var/tmp/find-b.txt

power find

    path=""
    printf "path:inode:number_links:owner:group:atime:ctime:mtime:bytes:perms\n"; \
    find ${path:-NULL} -type f -printf '%p:%i:%n:%u:%g:%CY-%Cm-%Cd:%AY-%Am-%Ad:%TY-%Tm-%Td:%s:%#m\n'

compare remote file with a local file

    ssh user@host cat /path/to/remotefile | diff /path/to/localfile -


Onetime share a document with someone

    $ nc -v -l 80 < file.ext

Rip audio from a video file.

    $ mplayer -ao pcm -vo null -vc dummy -dumpaudio -dumpfile <output-file> <input-file>

Convert seconds to human-readable format

    $ date -d@1234567890

rsync progress indicator which updates in-place

    rsync --recursive --info=progress2 <src> <dst>

Sync the existing directory structure to destination, without transferring any files

```
rsync -av -f'+ */' -f'- *' source dest
```

Automatically sync current git project with remote host while editing

    while true; do
      rsync -vR $(git ls-files | inotifywait -q -e modify -e attrib -e close_write \
        --fromfile - --format '%w') user@host:dest/dir/
    done

Rsync Command that limits bandwidth

    rsync -arvx --numeric-ids --stats --progress --bwlimit=1000 file server:destination_directory

All what exists in dir B and not in dir A will be copied from dir B to new or existing dir C

    rsync -v -r --size-only --compare-dest=../A/ B/ C/

tweet from the shell

     $ curl -u user:pass -d status="Tweeting from the shell" http://twitter.com/statuses/update.xml

