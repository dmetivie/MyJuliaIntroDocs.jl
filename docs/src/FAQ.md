# Get Help

You are always learning.
Getting help is expected especially when you begin a new language (and even after).

You can have questions like

- What is this function doing
- How to use this function
- How to do something
- Why this is not working
- What is the best way to do something. By best is can mean several things.
  - The most "idiomatic", i.e. the most Julia-like way to do something e.g. using functions, defining `struct`, use multiple dispatch, in place operation etc.
  - The fastest e.g. Julia is column major language, hence it is faster to go through matrix column after columns (and not rows after rows).
  - The shortest in terms of code length e.g. replacing a for loop by a vectorized call
  - The most generic way,
  - ???

## Help about functions

Dans VScode grâce à l'extansion Julia vous pouvez paasser le curseur sur une fonction pour avoir des infos dessus.

Dans le `REPL` vous pouvez taper `?` et le nom de la fonction (ou autre objet) pour avoir les infos des docs dessus.

```
help?> Normal
search: Normal normalize NormalCanon normalize! normalize_hue NormalInverseGaussian MvNormal MvNormalCanon MvNormalKnownCov LogNormal IsoNormal IsoNormalCanon SkewNormal FullNormal DiagNormal FullNormalCanon DiagNormalCanon MvLogNormal
  Normal(μ,σ)

  The Normal distribution with mean μ and standard deviation σ≥0 has probability density function

  f(x; \mu, \sigma) = \frac{1}{\sqrt{2 \pi \sigma^2}}
\exp \left( - \frac{(x - \mu)^2}{2 \sigma^2} \right)

  Note that if σ == 0, then the distribution is a point mass concentrated at μ. Though not technically a continuous distribution, it is allowed so as to account for cases where σ may have underflowed, and the functions are defined by  
  taking the pointwise limit as σ → 0.

  Normal()          # standard Normal distribution with zero mean and unit variance
  Normal(μ)         # Normal distribution with mean μ and unit variance
  Normal(μ, σ)      # Normal distribution with mean μ and variance σ^2
  
  params(d)         # Get the parameters, i.e. (μ, σ)
  mean(d)           # Get the mean, i.e. μ
  std(d)            # Get the standard deviation, i.e. σ

  External links

    •  Normal distribution on Wikipedia (http://en.wikipedia.org/wiki/Normal_distribution)
```

Sinon les docs des gros packages sont très bien faites. Vous tapez le nom du package et soit vous tombez sur le GitHub du package soit sur la doc.
Depuis le GitHub vous pouvez trouvez lorsqu'il existe le lien pour la doc en bleu vers le haut du `Readme.md`

Sinon la [FAQ](https://github.com/dmetivie/2022_Projet_M1_SSD_B/blob/main/Julia/README.md#L112##FAQ)

## FAQ

- Taper sur internet (en anglais) "Julia how to ....". En général les questions ont déjà été posé. Les deux forum les plus utilisé sont [Julia discourse](https://discourse.julialang.org/) et [stackoverflow](https://stackoverflow.com/) (ce dernier est en général utilisé par les gens qui ne savent pas qu'il vaut mieux utiliser le [Julia discourse](https://discourse.julialang.org/) mais on y trouve parfois des réponses).
!!! warning
        Online answers are sometimes a bit old.
        Julia language evolved quite a bit compared to older versions.
        Il y a une grosse différence entre les version `1.xx` et les `0.xx`.
        We are now at version `1.9` (May 11, 2023).
- Ask me
- Ask online, with a nice Minimal Working Example (MWE)
