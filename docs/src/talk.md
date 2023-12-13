# [Talk 2 neurones](https://reseau2neurones.mathnum.inrae.fr/node/10)

Page en construction! Contactez moi si quelque chose ne marche pas.

## Programme

En deux heures, nous allons à la fois introduire les bases du langage de programmation Julia et les Réseaux Antagonistes Génératifs (GAN). Pour Julia, nous ne discuterons pas seulement de la rapidité, mais aussi de certaines fonctionnalités essentielles, telles que le "multiple dispach" (définition multiple), qui rendent le langage unique, par exemple en termes d’expressivité et de composition de packages.
Dans la dernière partie, après une brève introduction des concepts fondamentaux des GANS, nous effectuerons une application simple (en Julia !).

Le mode de présentation sera assez interactif avec des parties de présentations et d'autres de travaux pratiques/expérimentations.

## Date et lien visioconférence

Nous vous convions au webinaire qui aura lieu le mercredi 13 décembre de 14h à 16h, en utilisant le lien suivant : [https://inrae-fr.zoom.us/j/9303986691](https://inrae-fr.zoom.us/j/9303986691)

## Instructions d'installation

Pour installer Julia en amont de la présentation et quelques packages que nous utiliserons, je recommande :

### [Juliaup](https://github.com/JuliaLang/juliaup)

[Juliaup](https://github.com/JuliaLang/juliaup) installe, gère le path et les versions (et plus) très simplement.

#### Linux/Max

Simply type in terminal:

```bash
curl -fsSL https://install.julialang.org | sh
```

#### Windows

Via le Windows store ([ici par exemple](https://apps.microsoft.com/detail/julia/9NJNWW8PVKMN?hl=fr-fr&gl=FR&rtc=1)), cherchez Julia puis "installer".

!!! danger
    Sur Windows, il se peut que l'antivirus soit agressif en vers `juliaup` (d'expérience, il l'est avec tout le monde, ex: Matlab). Si vous n'avez pas la main pour ajouter une exception de sécurité, essayez l'[installation classique](https://julialang.org/downloads/).

#### Tester l'installion

Dans votre terminal (PowerShell sur Windows) écrivez

```bash
julia
```

Ça devrait ouvrir Julia (et donc que les `path` ont bien été ajouté).

### Quelques Packages

Une fois dans Julia faite

```julia
import Pkg
#install
Pkg.add(["Pluto", "Plots", "BenchmarkTools"]) # notebook pkg, Plot pkg, timing pkg
Pkg.add(["Flux"]) # Deep learning pkg

#load (and compile the first time you load)
using Pluto, Plots, BenchmarkTools
using Flux
```

Cela va installer quelques packages clés (vous pouvez en installer d'autres en avance, cf les notebooks). **Ça va prendre un certain temps!**

!!! warning
    En Julia, la première fois que l'on fait quelque chose (installation, loader un pkg, executer une fonction, etc), ça prend du temps -> (pre)-compilation. Soyez patient, faites un café/thé!

### Éditeur, IDE, Notebook

Comme IDE/notebook, nous allons tester VSCode, Jupyter et Pluto.
Dans VSCode installer l'[extension Julia](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia). On pourra aussi utiliser l'[extension Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter).

!!! note
    Normalement, le `path` devrait être ajouté par `juliaup` lors de l'installation. Parfois, il faut redémarrer VSCode. Vous pouvez tester l'extension Jupyter avec Julia en faisant dans un nouveau notebook `1+1`. On vous demandera de choisir un kernel, choisissez Julia. Ça devrait marcher.

## Notebooks que l'on va utiliser

J'ai divisé en plusieurs notebook la présentation pour alléger chacun et que vous puissiez vous concentrer sur ceux qui vous intéressent.

1. Présentation de Julia (notebook Pluto)
2. [`notebook_2_multiple_dispach_on_animals.ipynb`](https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/master/notebooks/notebook_2_multiple_dispach_on_animals.ipynb) example de "multiple dispach" (notebook Jupyter) 
3. [`notebook_3_speed_sum_example.jl`](https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/master/notebooks/notebook_3_speed_sum_example.jl) exemple: performance + code générique (notebook Pluto). Pour fonctionner pleinement, celui-ci nécessite que vous ayez installé un compilateur C, R, Python  avec `numpy`. Même s'il vous manque un de ces éléments, le reste du notebook devrait fonctionner quand même.
4. Exemple: Optimisation + ODEs + Bayesian (notebook Pluto) [`notebook_4_Optim_DiffEq.jl`](https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/master/notebooks/notebook_4_Optim_DiffEq.jl). Un peu lourd!
5. Présentation des GANs
6. Application GAN avec le package `Flux.jl` d'abord sur un exemple simple [`notebook_5_GAN_simple_example.ipynb`](https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/9a3c4824d316b625d4c214b855cedc2973cd164e/notebooks/notebook_5_GAN_simple_example.ipynb) puis sur l'ensemble de données MNIST (notebook Jupyter) [`notebook_6_dcGAN_MNIST.ipynb`](https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/master/notebooks/notebook_6_dcGAN_MNIST.ipynb).

!!! note
    Voici une version `.html` (pas besoin de Julia) statique des notebooks [`notebook_3_speed_sum_example.jl`](https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/master/notebooks/notebook_3_speed_sum_example.html) et [`notebook_4_Optim_DiffEq.jl`](https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/master/notebooks/notebook_4_Optim_DiffEq.html)
### Notebook Pluto

Pour charger un notebook Pluto, il ne s'agit que de fichiers `.jl` normaux avec de nombreux commentaires que Pluto utilisera pour générer le notebook et installer les packages.
Pour charger un notebook Pluto, exécutez

```julia
import Pluto; Pluto.run()
```

Cela chargera une page dans votre navigateur Web. Là, trouvez votre cahier et ouvrez-le.
Si vous ouvrez votre Julia dans le dossier du notebook, il sera plus facile de retrouver le fichier !
Une fois à l’intérieur, cliquez sur Exécuter (l’aperçu en mode sans échec est une nouvelle fonctionnalité).
Les notebooks Pluto peuvent être partagés et vue (sans Julia) au format `.html` statique, à partir de là, vous pouvez les exécuter en un clic avec Binder (cela prend cependant du temps).

!!! warning
    Lorsque vous lancez un notebook Pluto:
    - Tout le code s'exécutera en même temps
    - Si c'est la première fois que vous l'utilisez, tout le package sera installé, chargé, précompilé
    Cela prend donc du temps au début.
    Le point **positif**, ces notebooks sont entièrement reproductibles, toutes les dépendances du code et de la version du package sont stockées dans le notebook (en commentaires). Il suffit d'ouvrir le notebook (et de le `run`) et tout devrait fonctionner automatiquement.

### Notebook Jupyter

Si vous utilisez l'extension VSCode, ouvrez simplement le notebook `.ipynb` dans VSCode, puis sélectionnez le noyau Julia lorsque vous y êtes invité.
Vous pouvez également utiliser le package [IJulia.jl](https://julialang.github.io/IJulia.jl/stable/manual/installation/) et suivre les instructions.
