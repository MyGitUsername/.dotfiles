Dotfile configurations are managed with GNU Stow.

To deploy dotfiles:
1. Run the command stow `<dir>`, where `<dir>` is the name of a folder
whose entire contents we wanted symbolic links for in our home directory.
2. Stow will look in the folder `<dir>` and create a symbolic link of all the files
with that `<dir>` one folder above where the stow command was run.

Example with the following file tree:
```
├── bash
│   ├── .bashrc
│   └── .profile
├── foo
│   └── .config
│       └── foo
│           └── somefile
└── vim
    └── .vimrc
```

Running `stow foo` inside the dotfiles folder will then create a
symbolic link at `~/.config/foo/somefile`, creating any intermediate
directories that don’t already exist.

If you want to delete a set of symbolic links, just run stow -D `<dir>`.

Source: https://alexpearce.me/2016/02/managing-dotfiles-with-stow/
