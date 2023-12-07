# [Talk 2 neurones](https://reseau2neurones.mathnum.inrae.fr/node/10)

## Programme

En deux heures, nous allons à la fois introduire les bases du langage de programmation Julia et les Réseaux Antagonistes Génératifs (GAN). Pour Julia, nous ne discuterons pas seulement de la rapidité, mais aussi de certaines fonctionnalités essentielles, telles que le "multiple dispach" (définition multiple), qui rendent le langage unique, par exemple en termes d’expressivité et de composition de packages.
Dans la dernière partie, après une brève introduction des concepts fondamentaux des GANS, nous effectuerons une application simple (en Julia !).

Le mode de présentation sera assez interactif avec des parties de présentations et d'autres de travaux pratiques/expérimentations.

## Date et lien visioconférence

Nous vous convions au webinaire qui aura lieu le mercredi 13 décembre de 14h à 16h, en utilisant le lien suivant : [https://inrae-fr.zoom.us/j/9303986691](https://inrae-fr.zoom.us/j/9303986691)

## Instructions d'installation

Pour installer Julia en amont de la présentation et quelques packages que nous utiliserons, je recommande :

1. [Juliaup](https://github.com/JuliaLang/juliaup) qui installe, gère le path et les versions (et plus) très simplement.
    - Sur Linux/Max:

    ```bash
    curl -fsSL https://install.julialang.org | sh
    ```

    - Sur Windows via le Windows store ([ici par exemple](https://apps.microsoft.com/detail/julia/9NJNWW8PVKMN?hl=fr-fr&gl=FR&rtc=1)), cherchez Julia puis "installer".

Pour tester l'install, taper juste

```bash
julia
```

    dans votre terminal (ou Windows Power Shell). Ça devrait ouvrir Julia.

2. Une fois dans Julia faite

```julia
import Pkg
#install
Pkg.add(["Pluto", "Plots", "BenchmarkTools"]) # notebook pkg, Plot pkg, timing pkg
Pkg.add(["Flux"]) # Deep learning pkg

#load (and compile the first time you load)
using Pluto, Plots, BenchmarkTools
using Flux
```

Cela va installer quelques packages clés (vous pouvez en installer d'autres en avance, cf les notebooks). **Ca va prendre un certain temps!**

3. Comme IDE/notebook, nous allons tester VSCode, Jupyter et Pluto.
Dans VSCode installer l'[extension Julia](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia). On pourra aussi utiliser l'[extension Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter).

!!! warning
    En Julia, la première fois que l'on fait quelque chose (installation, loader un pkg, executer une fonction, etc), ça prend du temps -> (pre)-compilation. Soyez patient, faites un café/thé!

!!! note
    Normalement, le `path` devrait être ajouté par `juliaup` lors de la phase 1. Parfois, il faut redémarrer VSCode. Vous pouvez tester l'extension Jupyter avec Julia en faisant dans un nouveau notebook `1+1`. On vous demandera de choisir un kernel, choisissez Julia. Ça devrait marcher.

!!! danger
    Sur Windows, il se peut que l'antivirus soit agressif en vers `juliaup` (d'expérience, il l'est avec tout le monde, ex: Matlab). Si vous n'avez pas la main pour ajouter une exception de sécurité, essayez l'[installation classique](https://julialang.org/downloads/).

## Notebooks we will use

1. Generic presentation (Pluto notebook)
2. Multiple dispach example (Jupyter notebook)
3. Example of speed and generic code (Pluto notebook). To fully run, this one require that you have some C compiler, R installed and Python with `numpy`.
4. Optimization & ODE example
5. GAN presentation
6. Application GAN with the `Flux.jl` package on the MNIST dataset (Jupyter notebook)

!!! note Pluto notebooks
    To load a Pluto notebooks are just regular `.jl` files with many comments that Pluto will use to generate the notebook and install the packages.

    To load a Pluto notebook, run
    ```julia
    import Pluto; Pluto.run()
    ```
    This will load a page in your web browser. There find your notebook and open it. 
    If you open your Julia inside the notebook folder, it will be easier to find the file!
    Once inside click on run (safe mode preview is a new feature). 
    
    Pluto notebooks can be shared as static `.html`, from there you can run them in one click with Binder (it takes time though).

!!! note Jupyter notebooks
    If you use the VSCode extension, then simply open the notebook `.ipynb` in VSCode, then select Julia kernel when asked.

    You can also use the [IJulia.jl](https://julialang.github.io/IJulia.jl/stable/manual/installation/) package and follow the instructions.

!!! warning Pluto notebooks: run them once
    When you launch a Pluto notebooks
        - all the code will run at once
        - If it is the first time you use it, all the package will be installed, loaded, precompile
    Hence it takes time at first.
    On the plus side they are fully reproductible, all the code, package version dependencies are stored inside the notebook. And you just have to open them and everything should work.



