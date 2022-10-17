# ref/gpg


Generate keys in batch mode

    user=usf-hii-nixman-2017
    pass=

    gpg --gen-key --batch \
      <( echo Key-Type: RSA;
         echo Key-Length: 2048;
         echo Subkey-Type: RSA;
         echo Subkey-Length: 2048;
         echo Name-Real:  ${user};
         echo Expire-Date: 0;
         echo Passphrase: ${pass};
         echo '%commit';
         echo done; )


       #Name-Comment: with stupid passphrase
       #Name-Email: joe@foo.bar
---



- `$HOME/.gnupg`
- `gpg -k|--list-keys`
- `gpg -r|--recipient counts@digicat.org --encrypt ${file}`
- `gpg -d|--decrypt ${file}`
- `gpg --delete-secret-and-public-key name@mailbox.com`
- `gpg --dearmor < backup_publickey.asc > backup_publickey.gpg`
- `gpg -r backup --keyring ./backup_publickey.gpg --trust-model always -o ENCRYPTEDFILE --encrypt INFILE`

generate-new-key:

    gpg --gen-key

    # Choose (1) DSA and Elgamal (default)
    # 4096 bits
    # 0 = key does not expire
    # Real name: Kevin Michael Counts
    # Email address: counts@digicat.org
    # Enter password

list-keys:

    gpg --no-default-keyring --keyring tmp/techops-backup.gpg --list-keys

list-secret-keys:

    gpg --list-secret-keys --no-default-keyring --secret-keyring spec/fixtures/gpg-privkey.gpg

