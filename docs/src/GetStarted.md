
# To get started

## Generic coding advice

Have a good integrated development environment (IDE). It is a software application that helps programmers develop software code efficiently.

My personal favorite is `VSCode`. It is multi-language editor, you can do (non-exhaustive list) using VSCode extensions LaTeX, Julia, Python, Git, Jupyter Notebooks, R, Markdown, HTML, C, SSH, etc.
Your shortcut can remain the same for each language, for example `Ctl+/` will comment code whether I am doing LaTeX (with `%`), Julia (with `#`), etc.
It works on Linux/Mac/Windows.

!!! tip

    Learn how to use your IDE (shortcuts, functionalities, etc.) it is worth your time, since you will be using it a lot then!

Dévlopper/tester avec script dans VSCode (avec l'extansion Julia). Puis mettez vos résultats (choses qui marchent) au fur et à mesure dans un notebook (avec les figures).
Avoir les deux vous sera utile.

## Jargon

### `REPL` (Julia terminal)

On la lance soit avec le bouton ou raccourci dédié. Dans une console (si le `PATH` est bien réglé) avec `julia`.

Dans VSCode avec `Julia: start REPL` ou avec le dedicated shortcut for me it is `Alt+J` then `Alt+O`.

It looks like that

```@repl
1+1
"string"
```

Même si on ne l'utilise pas pour dévlopper ou écrire du code, le `REPL` est très pratique pour tester des petites chose ou encore gérer les package et pas mal d'autres choses (shell, R, aide,).
**Je vous conseil de vous faire la main dessus avec un script et le `REPL` dans VSCode** plutôt qu'un notebook au début.

### "in-place functions"

Par **convention** les fonction finnissant avec un point d'exclamation `!` modifie leur argument. (Notez bien que c'est une convention, si vous voulez pas une feature du language)

For example

```@repl inplace
x = [1, 2, 3]
function f!(x)
  for i in eachindex(x)
    x[i] = x[i] + 1
  end
end
f!(x)
x # = [2,3,4]
```

Ici `f!` modifie `x` "in place"

Même pour les plots, pour ajouter des points on uitilise cette convention.

```julia
p = plot(rand(10)) 
scatter!(p, rand(100), rand(100))
# pour les plots on peut retirer le `p` l'ajout des nouveaux point se fera sur la dernière figure.
```

### Broadcasting a.k.a. vectorization or dot operation

Pour appliquer une fonction à chaque élément d'un `array` en Julia on doit le déclarer explicitement (au contraire de Python ou c'est parfois implicite).

```@repl dotsum
x = [1, 2, 3]
x + 1 # Error! l'adittion n'est pas défini entre un nombre et un vecteur!!
```

Pour appliquer l'addition à chaque élément du vecteur on le note explicitement avec un point `.+` (ça "alourdit" les notations mais ça clarifie le code)

```@repl dotsum
x .+ 1 # = [2,3,4]
```

Pareil pour n'importe quelle user define function.

```@repl
f(x) = x+1
f([1,2,3]) # Error
f.([1,2,3]) # ça marche!
```
