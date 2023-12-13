var documenterSearchIndex = {"docs":
[{"location":"ScientificComputing/#CollabSci","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"","category":"section"},{"location":"ScientificComputing/#Personal-view-on-Scientific-computing","page":"Collaborative Scientific computing","title":"Personal view on Scientific computing","text":"","category":"section"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"I like Gaël Varoquaux' (2010) blog post: Personal views on scientific computing. He is leader of the sklearn package and this post does not mention Julia at all[1]. I believe most of the stuff discussed (TODO detail) there are answered with Julia. Plus, Julia brings the performance factor into the discussion.","category":"page"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"To go a step further, I believe that even if today's (2023) good open source practices are largely adopted most documentations and testing is limited. Meaning that people put package into the wild Rightarrow users will make the effort for developers.","category":"page"},{"location":"ScientificComputing/#Why-Julia-would-be-different?","page":"Collaborative Scientific computing","title":"Why Julia would be different?","text":"","category":"section"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"So far, I observe that this is not the too much the case with Julia. Why though?","category":"page"},{"location":"ScientificComputing/#One-language","page":"Collaborative Scientific computing","title":"One language","text":"","category":"section"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"Python/R are high level languages, meaning they are easy to read and develop natively. However, scientific applications are hard. At some point you need also performance. That is where C++ and compiled low level language come in. Most packages actually used are written in C++. Hence, you loose readability. Ok for matrix multiplication and inverse where super optimized libraries (BLAS, LAPACK) do the job for you, you probably don't need to understand the source code. For Machine learning?","category":"page"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"Hence, plenty of \"fast & readable\" libraries have been developed, but they are all separated packages not so composable. I like this image about Python ecosystem.","category":"page"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"(Image: Python strategy)","category":"page"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"How can, you contribute to packages written in C++?","category":"page"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"Learn C++.\nOr ask someone to translate your high level code into low level code. Then at each modification ask him again.","category":"page"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"In Julia, you have one natively performant[3], high level and expressive language to learn. Then you can contribute to most packages.  This is a very fruitful environment.","category":"page"},{"location":"ScientificComputing/#Functional-multiple-dispatch-vs-Object-Oriented-Programming","page":"Collaborative Scientific computing","title":"Functional + multiple dispatch vs Object-Oriented Programming","text":"","category":"section"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"TODO","category":"page"},{"location":"ScientificComputing/#Package-development","page":"Collaborative Scientific computing","title":"Package development","text":"","category":"section"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"Packages like PkgTemplates.jl are the standard for package creation, they create a CI.yml file and an associated runtest.jl file. Using the base package Tests.jl it is then super easy to write tests that are tested with GitHub actions. Versioning is also very easy.\nDocumenters.jl package[2] allows developing documentation very easily. The online deployment is also very easy (GitPage).","category":"page"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"[1]: Mainly because 20102012. I don't know his current point of view on Julia.","category":"page"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"[2]: Plus friends like LiveServer.jl.","category":"page"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"[3]: People are sometime skeptical about that. Sure it might not be the most performant for every operation. However, it is of the order of magnitude of low level languages, which for scientific computing might be enough.","category":"page"},{"location":"ScientificComputing/","page":"Collaborative Scientific computing","title":"Collaborative Scientific computing","text":"Sure if you are not an expert coder you might write kind of slow code. However, your code can be optimized within the same language (and learn better Julia in the process).","category":"page"},{"location":"talk/#[Talk-2-neurones](https://reseau2neurones.mathnum.inrae.fr/node/10)","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Page en construction! Contactez moi si quelque chose ne marche pas.","category":"page"},{"location":"talk/#Programme","page":"Talk 2 neurones","title":"Programme","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"En deux heures, nous allons à la fois introduire les bases du langage de programmation Julia et les Réseaux Antagonistes Génératifs (GAN). Pour Julia, nous ne discuterons pas seulement de la rapidité, mais aussi de certaines fonctionnalités essentielles, telles que le \"multiple dispach\" (définition multiple), qui rendent le langage unique, par exemple en termes d’expressivité et de composition de packages. Dans la dernière partie, après une brève introduction des concepts fondamentaux des GANS, nous effectuerons une application simple (en Julia !).","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Le mode de présentation sera assez interactif avec des parties de présentations et d'autres de travaux pratiques/expérimentations.","category":"page"},{"location":"talk/#Date-et-lien-visioconférence","page":"Talk 2 neurones","title":"Date et lien visioconférence","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Nous vous convions au webinaire qui aura lieu le mercredi 13 décembre de 14h à 16h, en utilisant le lien suivant : https://inrae-fr.zoom.us/j/9303986691","category":"page"},{"location":"talk/#Instructions-d'installation","page":"Talk 2 neurones","title":"Instructions d'installation","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Pour installer Julia en amont de la présentation et quelques packages que nous utiliserons, je recommande :","category":"page"},{"location":"talk/#[Juliaup](https://github.com/JuliaLang/juliaup)","page":"Talk 2 neurones","title":"Juliaup","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Juliaup installe, gère le path et les versions (et plus) très simplement.","category":"page"},{"location":"talk/#Linux/Max","page":"Talk 2 neurones","title":"Linux/Max","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Simply type in terminal:","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"curl -fsSL https://install.julialang.org | sh","category":"page"},{"location":"talk/#Windows","page":"Talk 2 neurones","title":"Windows","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Via le Windows store (ici par exemple), cherchez Julia puis \"installer\".","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"danger: Danger\nSur Windows, il se peut que l'antivirus soit agressif en vers juliaup (d'expérience, il l'est avec tout le monde, ex: Matlab). Si vous n'avez pas la main pour ajouter une exception de sécurité, essayez l'installation classique.","category":"page"},{"location":"talk/#Tester-l'installion","page":"Talk 2 neurones","title":"Tester l'installion","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Dans votre terminal (PowerShell sur Windows) écrivez","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"julia","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Ça devrait ouvrir Julia (et donc que les path ont bien été ajouté).","category":"page"},{"location":"talk/#Quelques-Packages","page":"Talk 2 neurones","title":"Quelques Packages","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Une fois dans Julia faite","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"import Pkg\n#install\nPkg.add([\"Pluto\", \"Plots\", \"BenchmarkTools\"]) # notebook pkg, Plot pkg, timing pkg\nPkg.add([\"Flux\"]) # Deep learning pkg\n\n#load (and compile the first time you load)\nusing Pluto, Plots, BenchmarkTools\nusing Flux","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Cela va installer quelques packages clés (vous pouvez en installer d'autres en avance, cf les notebooks). Ça va prendre un certain temps!","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"warning: Warning\nEn Julia, la première fois que l'on fait quelque chose (installation, loader un pkg, executer une fonction, etc), ça prend du temps -> (pre)-compilation. Soyez patient, faites un café/thé!","category":"page"},{"location":"talk/#Éditeur,-IDE,-Notebook","page":"Talk 2 neurones","title":"Éditeur, IDE, Notebook","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Comme IDE/notebook, nous allons tester VSCode, Jupyter et Pluto. Dans VSCode installer l'extension Julia. On pourra aussi utiliser l'extension Jupyter.","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"note: Note\nNormalement, le path devrait être ajouté par juliaup lors de l'installation. Parfois, il faut redémarrer VSCode. Vous pouvez tester l'extension Jupyter avec Julia en faisant dans un nouveau notebook 1+1. On vous demandera de choisir un kernel, choisissez Julia. Ça devrait marcher.","category":"page"},{"location":"talk/#Notebooks-que-l'on-va-utiliser","page":"Talk 2 neurones","title":"Notebooks que l'on va utiliser","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"J'ai divisé en plusieurs notebook la présentation pour alléger chacun et que vous puissiez vous concentrer sur ceux qui vous intéressent.","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Présentation de Julia notebook_1_Presentation.jl (notebook Pluto)\nnotebook_2_multiple_dispach_on_animals.ipynb example de \"multiple dispach\" (notebook Jupyter) \nnotebook_3_speed_sum_example.jl exemple: performance + code générique (notebook Pluto). Pour fonctionner pleinement, celui-ci nécessite que vous ayez installé un compilateur C, R, Python  avec numpy. Même s'il vous manque un de ces éléments, le reste du notebook devrait fonctionner quand même.\nExemple: Optimisation + ODEs + Bayesian (notebook Pluto) notebook_4_Optim_DiffEq.jl. Un peu lourd!\nPrésentation des GANs, le beamer pdf.\nApplication GAN avec le package Flux.jl d'abord sur un exemple simple notebook_5_GAN_simple_example.ipynb puis sur l'ensemble de données MNIST (notebook Jupyter) notebook_6_dcGAN_MNIST.ipynb.","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"note: Note\nVoici une version .html (pas besoin de Julia) statique des notebooks (à télécharger et ouvrir dans un navigateur) notebook_1_Presentation.html,  notebook_3_speed_sum_example.html et notebook_4_Optim_DiffEq.html","category":"page"},{"location":"talk/#Notebook-Pluto","page":"Talk 2 neurones","title":"Notebook Pluto","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Pour charger un notebook Pluto, il ne s'agit que de fichiers .jl normaux avec de nombreux commentaires que Pluto utilisera pour générer le notebook et installer les packages. Pour charger un notebook Pluto, exécutez","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"import Pluto; Pluto.run()","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Cela chargera une page dans votre navigateur Web. Là, trouvez votre cahier et ouvrez-le. Si vous ouvrez votre Julia dans le dossier du notebook, il sera plus facile de retrouver le fichier ! Une fois à l’intérieur, cliquez sur Exécuter (l’aperçu en mode sans échec est une nouvelle fonctionnalité). Les notebooks Pluto peuvent être partagés et vue (sans Julia) au format .html statique, à partir de là, vous pouvez les exécuter en un clic avec Binder (cela prend cependant du temps).","category":"page"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"warning: Warning\nLorsque vous lancez un notebook Pluto:Tout le code s'exécutera en même temps\nSi c'est la première fois que vous l'utilisez, tout le package sera installé, chargé, précompiléCela prend donc du temps au début. Le point positif, ces notebooks sont entièrement reproductibles, toutes les dépendances du code et de la version du package sont stockées dans le notebook (en commentaires). Il suffit d'ouvrir le notebook (et de le run) et tout devrait fonctionner automatiquement.","category":"page"},{"location":"talk/#Notebook-Jupyter","page":"Talk 2 neurones","title":"Notebook Jupyter","text":"","category":"section"},{"location":"talk/","page":"Talk 2 neurones","title":"Talk 2 neurones","text":"Si vous utilisez l'extension VSCode, ouvrez simplement le notebook .ipynb dans VSCode, puis sélectionnez le noyau Julia lorsque vous y êtes invité. Vous pouvez également utiliser le package IJulia.jl et suivre les instructions.","category":"page"},{"location":"FAQ/#Get-Help","page":"Get Help","title":"Get Help","text":"","category":"section"},{"location":"FAQ/","page":"Get Help","title":"Get Help","text":"You are always learning. Getting help is expected especially when you begin a new language (and even after).","category":"page"},{"location":"FAQ/","page":"Get Help","title":"Get Help","text":"You can have questions like","category":"page"},{"location":"FAQ/","page":"Get Help","title":"Get Help","text":"What is this function doing\nHow to use this function\nHow to do something\nWhy this is not working\nWhat is the best way to do something. By best is can mean several things.\nThe most \"idiomatic\", i.e. the most Julia-like way to do something e.g. using functions, defining struct, use multiple dispatch, in place operation etc.\nThe fastest e.g. Julia is column major language, hence it is faster to go through matrix column after columns (and not rows after rows).\nThe shortest in terms of code length e.g. replacing a for loop by a vectorized call\nThe most generic way,\n???","category":"page"},{"location":"FAQ/#Help-about-functions","page":"Get Help","title":"Help about functions","text":"","category":"section"},{"location":"FAQ/","page":"Get Help","title":"Get Help","text":"Dans VScode grâce à l'extansion Julia vous pouvez paasser le curseur sur une fonction pour avoir des infos dessus.","category":"page"},{"location":"FAQ/","page":"Get Help","title":"Get Help","text":"Dans le REPL vous pouvez taper ? et le nom de la fonction (ou autre objet) pour avoir les infos des docs dessus.","category":"page"},{"location":"FAQ/","page":"Get Help","title":"Get Help","text":"help?> Normal\nsearch: Normal normalize NormalCanon normalize! normalize_hue NormalInverseGaussian MvNormal MvNormalCanon MvNormalKnownCov LogNormal IsoNormal IsoNormalCanon SkewNormal FullNormal DiagNormal FullNormalCanon DiagNormalCanon MvLogNormal\n  Normal(μ,σ)\n\n  The Normal distribution with mean μ and standard deviation σ≥0 has probability density function\n\n  f(x; \\mu, \\sigma) = \\frac{1}{\\sqrt{2 \\pi \\sigma^2}}\n\\exp \\left( - \\frac{(x - \\mu)^2}{2 \\sigma^2} \\right)\n\n  Note that if σ == 0, then the distribution is a point mass concentrated at μ. Though not technically a continuous distribution, it is allowed so as to account for cases where σ may have underflowed, and the functions are defined by  \n  taking the pointwise limit as σ → 0.\n\n  Normal()          # standard Normal distribution with zero mean and unit variance\n  Normal(μ)         # Normal distribution with mean μ and unit variance\n  Normal(μ, σ)      # Normal distribution with mean μ and variance σ^2\n  \n  params(d)         # Get the parameters, i.e. (μ, σ)\n  mean(d)           # Get the mean, i.e. μ\n  std(d)            # Get the standard deviation, i.e. σ\n\n  External links\n\n    •  Normal distribution on Wikipedia (http://en.wikipedia.org/wiki/Normal_distribution)","category":"page"},{"location":"FAQ/","page":"Get Help","title":"Get Help","text":"Sinon les docs des gros packages sont très bien faites. Vous tapez le nom du package et soit vous tombez sur le GitHub du package soit sur la doc. Depuis le GitHub vous pouvez trouvez lorsqu'il existe le lien pour la doc en bleu vers le haut du Readme.md","category":"page"},{"location":"FAQ/","page":"Get Help","title":"Get Help","text":"Sinon la FAQ","category":"page"},{"location":"FAQ/#FAQ","page":"Get Help","title":"FAQ","text":"","category":"section"},{"location":"FAQ/","page":"Get Help","title":"Get Help","text":"Taper sur internet (en anglais) \"Julia how to ....\". En général les questions ont déjà été posé. Les deux forum les plus utilisé sont Julia discourse et stackoverflow (ce dernier est en général utilisé par les gens qui ne savent pas qu'il vaut mieux utiliser le Julia discourse mais on y trouve parfois des réponses).","category":"page"},{"location":"FAQ/","page":"Get Help","title":"Get Help","text":"warning: Warning\nOnline answers are sometimes a bit old.\nJulia language evolved quite a bit compared to older versions.\nIl y a une grosse différence entre les version `1.xx` et les `0.xx`.\nWe are now at version `1.9` (May 11, 2023).","category":"page"},{"location":"FAQ/","page":"Get Help","title":"Get Help","text":"Ask me\nAsk online, with a nice Minimal Working Example (MWE)","category":"page"},{"location":"GetStarted/#To-get-started","page":"To get started","title":"To get started","text":"","category":"section"},{"location":"GetStarted/#Generic-coding-advice","page":"To get started","title":"Generic coding advice","text":"","category":"section"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Have a good Integrated Development Environment (IDE). It is a software application that helps programmers develop software code efficiently i.e. you can do plots in the editor, you have a terminal, autocompletion, linting etc. Example of IDE are VSCode, RStudio, PyCharm, Matlab terminal, Vim (is it an IDE?), Notebooks (not sure if it is exactly an IDE) etc.","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"My personal favorite is VSCode. It is multi-language editor, you can do (non-exhaustive list) using VSCode extensions LaTeX, Julia, Python, SSH for Cluster, Git, Jupyter Notebooks, R, Markdown, HTML, C, etc. Your shortcuts remain the same for each language, for example Ctl+/ will comment code whether I am doing LaTeX (with %), Julia (with #), etc. It works on Linux/Mac/Windows.","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"tip: Tip\nLearn how to use your IDE (shortcuts, functionalities, appearance, etc.) it is worth your time, since you will be using it a lot!","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Dévlopper/tester avec script dans VSCode (avec l'extansion Julia). Puis mettez vos résultats (choses qui marchent) au fur et à mesure dans un notebook (avec les figures). Avoir les deux vous sera utile.","category":"page"},{"location":"GetStarted/#Jargon","page":"To get started","title":"Jargon","text":"","category":"section"},{"location":"GetStarted/#REPL-(Julia-terminal)","page":"To get started","title":"REPL (Julia terminal)","text":"","category":"section"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"On la lance soit avec le bouton ou raccourci dédié. Dans une console (si le PATH est bien réglé) avec julia.","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Dans VSCode avec Julia: start REPL ou avec le dedicated shortcut for me it is Alt+J then Alt+O.","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"It looks like that","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"1+1\n\"string\"","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Même si on ne l'utilise pas pour dévlopper ou écrire du code, le REPL est très pratique pour tester des petites chose ou encore gérer les package et pas mal d'autres choses (shell, R, aide,). Je vous conseil de vous faire la main dessus avec un script et le REPL dans VSCode plutôt qu'un notebook au début.","category":"page"},{"location":"GetStarted/#\"in-place-functions\"","page":"To get started","title":"\"in-place functions\"","text":"","category":"section"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Par convention les fonction finnissant avec un point d'exclamation ! modifie leur argument. (Notez bien que c'est une convention, si vous voulez pas une feature du language)","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"For example","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"x = [1, 2, 3]\nfunction f!(x)\n  for i in eachindex(x)\n    x[i] = x[i] + 1\n  end\nend\nf!(x)\nx # = [2,3,4]","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Ici f! modifie x \"in place\"","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Même pour les plots, pour ajouter des points on uitilise cette convention.","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"p = plot(rand(10)) \nscatter!(p, rand(100), rand(100))\n# pour les plots on peut retirer le `p` l'ajout des nouveaux point se fera sur la dernière figure.","category":"page"},{"location":"GetStarted/#Broadcasting-a.k.a.-vectorization-or-dot-operation","page":"To get started","title":"Broadcasting a.k.a. vectorization or dot operation","text":"","category":"section"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Pour appliquer une fonction à chaque élément d'un array en Julia on doit le déclarer explicitement (au contraire de Python ou c'est parfois implicite).","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"x = [1, 2, 3]\nx + 1 # Error! l'adittion n'est pas défini entre un nombre et un vecteur!!","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Pour appliquer l'addition à chaque élément du vecteur on le note explicitement avec un point .+ (ça \"alourdit\" les notations mais ça clarifie le code)","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"x .+ 1 # = [2,3,4]","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Pareil pour n'importe quelle user define function.","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"f(x) = x+1\nf([1,2,3]) # Error\nf.([1,2,3]) # ça marche!","category":"page"},{"location":"GetStarted/#Macros","page":"To get started","title":"Macros","text":"","category":"section"},{"location":"GetStarted/#Multiple-dispatch","page":"To get started","title":"Multiple dispatch","text":"","category":"section"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"It is a sort of generalization of function overloading.","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Basically one function will act differently depending on the type of its arguments.","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Example, let's consider the power function f(x) = x^p. Mathematically, if p is an integer then one can just multiply p-times x. If not one can always use f(x) = exp(p log(x)) (for positive x). In Julia, thanks to multiple dispatch you can code that just like","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"f(x, p::Integer) = prod(fill(x, p))","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"and","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"f(x, p) = exp(p*log(x))","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Then, at compile time, the compiler will be able to infer which method of f to use.","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"@time f(1.001, 20000)\n@time f(1.001, 20000.)","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"f(2, 2) # call first function\nf(2, 2.) # call second function","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"This is an amazing feature for multiple reasons:","category":"page"},{"location":"GetStarted/","page":"To get started","title":"To get started","text":"Helps make code generic\nFast\nReadable","category":"page"},{"location":"packages/#Packages","page":"Packages","title":"Packages","text":"","category":"section"},{"location":"packages/","page":"Packages","title":"Packages","text":"One common question I get is \"Does Julia have good packages?\". Answer is yes! Currently, (2023) there are around 8000 register packages. This is nothing compared to R or Python. However, the sole number is not a guarantee of quality.","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"In Python and R, you don't have a lot of code reuse, meaning you can find in different packages code doing the same thing (distributions definitions, stats algorithms, Markov chain...). This is because packages (often coded in C/C++ under the hood) are not made to communicate between each other. In Julia, since everything is written in Julia and you can use multiple dispatch, using, manipulating and combining different packages is natural.","category":"page"},{"location":"packages/#Manipulating-packages","page":"Packages","title":"Manipulating packages","text":"","category":"section"},{"location":"packages/","page":"Packages","title":"Packages","text":"It is very easy!","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"Il y a un package mode qui peut être activé dans le REPL grâce à ].","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"julia> ]\n(@v1.9) pkg> ","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"C'est très pratique pour gérer (installer, mettre à jour, voir les version, déinstaller, etc.)","category":"page"},{"location":"packages/#Install","page":"Packages","title":"Install","text":"","category":"section"},{"location":"packages/","page":"Packages","title":"Packages","text":"julia> ]\n(@v1.9) pkg> add UnPackage\n(@v1.9) pkg> add UnAutrePackage, EncoreUnAutre","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"ou dans le REPL","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"julia> using DataFramesMeta\n │ Package DataFramesMeta not found, but a package named DataFramesMeta is available from a registry. \n │ Install package?\n │   (@v1.9) pkg> add DataFramesMeta\n └ (y/n/o) [y]:","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"faite Entrer ou y pour l'installer. Cette dernière fonction ne marche que dans le REPL (ça add et using).","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"Dans Jupyter ou on ne peut pas utiliser le mode package on peut installer des package avec dasn une cellule,","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"import Pkg\nPkg.add(\"UnPackage\")","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"puis pour l'utiliser","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"using UnPackage","category":"page"},{"location":"packages/#Package-Manager","page":"Packages","title":"Package Manager","text":"","category":"section"},{"location":"packages/","page":"Packages","title":"Packages","text":"In package mode, you can view your package list with st or status, update, remove, chose a specific version, activate an environment, ....","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"julia> ]\n(@v1.9) pkg> st # status\n(@v1.9) pkg> up # update all packages \n(@v1.9) pkg> rm PackageName # remove a package\n(@v1.9) pkg> add PackageName\n(@v1.9) pkg> activate .","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"<!– TODO add more –>","category":"page"},{"location":"packages/#Package-you'll-need-to-do-applied-mathematics","page":"Packages","title":"Package you'll need to do applied mathematics","text":"","category":"section"},{"location":"packages/","page":"Packages","title":"Packages","text":"Je vous laisse rajouter les liens des github ou doc pour chaque packages (à faire une fois ça vous servira d'avoir une page avec tous les liens plutot que de rechercher à chaque fois + c'est plus écolo d'éviter des recherches google).","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"CSV.jl pour lire/save les fichier de données.\nDataFrames.jl pour lire manipuler les tableaux de données (comme panda en Python).\nDataFramesMeta.jl is an extansion of the previous package, it provides many convenient functions/macro to deal with data sets.\nPlots.jl pour faire des plots. Pour tracer des cartes on pourra en parler mais je suis obligé de passer par un package Python.\nStatsPlots.jl do the same as Plots.jl but add some usefuls statistics plots like boxplot, correlation plots, density plots, ...\nStatsBase.jl et Statistics.jl pour les opérations standards de stats.","category":"page"},{"location":"packages/#Using-R,-Python,-C,-Matlab-within-Julia","page":"Packages","title":"Using R, Python, C, Matlab within Julia","text":"","category":"section"},{"location":"packages/","page":"Packages","title":"Packages","text":"Most of other language can be used within Julia painlessly. Most of the time you can just copy and paste R/Python/etc code in your script surrounded by some macro and that just work. It is very easy to send, receive, call function in Julia code.","category":"page"},{"location":"packages/#R","page":"Packages","title":"R","text":"","category":"section"},{"location":"packages/","page":"Packages","title":"Packages","text":"It is quite easy just install RCall.jl and follow the instruction. You can even use the R console within the Julia console.","category":"page"},{"location":"packages/#Python","page":"Packages","title":"Python","text":"","category":"section"},{"location":"packages/","page":"Packages","title":"Packages","text":"For Python, the standard[1] is to use PythonCall.jl and CondaPkg.jl.","category":"page"},{"location":"packages/","page":"Packages","title":"Packages","text":"[1]: I used PyCall.jl and Conda.jl but apparently the other one are better.","category":"page"},{"location":"#My-Julia-Introduction","page":"My Julia Introduction","title":"My Julia Introduction","text":"","category":"section"},{"location":"","page":"My Julia Introduction","title":"My Julia Introduction","text":"This documentation is meant for Julia beginner like my students.","category":"page"},{"location":"#What-is-Julia?","page":"My Julia Introduction","title":"What is Julia?","text":"","category":"section"},{"location":"","page":"My Julia Introduction","title":"My Julia Introduction","text":"What: Julia is a relatively new computing language (2012), that is highly readable and efficient. It is meant to be multipurpose. Its foundations rely on all good ideas from previous language to make one \"super\" software. I like this short blog post from Julia creators from 2012. It explains in what context and with what ambitions, Julia was launched.","category":"page"},{"location":"#Installation","page":"My Julia Introduction","title":"Installation","text":"","category":"section"},{"location":"","page":"My Julia Introduction","title":"My Julia Introduction","text":"The easiest way to install and maintain up-to-date Julia is probably to use the Juliaup framework.","category":"page"},{"location":"","page":"My Julia Introduction","title":"My Julia Introduction","text":"It uses one line on a terminal for Linux/Max, and it is available directly from the \"Windows Store\" with one click on Windows. It installs Julia and set the PATH variable. Updates to new Julia version is then simply done with","category":"page"},{"location":"","page":"My Julia Introduction","title":"My Julia Introduction","text":"juliaup update","category":"page"},{"location":"#Tutorial-and-introductory-material-(non-testé)","page":"My Julia Introduction","title":"Tutorial and introductory material (non testé)","text":"","category":"section"},{"location":"","page":"My Julia Introduction","title":"My Julia Introduction","text":"Cette vidéo de 100 second\nUne liste \"officiel\"\nThis book/website with a specific focus on Data Science\nLivre Statistics with Julia:. Introduction aux stats avec Julia. Plein d'example de codes (voir leur site aussi) dans les référence.\nInternet. We all learn differently, there are plenty of different material (video, notebooks, webpage, forums, ...).","category":"page"},{"location":"#Why-is-Julia-so-great?","page":"My Julia Introduction","title":"Why is Julia so great?","text":"","category":"section"},{"location":"","page":"My Julia Introduction","title":"My Julia Introduction","text":"Here I compile some cool/fancy link/post/presentation showcasting Julia. If you want more in depth discussion about Julia and collaborative scientific computing go to this section.","category":"page"},{"location":"","page":"My Julia Introduction","title":"My Julia Introduction","text":"Ici je compile quelques liens/messages/présentation mettant en avant le language Julia.","category":"page"},{"location":"","page":"My Julia Introduction","title":"My Julia Introduction","text":"Inspired from this post by @lmiq:","category":"page"},{"location":"","page":"My Julia Introduction","title":"My Julia Introduction","text":"There are many things that can may be more or less important depending on the personal experience of each one. So for a general audience I tend to show things like:\n- achievable performance, of course\n- syntax\n- package management (installatin, update etc, is done within Julia and it just works)\n- Usage: REPL and its features (Pkg and Shell integration), and notebooks (Jupyter and Pluto)\n- Plotting etc within the same environment\n- domain-specific ecosystem: differential equations, non-linear programming, SciML\n- simplicity of creating, distributing and registering packages\n- integration with documentation (help entries and Documenter.jl)\n\nEach of these things may be available in other languages, but I don’t see any other combining all these features so well.\n\nThen you can go for more language-specific features (multiple dispatch, composability, etc) but IMHO this is harder to understand from a utilitarian viewpoint from start.\n\nI can add to this list benchmarking, which is super easy to do in Julia + there is one package that does it all. From my experience it is quite a pain in Python and R + there seem to be multiple options.","category":"page"},{"location":"","page":"My Julia Introduction","title":"My Julia Introduction","text":"Why Julia? for programmer and non programmers.\nHow to solve the same numerical problem in 7 different programming languages\nWhy Julia\nSeven lines of code in Julia","category":"page"}]
}
