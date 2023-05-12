# Packages

One common question I get is "Do Julia have good packages?". Answer is yes!
Currently, (2023) there are around 8000 register packages.
This is nothing compared to R or Python. However, the sole number is not a guarantee of quality.

In Python and R, you don't have a lot of code reuse, meaning you can find in different packages code doing the same thing (distributions definitions, stats algorithms, ...).
This is because packages (often coded in C/C++ under the hood) are not made to communicate between each other.
In Julia, since everything is written in Julia and you can use multiple dispatch, using, manipulating and combining different packages is natural.

## Manipulating packages

It is very easy!

Il y a un package mode qui peut être activé dans le `REPL` grâce à `]`.

```
julia> ]
(@v1.9) pkg> 
```

C'est très pratique pour gérer (installer, mettre à jour, voir les version, déinstaller, etc.)

### Install

```
julia> ]
(@v1.9) pkg> add UnPackage
(@v1.9) pkg> add UnAutrePackage, EncoreUnAutre
```

ou dans le `REPL`

```
julia> using DataFramesMeta
 │ Package DataFramesMeta not found, but a package named DataFramesMeta is available from a registry. 
 │ Install package?
 │   (@v1.9) pkg> add DataFramesMeta
 └ (y/n/o) [y]:
```

faite `Entrer` ou `y` pour l'installer. Cette dernière fonction ne marche que dans le `REPL` (ça `add` et `using`).

Dans Jupyter ou on ne peut pas utiliser le mode package on peut installer des package avec dasn une cellule,

```julia
import Pkg
Pkg.add("UnPackage")
```

puis pour l'utiliser

```julia
using UnPackage
```

### Package Manager

In package mode, you can view your package list with `st` or `status`, update, remove, chose a specific version, activate an environment, ....

```
julia> ]
(@v1.9) pkg> st # status
(@v1.9) pkg> up # update all packages 
(@v1.9) pkg> rm PackageName # remove a package
(@v1.9) pkg> add PackageName
(@v1.9) pkg> activate .
```

<!-- TODO add more -->

## Package you'll need to do applied mathematics

Je vous laisse rajouter les liens des github ou doc pour chaque packages (à faire une fois ça vous servira d'avoir une page avec tous les liens plutot que de rechercher à chaque fois + c'est plus écolo d'éviter des recherches google).

- `CSV.jl` pour lire/save les fichier de données.
- `DataFrames.jl` pour lire manipuler les tableaux de données (comme `panda` en Python).
- `DataFramesMeta.jl` is an extansion of the previous package, it provides many convenient functions/macro to deal with data sets.
- `Plots.jl` pour faire des plots. Pour tracer des cartes on pourra en parler mais je suis obligé de passer par un package Python.
- `StatsPlots.jl` do the same as `Plots.jl` but add some usefuls statistics plots like boxplot, correlation plots, density plots, ...
- `StatsBase.jl` et `Statistics.jl` pour les opérations standards de stats.
