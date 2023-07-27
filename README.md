# Empty manuscript

This repository contains a starting point for my latex projects for paper manuscripts. Contains a base metadata, `makefile`, `.gitignore`, etc., so that it can be cloned to create a new project/paper. The intended use is:

```
git clone --depth=1 https://github.com/jakub-oprsal/empty-manuscript
cd empty-manuscript
make restart
```


## Compilation

The standard setup is a compilation using my custom python packages `thead`, `tmarko`, and a standard LaTeX framework using makefile. Both of the python requirements can be installed by:
```sh
python3 -m pip install git+https://github.com/jakub-oprsal/thead git+https://github.com/jakub-oprsal/tmarko
```

To briefly explain the system, the document is compiled by `make`. Which first create latex sources and then compiles latex (for the details, see makefile). The actual source of the document is then comprised of the following files:

- `meta.yaml` (contains metadata of the paper, e.g., title, authors, funding info)
- `recipe.yaml` (defines the structure of the latex document, and sources for bibliography)
- `macro.tex` (all the custom latex macros and packages)
- `1_introduction.md ...` (the actual content)
- `empty.bib ...` (bibliography, etc.)

