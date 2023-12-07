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

Cela va installer quelques packages clés (vous pouvez en installer d'autres en avance, cf les notebooks). **Ça va prendre un certain temps!**

3. Comme IDE/notebook, nous allons tester VSCode, Jupyter et Pluto.
Dans VSCode installer l'[extension Julia](https://marketplace.visualstudio.com/items?itemName=julialang.language-julia). On pourra aussi utiliser l'[extension Jupyter](https://marketplace.visualstudio.com/items?itemName=ms-toolsai.jupyter).

!!! warning
    En Julia, la première fois que l'on fait quelque chose (installation, loader un pkg, executer une fonction, etc), ça prend du temps -> (pre)-compilation. Soyez patient, faites un café/thé!

!!! note
    Normalement, le `path` devrait être ajouté par `juliaup` lors de la phase 1. Parfois, il faut redémarrer VSCode. Vous pouvez tester l'extension Jupyter avec Julia en faisant dans un nouveau notebook `1+1`. On vous demandera de choisir un kernel, choisissez Julia. Ça devrait marcher.

!!! danger
    Sur Windows, il se peut que l'antivirus soit agressif en vers `juliaup` (d'expérience, il l'est avec tout le monde, ex: Matlab). Si vous n'avez pas la main pour ajouter une exception de sécurité, essayez l'[installation classique](https://julialang.org/downloads/).

## Notebooks que l'on va utiliser

J'ai divisé en plusieurs notebook la présentation pour alléger chacun et que vous puissiez vous concentrer sur ceux qui vous intéressent.

1. Présentation générique (notebook Pluto)
2. Exemple: multiple dispach (notebook Jupyter)
3. Exemple: performance + code générique (notebook Pluto). Pour fonctionner pleinement, celui-ci nécessite que vous ayez un compilateur C, R installé et Python avec `numpy`.
S'il vous manque un élément, le reste du notebook devrait fonctionner quand même.
4. Exemple: Optimisation et ODE (notebook Pluto)
5. Présentation des GANs
6. Application GAN avec le package `Flux.jl` sur l'ensemble de données MNIST (notebook Jupyter)

!!! note Notebook Pluto
    Pour charger un notebook Pluto, il ne s'agit que de fichiers `.jl` normaux avec de nombreux commentaires que Pluto utilisera pour générer le notebook et installer les packages.
    Pour charger un notebook Pluto, exécutez
    ```julia
    import Pluto; Pluto.run()
    ```
    Cela chargera une page dans votre navigateur Web. Là, trouvez votre cahier et ouvrez-le.
    Si vous ouvrez votre Julia dans le dossier du notebook, il sera plus facile de retrouver le fichier !
    Une fois à l’intérieur, cliquez sur Exécuter (l’aperçu en mode sans échec est une nouvelle fonctionnalité).
    Les notebooks Pluto peuvent être partagés et vue (sans Julia) au format `.html` statique, à partir de là, vous pouvez les exécuter en un clic avec Binder (cela prend cependant du temps).

!!! note Notebook Jupyter
    Si vous utilisez l'extension VSCode, ouvrez simplement le notebook « .ipynb » dans VSCode, puis sélectionnez le noyau Julia lorsque vous y êtes invité.
    Vous pouvez également utiliser le package [IJulia.jl](https://julialang.github.io/IJulia.jl/stable/manual/installation/) et suivre les instructions.

!!! warning Notebook Pluto : Première execution
    Lorsque vous lancez un notebook Pluto
        - tout le code s'exécutera en même temps
        - Si c'est la première fois que vous l'utilisez, tout le package sera installé, chargé, précompilé
    Cela prend donc du temps au début.
    Sur le plan positif, ils sont entièrement reproductibles, toutes les dépendances du code et de la version du package sont stockées dans le notebook. Et il suffit de les ouvrir et tout devrait fonctionner automatiquement.
