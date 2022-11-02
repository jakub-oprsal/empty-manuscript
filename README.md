# Empty manuscript

This repository contains a starting point for my latex projects for paper manuscripts. Contains a base metadata, `makefile`, `.gitignore`, etc., so that it can be cloned to create a new project/paper. The intended use is:

```
git clone --depth=1 git+https://github.org/jakub-oprsal/empty-manuscript
git remote remove origin
git commit --amend -m "empty manuscript"
```

## The structure and compiling

I use my own system for compiling/writing latex. The paper is compiled from a few files: `meta.yaml` containing the metadata, `macro.tex` containing TeX macros, `*.bib` that contains the bibliography, and `1_introduction.tex`, etc. that contain the content of the paper.  The main file `main.tex` is compiled from metadata and the content of the directory (this requires my `thead` python package which can be installed by `make install-thead` for convenience) using `make`, i.e., running `make main.tex`, or just `make` to get the pdf output.
