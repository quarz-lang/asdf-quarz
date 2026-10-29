# asdf-quarz

A [mise](https://mise.jdx.dev) and [asdf](https://asdf-vm.com) plugin for
[Quarz](https://quarz.dev): it installs versions of Quarz, each built
from source, and switches between them per project.

Linux x86-64 only, for now. Building a version takes a few minutes.

## Dependencies

- Rust, stable (1.96 or later), through [rustup](https://rustup.rs)
- git
- a C toolchain (`cc`: gcc or clang), which Rust and `quarz build` link with
- clang 14 or later (`clang` or `clang-14`...), for `quarz build`; `quarz run` works without it

## With mise

```sh
mise plugin add quarz https://github.com/quarz-lang/asdf-quarz
mise use -g quarz@0.1.0     # the default version
mise use quarz@0.1.0        # this project's version, in its mise.toml
mise install quarz@ref:main # the development version, from quarz's main
quarz --version
```

`mise ls-remote quarz` lists the versions released (the tags `vX.Y.Z` of
[quarz-lang/quarz](https://github.com/quarz-lang/quarz)). A ref is a
branch, a tag or a commit: `ref:main` builds whatever main has now, and
`mise install quarz@ref:main` again after `mise uninstall quarz@ref:main`
builds it anew.

## With asdf

```sh
asdf plugin add quarz https://github.com/quarz-lang/asdf-quarz
asdf install quarz 0.1.0
asdf set -u quarz 0.1.0     # the default version (asdf 0.16 and later;
                            # before that, asdf global quarz 0.1.0)
asdf set quarz 0.1.0        # this project's, in its .tool-versions
asdf install quarz ref:main
```

## What it installs

`bin/install` runs `cargo build --release --locked` in the sources and
puts `quarz` and `libquarz_vm.a`, the runtime library compiled programs
link, in the version's `bin/`, where `quarz build` finds the library.
The build's files stay in the download directory, which the version
manager removes.

`ASDF_QUARZ_REPO` overrides the repository it installs from (a URL or a
local path).

## License

[MIT No Attribution](LICENSE), as Quarz itself.
