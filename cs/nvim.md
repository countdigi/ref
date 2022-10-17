# nvim

## Config

Setting up config file:

```
$ cat ~/.config/nvim/init.vim
set runtimepath^=~.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

## Vim Plug

Setting up <https://github.com/junegunn/vim-plug>:
```
curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Then launch nvim and type `:PlugUpdate`


