# Blog Generator
My follow along version of [Learn Haskell](https://learn-haskell.blog).


## Installing Dependencies
External dependencies:
- [Nix package manager](https://nixos.org/download#:~:text=Nix%3A%20the%20package%20manager)
  - [With Flakes enabled](https://nixos.wiki/wiki/Flakes)
- [Direnv](https://direnv.net/docs/installation.html)

> Note to self: can we somehow include direnv in flake and bootstrap it into vscode?

This project is defined with a Nix Flake. This flake takes care of downloading
all the Haskell dependencies. It also provides a shell environment for development
that have these dependencies available in the `PATH`.

Before the flake can be used, check your system and change the `system` variable
in `outputs` to your system. Common values are:
- `aarch64-darwin` Apple Silicon MacOS
- `x86_64-linux` For most Linux distro's and Windows WSL

When in doubt, start the Nix repl (`nix repl`) and type: `builtins.currentSystem`.

This shell environment can be accessed in a few different ways:
- Through VS Code with the direnv extension (see [`.vscode/extensions.json`](.vscode/extensions.json))
- Through your normal shell with direnv
- Through your normal shell with `nix develop` (not recommended, as you
  won't have your normal shell config available there)


## Running the app
Very hacky stuff right now.

```shell
cabal run # Spits the generated html to stdout

cabal run > artifact/hello.html # Now we have the html (and sometimes some build output) in a file. 
open artifact/hello.html # That we can open in our browser.
```

`cabal` is available inside the devShell. In VS Code with direnv, you can 
just run it in the VS Code Terminal.
