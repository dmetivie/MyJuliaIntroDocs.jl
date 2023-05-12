# MyJuliaIntro

## Installation

The easiest way to install and maintain up to date Julia is probably to use the [Juliaup](https://github.com/JuliaLang/juliaup) framework.

It uses one line on a terminal for Linux/Max and it is available directly from the "Windows Store" with one click on Windows.
It installs Julia and set the `PATH` variable.
Updates to new Julia version is then simply done with

```bash
juliaup update
```

## Tutorial and introductory material (non testé)

- [Cette vidéo de 100 second](https://www.youtube.com/watch?v=JYs_94znYy0)

- [Une liste "officiel"](https://julialang.org/learning/tutorials/)

- Livre [**Statistics with Julia:**](https://github.com/dmetivie/MyJuliaIntro.jl/blob/master/references/StatisticsWithJuliaDRAFT.pdf). Introduction aux stats avec Julia. Plein d'example de codes (voir leur site aussi) dans les référence.

- Internet. We all learn differently, there are plenty of different material (video, notebooks, webpage, forums, ...).

## Why is Julia so great?

Ici je compile quelques liens/messages/présentation mettant en avant le language Julia.

- From [this post](https://discourse.julialang.org/t/why-is-julia-so-great/94718/4) by [@lmiq](https://discourse.julialang.org/u/lmiq):

```quote
There are many things that can may be more or less important depending on the personal experience of each one. So for a general audience I tend to show things like:

- achievable performance, of course
- package management
- integration with documentation (help entries and Documenter.jl)
- simplicity of creating, distributing and registering packages
- syntax
- REPL and its features (Pkg and Shell integration), and notebooks
- domain-specific ecosystem: differential equations, non-linear programming, SciML
- plotting etc within the same environment

Each of these things may be available in other languages, but I don’t see any other combining all these features so well.

Then you can go for more language-specific features (multiple dispatch, composability, etc) but IMHO this is harder to understand from a utilitarian viewpoint from start.
```

I can add to this list benchmarking, which is super easy to do in Julia + there is one package that does it all. From my experience it is quite a pain in Python and R + there seem to be multiple options.

- [How to solve the same numerical problem in 7 different programming languages](https://medium.com/%40andreaskuhn92/how-to-solve-the-same-numerical-problem-in-7-different-programming-languages-a64daac3ed64)

- [Why Julia](https://github.com/johnfgibson/whyjulia)

- [Seven lines of code in Julia](https://discourse.julialang.org/t/seven-lines-of-julia-examples-sought/50416?filter%3Dsummary)
