### A Pluto.jl notebook ###
# v0.20.5

#> custom_attrs = ["hide-enabled"]
#> 
#> [frontmatter]
#> title = "Introduction to Julia"
#> date = "2023-12-13"
#> 
#>     [[frontmatter.author]]
#>     name = "David Métivier"
#>     url = "https://david.metivier.pages.mia.inra.fr/website/"

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    return quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 8edb1e45-934a-453c-a5e2-4e5a7847767a
begin
	using BenchmarkTools
	# using Graphs
	using IntervalArithmetic: interval
	using DataFrames
	using Dates

	using LinearAlgebra
	using LogarithmicNumbers
	using Measurements
	using Pkg
	using Plots
	using Distributions
	using Symbolics # Symbolic 
	using Unitful # Physics unit
end

# ╔═╡ dbc5dedf-cc89-4eb2-96dc-9fbeec25025d
begin
	using HypertextLiteral
	using PlutoUI
	using PlutoTeachingTools
	using PlutoExtras
	using PlutoTest
	using ShortCodes
	using PlutoReport: Title, centerslidebreak
end

# ╔═╡ 908af3d7-63ba-4e79-9311-786bce192079
md"""
Click on the button bellow to go to presentation mode. Then use keyboard arrows to navigate. 
(Sometime you have to click on the rigth of the notebook for arrows to work.)
You can fold/unfold the table of content.
"""

# ╔═╡ 6afdd882-b89b-4bad-9aa4-cd4867551b92
click_to_present = present_button()

# ╔═╡ 918409c6-896b-4395-b73e-25a52a550798
Title("Presenting the Julia Programming Language", "and application to GANs", "David Métivier", "MISTEA - INRAE")

# ╔═╡ 02ef5c10-95ec-41b8-ba31-6f9ea8521106
TwoColumnWideLeft(
	md"""
	$(Resource("https://www.science-accueil.org/wp-content/uploads/2021/11/Logo-INRAE_Transparent-1536x406.png", :width => 450))
	""", 
	Resource("https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/bd54deca5b4a8230ff4ddad73e7429738bba839e/figs/logos/MISTEA_inrae.png?raw=true", :with => 500)
)

# ╔═╡ a82888b4-c842-4e15-9696-06a707547c32
md"""
[^credit]: This talk was partly inspired by [Guillaume Dalle Julia talk](https://gdalle.github.io/) + [Tim Holy lectures](https://github.com/timholy/AdvancedScientificComputing/tree/main) + videos and link shown in the notebook
"""

# ╔═╡ 88dd0962-6bef-4451-8083-a898603ba7f6
centerslidebreak

# ╔═╡ ec18f430-1b1c-4967-9689-6e2904e56ada
md"""
**About me**
"""

# ╔═╡ a8f66490-b43e-484d-80cb-fa7c74370d70
Resource("http://davidmetivier.mistea.inrae.fr/pic/research/flowchart_inrae.svg", :width => 900)

# ╔═╡ cc0a50bf-60ed-4291-a704-9b1095335ab3
md"""
**Coding experience**

- Matlab/Mathematica (Internship)
- C (with GPU) with Gnuplot/xmgrace (School and PhD)
- Very few Python at (School and PhD)
- Julia (Los Alamos Postdoc 1 2018)
"""

# ╔═╡ 08413add-1c85-4922-a47a-66e5d4944a1d
md"""
**Package I contribute**

- [ExpectationMaximization.jl](https://github.com/dmetivie/ExpectationMaximization.jl)
- [QuasiMonteCarlo.jl](https://github.com/SciML/QuasiMonteCarlo.jl)
- In construction [RobustMeans.jl](https://github.com/dmetivie/RobustMeans.jl) + StochasticWeatherGenerator.jl
"""

# ╔═╡ c75d7ce5-4250-447c-a8e6-4ca95edc2aeb
centerslidebreak

# ╔═╡ ea0001c1-cfaa-432f-95a4-b3b4914e4fc5
md"""
!!! note "Goal of today"
	- Overviews of Julia's main features, functionalities, tools, and packages
	- This is **NOT** a step-by-step tutorial; see the Resource section at the end for some links.
	- You can follow: Notebooks are available
	- Presenting what are GANs
	At the end of the day, I hope you get a feeling that this is a great modern tool for complex scientific problems and teaching, and that the language favors collaborative work.

!!! tip "Ask Questions!"
"""

# ╔═╡ dd796fa6-fa31-4559-9855-f6ade6a6c510
md"""
# The Julia story
"""

# ╔═╡ f45d46f4-9c7f-458a-a26a-429b0294e614
WebPage("https://julialang.org/")

# ╔═╡ 5c1790e6-4b0d-41a3-9a73-a56cce53a4f5
md"""
## 2012: the announcement
"""

# ╔═╡ f289dbb7-29c9-4eac-a281-5bdf4612d1a6
blockquote(
  md"""
  We are power **Matlab** users. Some of us are **Lisp** hackers. Some are **Pythonistas**, others **Rubyists**, still others **Perl** hackers. There are those of us who used **Mathematica** before we could grow facial hair. There are those who still can't grow facial hair. We've generated more **R** plots than any sane person should. **C** is our desert island programming language.

  **We love all of these languages**; they are wonderful and powerful. For the work we do — **scientific computing, machine learning, data mining, large-scale linear algebra, distributed and parallel computing** — each one is perfect for some aspects of the work and terrible for others. **Each one is a trade-off**.

  **We are greedy: we want more.**
  """, 
  md"""
  [Why we created Julia](https://julialang.org/blog/2012/02/why-we-created-julia/) -- Jeff Bezanson, Stefan Karpinski, Viral B. Shah, and Alan Edelman
  """
)

# ╔═╡ 6fd06cfa-37c3-4e16-b3f5-15a8688fe51a
md"""
!!! warning "Disclaimer"
	I will present many things: a lot already exists in other languages, sometimes as add-ons or wrapped C/C++ libraries.
	
	Julia language and most of its packages are inspired by many cool existing things.
	
	In this talk I want to emphasize the simplicity of some features and how far they can take us.
"""

# ╔═╡ 7b3b504e-37af-4b62-a029-868f6f1dfdde
md"""
## 2017: the SIAM Review article
"""

# ╔═╡ a7d86d97-4e98-4f87-acce-92241e9b9d51
blockquote(
  md"""
  Julia is designed to be easy and fast and questions notions generally held to be “laws of nature” by practitioners of numerical computing:
  1. High-level dynamic programs have to be slow.
  2. **One must prototype in one language and then rewrite in another language for speed or deployment.**
  3. There are parts of a system appropriate for the programmer, and other parts that are best left untouched as they have been built by the experts.
  """, 
  md"""
  [Julia: A Fresh Approach to Numerical Computing](https://epubs.siam.org/doi/10.1137/141000671) -- Jeff Bezanson, Alan Edelman, Stefan Karpinski, and Viral B. Shah
  """
)

# ╔═╡ 7b21340d-e638-4581-afa9-878fc0d3842f
md"""
## 2018: a stable language
"""

# ╔═╡ fd55ba42-e17e-47f7-a629-1b0a3f2c2c74
md"""
> The single most significant new feature in Julia 1.0, of course, is a commitment to language API stability: code you write for Julia 1.0 will continue to work in Julia 1.1, 1.2, etc. **The language is “fully baked.”** The core language devs and community alike can focus on packages, tools, and new features built upon this solid foundation.

[Announcing the release of Julia 1.0](https://julialang.org/blog/2018/08/one-point-zero/) -- Julia developers
"""

# ╔═╡ a039f988-8993-4538-bee9-d4fc6bb94aaf
md"""
Today v1.9 soon 1.10
"""

# ╔═╡ a3ea30b3-0e2a-407d-b5ba-e577e63f9e8f
md"""
## 2022: user testimonies
"""

# ╔═╡ fd937762-0915-4655-846a-0e6fa735e239
md"""
> With great resentment, I realized that for performance sensitive computing, there can be no such thing as a Python programmer: I could wrap my code in a Python cloak, but I would have to write all the hard stuff in C. A friend who had picked up Julia for theoretical physics taught me that **my frustration was common in scientific computing, and had a name: "The two language problem". Even better, it had a solution: Julia.** (Jakob Nissen)

> I remember working on an R script that needed to loop through 33 million rows of data, doing a complicated lag/join/basket kind of computation that would take 18 hours to run. Literally during one of these 18 hour runs, I saw the Julia announcement post and was immediately desperate for the kind of simple performance it promised. **I read the initial manual over a weekend, rewrote my script the following Monday morning, and it ran in 5 minutes.** (Jacob Quinn)

> What hooked me wasn't the speed (I was using Fortran before, which was more than adequate for that purpose), but **the composability of the whole ecosystem, which lets you easily leverage other people's work.** (Mosè Giordano)

> The Julia community is open, unassuming and inclusive, and works hard everyday to welcome new contributors and **reduce the barrier to entry for students**. It is one of Julia's biggest strengths. (Ranjan Anantharaman)

[Why we use Julia, 10 years later](https://julialang.org/blog/2022/02/10years/) -- The Julia Community
"""

# ╔═╡ 36dcfe6a-d9bc-448f-a359-620261eaa6df
md"""
## 2023: time to first plot is "solved"
"""

# ╔═╡ 325d8c57-41d2-4fa8-843e-78c34dcfc341
Resource("https://imgs.xkcd.com/comics/compiling.png", :width => 500)

# ╔═╡ 064bec79-f5e3-4841-ac6e-68fddcb9df34
Twitter(1610405853412073473)

# ╔═╡ 16691b2c-ae6d-4eb7-9f28-6cf6c66922b7
md"""
# Two languages problem
"""

# ╔═╡ c28338a5-bbb3-45c0-8a39-786264333d5f
Resource("http://ada-developers-academy.github.io/ada-build/learning-at-ada/ada-languages/images/compiled-interpreted.png", :width => 600)

# ╔═╡ dd06f7c7-a85f-4ad4-a5d3-a0c1d5ddf884
md"""
!!! warning "Compilation"
	- Ahead of time (C, C++, Go, Rust, ...): types are statically defined and the code is compiled before execution
	- Just-In-Time (Julia, numba, ...): types inferred dynamically and functions compiled at first execution
	- Runtime (Python, R, ...): types inferred dynamically and functions compiled during runtime
"""

# ╔═╡ 573a1b02-7269-4c3e-91c1-019ec3a5d358
md"""
Julia is **dynamically** typed, feels like a scripting language, and has good support for interactive use.
Julia doesn't require you to annotate types: it infers them from the types of the arguments.
"""

# ╔═╡ 9059970a-e0e6-4228-b371-1e93d57f66d7
centerslidebreak

# ╔═╡ 46dd469b-2acd-4d8a-a112-9b550d27ced8
md"""
!!! note "Just-In-Time"
	Native to Julia. Similar to `numba` @jit with less limitations
	Matlab and Python e.g. `numba` @jit, sometimes through add-ons, attempt to do the same thing, and when it works you get pretty good performance. But it places a lot of requirements on your code and work only in certain circumstances.
	
	Julia was designed "from the ground up" to allow inference to work well most of the time, not just within a single function but from the entry point of a computational pipeline to its terminus.
"""

# ╔═╡ d8518bca-9dde-496d-b9fc-5565019a0ef0
WebPage("https://numba.readthedocs.io/en/stable/user/5minguide.html#will-numba-work-for-my-code")

# ╔═╡ 957ee8fd-63d2-4363-a519-13bd73648e48
md"""
## Loops vs Vectorize 
"""

# ╔═╡ 1fb9b22a-61a4-4c4c-b1c2-71b27b303bc2
md"""
Pseudocode for a `sum` of a vector `x` as learned at school
```bash
s = 0
for i in 1:N
  s = s + x[i] 
end
return s
```
"""

# ╔═╡ 7af69029-d39c-46ab-955c-22b43c0cb1e0
md"""
When you learn Python/R:
$(blockquote(md"the loop is hidden from you in C. **Learning to use vectorized operations is a key skill in R**."))
"""

# ╔═╡ f09162c1-f36c-404a-b342-10e9f9339d17
WebPage("https://monashbioinformaticsplatform.github.io/2015-09-28-rbioinformatics-intro-r/03-supp-loops-in-depth.html")

# ╔═╡ eaf2cc1a-f844-4b00-897f-245207963a89
centerslidebreak

# ╔═╡ 86d5f4a4-12bc-40db-9afd-b26a3de633f9
blockquote(md"Experienced Matlab users like to say **“Life is too short to spend writing for loops.”**", md"""“1998 Getting Started with Matlab manual” (and other editions)""")

# ╔═╡ 877544e1-cf7c-4f6e-a746-67e5f418611d
md"""
!!! note "Vectorized `sum` are just loop in C/C++/Fortan"
	- “for loops” are **NOT** inherently slow by themselves!! 
	- In dynamic languages, the system does not know the types of variables beforehand. 
	⇒ At each iteration, it must infer types. Repeating this operation again and again is what takes time
"""

# ╔═╡ 1572d39d-dc9e-4b5a-95c6-53beeb32af17
md"""
!!! danger
	Sometimes you cannot vectorize (or spend hours trying to)!

	Typically, when you have a complex dependence over past elements e.g. Markov chain. 
	
	[^example] Matlab example for averaging pixels; see [here](https://github.com/timholy/AdvancedScientificComputing/blob/main/lectures/intro/intro-julia.ipynb) for context and [here](https://www.mathworks.com/matlabcentral/answers/307297-neighbors-of-a-pixel) for original post.
"""

# ╔═╡ b89236fb-7775-4e16-93dc-bc9a025b3023
md"""
!!! warning "Conclusion: Interpreted languages are not ideal for large complex taks"
"""

# ╔═╡ 36863f50-68b0-42bc-a038-e5d02c58e8c1
md"""
## Developing burden
"""

# ╔═╡ ea3bf775-808e-42e1-85c6-7d432a44db41
md"""
#### In a lab I visited

> "We just finished wrapping/translating our huge package into C++, so now it is super fast!"
It took X years and N postdocs to write **glue code**
"""

# ╔═╡ eeca76c4-491b-4197-8580-e4010df945f3
md"""
#### One encounter I had
- I am skeptical about "as fast as C"
- With someone building a unified package for Markov chains in C++ 
>  - Him: "come use it, we can add features"
>  - Me: "should one know C++ to contribute?"
>  - Him: "no no, I’ll translate, your R code" 
⇒ Problematic to maintain + few people know C++ 
- Already 3 or 4 packages with similar names. The author had two packages with one letter difference, one was depreacated because of old version of a dependency.
**Why not contribute to existing package, rather than multiplying the number of similar packages?**
"""

# ╔═╡ affc0d38-2833-403b-8610-eb03d10f469d
md"""
!!! warning "All that is related to the Two language problem"
"""

# ╔═╡ c0614c97-bd5e-440b-9381-0427f3758c8c
centerslidebreak

# ╔═╡ 499c26ba-8df5-4087-80de-a3efb5293f16
question_box(md"""
Who never ran into **compatibility**, installation issue with Python/R?

Compatibility issues! The more dependence (especially with different language, compilers) the more issue on reproducibility, compatibility, installation, read code source
""")

# ╔═╡ f767e601-08da-436a-a4ea-fc92e18c1bec
WebPage("https://gael-varoquaux.info/programming/view_on_scientific_computing.html")

# ╔═╡ 193a7b1e-5683-4cef-902e-ef351dd3e89d
md"""
Gaël Varoquaux (May 2010) 

Directeur of Scikit-learn
"""

# ╔═╡ 499b4667-111d-4408-8cb8-4de0d6182673
md"""
!!! danger
	I think that **speed** is missing from his requirements
"""

# ╔═╡ 38d6ab9e-3aa0-4890-b8a6-ae1bc3dd4d00
md"""
# Get started
"""

# ╔═╡ 28f20cfe-7439-4090-aa23-ec2257a9fc9c
md"""
## Install
"""

# ╔═╡ fc58d729-8594-4607-bf7f-0f730a3be9ac
md"""
Windows
"""

# ╔═╡ faa36c56-bd6b-45b7-89b6-1555a2515bfd
WebPage("https://apps.microsoft.com/detail/julia/9NJNWW8PVKMN?hl=fr-fr&gl=FR&rtc=1")

# ╔═╡ af6007fc-39ac-401d-a03d-16fe39917951
md"""
Linux/Mac: simply do
"""

# ╔═╡ 24b9edbe-88e6-4ede-bb59-5c32d8f1514c
md"""
```bash
curl -fsSL https://install.julialang.org | sh
```
"""

# ╔═╡ f67f535b-3d05-4bd6-a7bd-21556f4c41dc
md"""
## Editors
"""

# ╔═╡ 1ead6b3e-3e1c-49b0-a834-fd587b00c5a5
md"""
### REPL (Terminal)
"""

# ╔═╡ 1a1b54fd-61e3-4fd3-a3d7-77f015c9d0be
md"""
!!! tip "Good for"
	- Package `]`, environment management
	- Shell mode
	- Quick look/computations
	- R console

!!! danger "Bad for"
	- More than a few lines of code
"""

# ╔═╡ 9bcb3ff4-28ff-4525-94b8-38f6c6f07d9d
centerslidebreak

# ╔═╡ f8884266-8ede-4dde-aa18-adc89f621157
md"""
### VS Code (IDE)
"""

# ╔═╡ 2b4d5107-68d5-40d5-93b5-67188c8e4e55
md"""
!!! tip "Good for"
	- Has a REPL or script option
	- Development (with package, git, etc)
	- Profiling/Debugging 
	- Plots
	- IDE features (IntelliSense, Highlighting, etc)
	- etc...

!!! danger "Bad for"
	- Pluto
"""

# ╔═╡ 67e46709-8850-463e-a0be-b0dafdce2751
centerslidebreak

# ╔═╡ b9d8f2f3-f2b2-4f35-b792-df71e240d92a
md"""
### Jupyter (notebook)
"""

# ╔═╡ e715e9bb-a9cb-49d8-ac75-16e67a4667db
md"""
!!! tip "Good for"
	- Showing work
	- Report like document

!!! danger "Bad for"
	- Development
	- Sharing/Reproducibility e.g. `.ipynb` format!
"""

# ╔═╡ 62c5b08c-b574-4043-8bab-5493f2462dd7
md"""
!!! note "Did you notice"
	**Ju**(lia) **Py**(thon) **R**
"""

# ╔═╡ 8b9ce2bc-f8a9-4cbf-8fd8-e0bf31dbbee9
centerslidebreak

# ╔═╡ b527f54c-53ae-4aa6-a5f2-c61fa6633bd3
md"""
### Pluto (notebook)
"""

# ╔═╡ 6232d13a-c1f9-4df2-8549-e43f6fc4ed9f
md"""
!!! tip "Good for"
	- Interactivity
	- Sharing/Reproducibility e.g. `.jl` format!
	- Teaching
	- Presentation/Report like document
  
!!! danger "Bad for"
	- Heavy notebooks
	- No IDE like features
	- Development
"""

# ╔═╡ 1895474c-022b-4efa-ab68-6e33564b22ed
centerslidebreak

# ╔═╡ 489823e8-1e5f-4493-a0c3-2dbbec842142
md"""
#### Reactive notebooks
"""

# ╔═╡ ce1b65a1-847c-4808-bd18-0207562bc6de
click_to_present

# ╔═╡ f742b185-773e-4aba-a894-9e1b91cafa2f
md"""
Play with sliders and more.

Advanced example: my notebook STICS
"""

# ╔═╡ 8e14f37c-4095-4553-a08c-f100190d40bc
@bind Ω Slider(1:0.1:10; show_value=true)

# ╔═╡ a4500168-ea47-4f03-8c2e-e08901d82d2d
@bind date_start DatePicker(default = today())

# ╔═╡ 07a6cf77-e119-4050-a109-3fa1377f3fdb
Ω^2

# ╔═╡ a66290bb-101f-4196-8cc8-1c05e949553b
centerslidebreak

# ╔═╡ ed04f3b6-dcba-4d2c-b539-bf4d77ff33b3
md"""
#### Teaching

Evaluate student code automatically on the following task.

Define a function `mydouble` that takes two inputs and computes their doubled sum.
"""

# ╔═╡ ad197457-601d-494f-b058-70235391cdc8
md"""
## The basics
"""

# ╔═╡ 27ea92e4-041c-479c-aad4-5369370572a6
md"""
!!! warning
	**The first time you do something** in Julia (install/load a package, use a function, `1+1`, do a plot, ...) **it will take time** (= compilation).
	
	This is called the "Time to first X" problem. However, since the last version this has been dramatically reduced.
"""

# ╔═╡ afcdf710-cfed-4d7d-817d-cdf9932ebe8d
centerslidebreak

# ╔═╡ 2ce2824f-52b7-444e-950f-5370b4ba59e0
md"""
### Syntax
"""

# ╔═╡ 22b1bb59-f0de-4888-9b9c-fbaf0fab773c
md"""
One-line function definitions and $\LaTeX$ symbols
"""

# ╔═╡ 53d07c05-a15a-450a-83c4-4da91dd5b6a5
😸 = 1

# ╔═╡ 3447169b-b41f-4b63-9251-ef6d14846b82
md"""
Not just good looking: improve readability!
"""

# ╔═╡ e832133e-6b8a-4557-be97-6d54f2e1b6b3
2 ∈ 4:7    # returns `false`

# ╔═╡ 4ef6d842-457d-447b-b7c1-27ae00b10c4b
[1,5] ⊆ 1:5  # returns `true`

# ╔═╡ 638a91bb-0157-4954-919e-c7368b531629
2^2

# ╔═╡ 459e2de0-afc8-4032-ad3c-72c53a55d270
x-> x^2

# ╔═╡ bb3048cc-6eab-48e7-85e1-d632f81369dc


# ╔═╡ 94835866-0c2a-49db-b537-aa31261348b6
centerslidebreak

# ╔═╡ 89e86e3a-674c-4c49-b59d-ddf09060e106
md"""
### Built-in arrays
"""

# ╔═╡ b0e2f33c-bc5d-49ec-bcc5-47e4054eb7e8
[1 1; 1 0]^10

# ╔═╡ eab33b6a-482a-40c1-8120-f87fa31ba109
tip(md"""
#### Getting Help 

Use Live Docs (from Pluto) to understand `diagm`. 

In REPL, use `?` + `diagm`

In VSCode, use `IntelliSense`
""")

# ╔═╡ 6b4021c2-c4b3-4f82-9869-0aab827e6056
exp(diagm(-1 => 1:6))

# ╔═╡ 138bc84e-5261-4120-ad95-871db9144692
centerslidebreak

# ╔═╡ 70c3206a-ef54-4fc7-a85c-d6725f577199
md"""
### Vectorization/Broadcast
- Vectorization of operators and functions just with dot.
  * It is a language feature
  * It works with every functions
- Vectorization is not **naturally** faster than loops but might be more convenient sometimes.
"""

# ╔═╡ a16a6f2d-1a2a-48ff-a303-e6f0c80a3289
question_box(md"What will the following code return? Uncomment the cell to see")

# ╔═╡ f140a80d-1ec3-4a0c-b35b-1d117c3e7adc
exp.([1, 2, 3])

# ╔═╡ 7f8e1d7e-b7a0-42f2-80ce-f0e98cdea9d2
[1, 2, 3] .=> ["a", "b", "c"]

# ╔═╡ a9dc3572-5b3e-4a2e-8aed-1d7c82ee2acf
centerslidebreak

# ╔═╡ e9b2fbfc-07ff-4276-916a-0d3d00676f55
md"""
Integer overflow... or not
"""

# ╔═╡ e7fef034-89aa-48b7-a046-7ad65967892d
3^100

# ╔═╡ 3c3bd174-ac9a-4fb6-8230-2540d6330aee
big(3)^100

# ╔═╡ 7ac4238c-e7fe-4039-a89f-4f43fdb98063
md"""
### Linear algebra
"""

# ╔═╡ 21458cb4-1b58-441d-9aec-cd14c59d9332
eigen(rand(3, 3))

# ╔═╡ bff77839-efac-488a-be60-da970266c860
centerslidebreak

# ╔═╡ edef726b-0eb6-46b9-935e-c151977d15a0
md"""
### Distributions
"""

# ╔═╡ b61894d9-bdbd-4f9b-b4ec-a6dd555a5aec
dist = Uniform()

# ╔═╡ 3819d633-4531-4053-b063-501c7060d7a5
rand(dist, 10)

# ╔═╡ f8a8d46a-a4d9-42a0-a5f9-8ee04ccc15a9
question_box(md"Why does it return an error?")

# ╔═╡ 4449508f-df28-4d2d-aa14-46dd0902de46
rand(dist, 1)

# ╔═╡ e500f340-b53c-46b2-a3fd-46d563c86df9
md"""
# Types
"""

# ╔═╡ 9425a024-fe6d-4cc8-b2ab-25e6a20bf4ed
md"""
[^Ref]: See documentation on [Types](https://docs.julialang.org/en/v1/manual/types/)
"""

# ╔═╡ fbb026ed-d295-44dc-93c5-1455f3ffd848
PlantUML("@startmindmap
+ Number
++ Complex{<:Real}
++ Real
+++ Irrational
+++ Rational{<:Integer}
+++ Integer
++++ Bool
++++ Signed
+++++ BigInt
+++++ Int8, Int16, Int32, Int64, Int128
++++ Unsigned
+++++ UInt8, UInt16, UInt32, UInt64, UInt128
+++ AbstractFloat
++++ BigFloat
++++ Float16, Float32, Float64
@endmindmap")

# ╔═╡ e8bddc9f-3b27-4dd5-815b-47bcba7c0845
md"""
```julia
abstract type Number end
abstract type Real          <: Number end
abstract type AbstractFloat <: Real end
abstract type Integer       <: Real end
abstract type Signed        <: Integer end
abstract type Unsigned      <: Integer end
```
"""

# ╔═╡ 7708599d-7236-483b-8745-975476f72d9e
md"""
**Structures**
"""

# ╔═╡ c6ca8823-f8c3-49c8-acb9-f2ef56f176e2
struct MyRational{T<:Integer} <: Real
	numerator::T
	denominator::T
end

# ╔═╡ c3b6d389-52ac-421d-ab2a-d1cbc13c970c
md"""
Types are not mandatory but can be specified in some situations! 
"""

# ╔═╡ 6782cd70-71dd-4504-a6b6-e4b0da3d9126
Float16<:AbstractFloat

# ╔═╡ 772d1148-5181-425e-b2ca-365aa2b5c2a4
md"""
## Clever compiler
"""

# ╔═╡ e6429073-ffe9-4153-b90f-e55b27e2817d
md"""
All the previous abstractions do not compromise efficiency, for two reasons. 
"""

# ╔═╡ 42dd87b3-b9a2-4f57-bcac-3a191ab76380
md"""
!!! note "Clever compiler (1/2)"
	The compiler infers variable types very well.
"""

# ╔═╡ 4cd408a5-f78a-4393-9ffe-61598f17f326
fill(2, 5)

# ╔═╡ 259910c4-5af2-44c7-a77e-3fd0de1d86e0
centerslidebreak

# ╔═╡ c9fe918e-6910-41f8-9042-a35e7fe1fd00
md"""
!!! note "Clever compiler (2/2)"
	The compiler generates low-level code that is adapted to the variable types it has inferred.
"""

# ╔═╡ 9c024d61-b080-4d33-8bdf-d887daad54a6
md"""
Basic operations like the sum have hundreds of implementations, each designed for specific combinations of input types.
"""

# ╔═╡ 5a13d6f6-cb6b-4e2b-b190-0f9bdfaf3098
md"""
# Multiple Dispatch
"""

# ╔═╡ 89c1d82b-c661-42c4-b254-974d673cf9b7
YouTube("kc9HwsxE1OY", 1, 26)

# ╔═╡ ee3c9d50-72e2-4f11-b486-1275d20d5c72
md"""
**JuliaCon 2019 | The Unreasonable Effectiveness of Multiple Dispatch | Stefan Karpinski**
"""

# ╔═╡ eb5f8c91-b636-46ff-bd28-023116954829
md"""
## Dispatch
"""

# ╔═╡ 67abb3db-2e1e-4edf-99c2-f17f44a47b9f
md"""
!!! warning "Single dispatch (S3 in R)" 
	In R, a *generic function*, like `print`, R looks at the class of the first argument to determine which `print` method to use. 
	For data frame, `print.data.frame`, a linear model, then `print.lm`
	
	S3 is a single dispatch system: only the classes of the first argument to the function are used
"""

# ╔═╡ c5839b75-d47f-4545-8b21-5d15b0f39e6f
md"""
!!! tip "Multiple dispatch (Polymorphism) in Julia"
	- Dispatch on **all** arguments of a function
	- Dispatch depends on the **Type** of the argument not the class 
	⇒ 1. **Generic algorithms** abstractly express high-level algorithms decoupled from implementation details
	
	⇒ 2. **Common Type** shared by many different packages
"""

# ╔═╡ c531ed94-708a-4ea3-a227-bc6ed79761c8
md"""
## Type/Class sharing
"""

# ╔═╡ d5059a11-fbb1-4d01-9931-6de4e297768c
md"""
!!! warning "Class Based Object Oriented `x.f(y)`"
	Methods are defined inside `class` definition. To add method
	1. **Edit the original class** and add a new method
	2. **Inherit from the original class** and add new method

"Solutions":
1. Convince the authors of the interesting class to add your method (they'll have to maintain the code & cannot undo)
2. Find a new name `MyClass` & your operations won't apply to others subclass
3. Give up on dispatch: use external function `f(x,y)` instead of `x.f(y)`
4. Give up code sharing
"""

# ╔═╡ 5b605cde-da9f-447c-b1e5-15a78e669701
md"""
!!! tip "In Julia functional programming `f(x,y)`"
	You can define methods on types after the type is defined! That's it!
	
	++ Generic functions are properly named i.e. `MyPackage.foo` and `YourPackage.foo` are separate functions
  
"""

# ╔═╡ 8b18afe0-c62a-4cc3-8b41-1ba527309484
md"""
Example de "multiple dispach" (notebook Jupyter): [`notebook_2_multiple_dispach_on_animals.ipynb`](https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/master/notebooks/notebook_2_multiple_dispach_on_animals.ipynb)
"""

# ╔═╡ a3771e8a-1b07-4d31-b4ad-19e3ede8ffaa
md"""
## Expressiveness
"""

# ╔═╡ 6097217e-c193-4877-af31-6430636988bf
Resource("https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/master/figs/expressiveness_with_dask.png?raw=true")

# ╔═╡ 7e3a8d7f-2c99-4d56-b78e-ba68cf400fbe
md"""
[^from]: Tim Holy [this video](https://youtu.be/jFhL8EVrz7s?t=286), that [notebook](https://github.com/timholy/AdvancedScientificComputing/blob/main/lectures/intro/intro-julia.ipynb) and [this paper](https://arxiv.org/abs/2109.09973)
"""

# ╔═╡ 65c2d1ed-6fd1-47f1-b51b-269c7941ae2f
md"""
## Generic & Efficient code
"""

# ╔═╡ f8a0b5ec-1623-4f25-b6dc-c859dab34037
md"""
Julia is near Pareto-optimal in terms of lines of code vs efficiency.

- [Computer Language Benchmarks Game](https://benchmarksgame-team.pages.debian.net/benchmarksgame/fastest/julia-python3.html)
- [Energy efficiency of programming languages](https://sites.google.com/view/energy-efficiency-languages/updated-functional-results-2020)
"""

# ╔═╡ 683dd9c7-a40e-4702-8d6b-943d515117f1
md"""
Example: performance + generic code (notebook Pluto): [`notebook_3_speed_sum_example.jl`](https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/master/notebooks/notebook_3_speed_sum_example.jl)
"""

# ╔═╡ 782b4b45-8f00-4805-b70f-6a527d5dba60
md"""
!!! note "Personal experience: The Expectation Maximization algorithm"
	[ExpectationMaximization.jl](https://github.com/dmetivie/ExpectationMaximization.jl/tree/master) versatile + very fast
"""

# ╔═╡ f6bf0d32-8524-4a7c-8458-63ca4ff14f81
Resource("https://user-images.githubusercontent.com/46794064/227195619-c75b9276-932b-4029-8b49-6cce919acc87.svg", :width => 800)

# ╔═╡ 1010b109-e5e3-4f33-b0f7-b5c5ece41a92
md"""
## Multiple dispach showcase
"""

# ╔═╡ 1c2ca520-a2f3-48f4-a983-681c762c1ea9
mynorm(v) = sum(abs2, v)

# ╔═╡ 153164ac-1196-48b1-a484-5be9f79e6088
md"""
What we did with dual numbers extends to lots of other situations thanks to dedicated packages.
"""

# ╔═╡ 4cbb9bcb-db63-4771-bd00-4cc109a8c46c
v = [1, 2, 3]

# ╔═╡ 90257139-4107-4b33-95f9-ef11524b67a2
mynorm(v)

# ╔═╡ fb7498d1-1003-48ee-a557-a3911038058e
md"""
Logarithmic numbers to prevent numerical underflow (LogarithmicNumbers.jl):
"""

# ╔═╡ b58c5deb-2cef-4658-8bd5-cacda65e620b
v_log = LogFloat64.(v)

# ╔═╡ f0fb6911-536c-40f7-a87f-822a90b6efe9
mynorm(v_log)

# ╔═╡ 96a1ec6c-e21d-40e2-991b-3838c6085ea4
md"""
Numbers with physical units:
"""

# ╔═╡ 629fab7f-c134-4127-a2c4-7f84d485f655
centerslidebreak

# ╔═╡ 5d58433f-e8b0-46ed-ad11-71ed41de19e5
md"""
Numbers with [uncertainties](https://en.wikipedia.org/wiki/Propagation_of_uncertainty) ([Measurements.jl](https://github.com/JuliaPhysics/Measurements.jl))
"""

# ╔═╡ 31b0876b-5295-4d83-b5cf-6109ec2b603e
v_meas = [1 ± 0.1, 2 ± 0.2, 3 ± 0.3]

# ╔═╡ 50bb9586-4c61-48ff-bc38-2bfa7e40d0c1
sum(abs2, v)

# ╔═╡ 9541bf3c-8809-44ba-bcde-0794c164d7d5
mynorm(v_meas)

# ╔═╡ d1bfc038-6c04-4bb6-99f6-d098e160b3e5
md"""
Intervals (IntervalArithmetic.jl)
"""

# ╔═╡ b585c9d5-6bf3-4635-a873-9d9ef94f9d08
v_interv = [interval(0.9, 1.1), interval(1.8, 2.2), interval(2.7, 3.3)]

# ╔═╡ 2f15f153-4113-4c20-8a6e-4117751d616c
mynorm(v_interv)

# ╔═╡ d68e7a74-de79-45cf-adf5-f1dd6a003976
md"""
Computer algebra (Symbolics.jl)
"""

# ╔═╡ beda159f-b853-43c7-a087-4d182965ce40
Symbolics.@variables p, q, r

# ╔═╡ b5f1432a-6c49-4325-90a3-a1acb91f9862
    md"""
    # Composability
    """
    
  

# ╔═╡ 787b287f-1738-40e0-852d-a48bf4e5e14e
Twitter(1589676578560102400)

# ╔═╡ 0c55f8fe-29b6-493c-8a73-8ab5efc09409
md"""
!!! tip "In Julia"
	One language + type sharing + multiple dispatch

	⇒ Amazing, unexpected combination and code reuse
"""

# ╔═╡ 4684f800-6da4-4f02-9aca-e2816b5afdb4
md"""
!!! warning "What is NOT code reuse?"
	Recode basic stuff because incompatible frameworks `tensorflow.random.uniform`, `numpy.random.rand`, `torch.rand`, `jax.random.uniform`
"""

# ╔═╡ e4a55ceb-b632-421d-a525-524350cf7b24
centerslidebreak

# ╔═╡ 063869ae-0d30-4626-9491-bcc6faa3c760
YouTube("rEwBxCBl92k")

# ╔═╡ 499176b7-20ab-4ca1-a3e5-c33b34c59c35
md"""
**Example**: ODE problem + ...
"""

# ╔═╡ 98688cd7-a0da-4ed7-a6d4-83c62a4904ee
md"""
!!! warning "Problem" 
	I have an optimization problem over an ODE problem e.g. find the best parameter $p$ for my ODE that fits my data.
	
	```math
	\min_{p} \sum_{i=1}^n (x(t_i) - y_i)^2 \quad s.t.\quad
	\begin{cases}
	\dot{x} = f(x, p) \\
	\text{given observations $\{X(t=t_1) = y_1, \cdots, X(t=t_n) = y_n\}$} 
	\end{cases}
	```
"""

# ╔═╡ 75a7cf61-10c7-4788-8e18-af5a28112c0d
question_box(md"""
1. Should I use an ODE package + Hand written optmisation $\Rightarrow$ finite difference (quite bad)
2. A fancy optimization package with support for ODE ⇒ **Expert in Optimization & ODE** (maybe??)
3. One ODE package compatible with an Optimization package
""")

# ╔═╡ b49ef5bd-543c-4841-bb6b-40a588173efe
md"""
Compatible simply means Optimization package will know how to manipulate (differentiate) ODEs

!!! danger 
	What if instead of classic optimization, I want to estimate my parameters with Bayesian approach?
	
	⇒ Now I need a package expert in ODE+Bayesian stats+Optim (+possibly C/C++)
"""

# ╔═╡ 93b29b75-24f8-494a-a1f8-48b7d5a44b79
md"""
Exemple: Optimisation + ODEs + Bayesian (notebook Pluto) [`notebook_4_Optim_DiffEq.jl`](https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/master/notebooks/notebook_4_Optim_DiffEq.jl)
"""

# ╔═╡ 1edf689e-2119-4007-be02-eb7aae43db3b
md"""
# Community
"""

# ╔═╡ 6426c5be-4336-4705-b37d-426d748f420d
md"""
## Lively and connected community
"""

# ╔═╡ cc87181a-5b6f-4d02-bb11-0698530478b9
md"""
Julia features favor a lively community
!!! note
	1. Composability $\Rightarrow$ Code reuse, connected community
	2. One unique language favors contributions (no need to both know C/C++ and Python/R)
	3. (2bis) One unique language helps to read other codes. Example [`Exponential` distribution](https://github.com/JuliaStats/Distributions.jl/blob/master/src/univariate/continuous/exponential.jl) from `Distributions.jl`
"""

# ╔═╡ 8974d32f-4a0c-4ccb-b6c6-ff59b672c9a4
md"""
## Easy to contribute
"""

# ╔═╡ b62b5753-fb75-493e-ae37-75331384a747
md"""
- You can actually help improve the ecosystem and the language itself
- Open source dev will teach you good programming practices
- The community is very helpful

!!! note "Fun Fact"
	I registered the 9999th package `PeriodicHiddenMarkovModels.jl`. A few minutes later was the 10000th one
"""

# ╔═╡ 1665a02f-6053-4a60-8cff-70bd0fe5dc93
md"""
## Events
"""

# ╔═╡ 4be1270c-be70-4bdd-a015-ad92ff765124
md"""
### Every year: JuliaCon

- A great conference with plenty of topics
- Introductory tutorials
- Remote option
"""

# ╔═╡ 982de518-2ab6-4299-8624-c1074a880082
md"""
### Europeen JuliaCon
- JuliaCon Local Eindhoven 2023
"""

# ╔═╡ a47cced1-e43f-4c17-85b1-20c65df7ff32
md"""
### France
"""

# ╔═╡ a0312030-1ade-42d3-9a5c-332ac0cffc7a
md"""
By Benoit Fabreges, Pierre Navaro
- Julia and Optimization Days (since 2022)
- [CNRS mailing list](https://listes.services.cnrs.fr/wws/subscribe/julia) newsletter
- Website
- Monthly talk [Café Julia](https://calcul.math.cnrs.fr/cafe-julia-5.html)
"""

# ╔═╡ 31ce0ecf-69ea-41c6-970f-7117d8399ad2
md"""
# What Julia is good at
"""

# ╔═╡ d7987ebe-ad03-4b64-b975-572c5f5cbcdb
md"""
## Plotting
"""

# ╔═╡ 229c8602-65b8-4ddc-8994-1d0e9dc576bd
md"""
It will take a few second to run if you activate the cell (on the rigth). The result is a pretty GIF.
"""

# ╔═╡ 0e0fac4b-02de-4ec1-b54f-b78a68aaa18e
# ╠═╡ disabled = true
#=╠═╡
let
	xc, yc = -0.55, 0.61
	x0, x1 = xc - 2, xc + 2
	y0, y1 = yc - 2, yc + 2
	anim = @animate for t in 1:50
	    x, y = range(x0, x1; length=500), range(y0, y1; length=500)
	    heatmap(
			x, y, -log.(mandelbrot.(x' .+ y .* im));
			aspect_ratio=1,border=:none,legend=:none
		)
	    x0, x1 = (15x0 + x1)/16, (15x1 + x0)/16
		y0, y1 = (15y0 + y1)/16, (15y1 + y0)/16 
	end
	gif(anim,"mandelbrot_zooms.gif", fps=10)
end
  ╠═╡ =#

# ╔═╡ 01c815ae-f018-425a-995d-fda5892d7ed2
md"""
## Numerical analysis
"""

# ╔═╡ 22d20ff6-8cd1-4699-9e5d-303f820c7db1
md"""
Reference ecosystem: [SciML](https://sciml.ai/)
"""

# ╔═╡ 18214f16-a66c-421b-8254-23180de50ee9
md"""
Basic problem: simulating
```math
\frac{\mathrm{d}u}{\mathrm{d}t} = f(u, p, t)
```
"""

# ╔═╡ 68bdad76-5be7-4824-8c8b-7412fd5ef7a3
md"""
## Optimization (linear or nonlinear)
"""

# ╔═╡ a002b72e-b1ec-4c82-8765-2c1470176d47
md"""
Reference ecosystem: [JuMP](https://jump.dev/)
"""

# ╔═╡ d213be62-11c7-4574-bd94-2714af1712ac
md"""
Basic problem: solving
```math
\min \quad c^\top x \qquad \text{s.t.} \qquad \begin{cases}
Ax \leq b \\ |x| \leq M \\ x \text{ integer}
\end{cases}
```
"""

# ╔═╡ 302d0702-02c7-4d1d-b0db-9910fa0c871a
md"""
See notebook
"""

# ╔═╡ ee0f10e1-1e35-47b4-b2bb-2b44d37e626c
md"""
Bonus point: the whole language is automatically differentiable. Well, almost. See [JuliaDiff.org](https://juliadiff.org/) for more.
"""

# ╔═╡ 48ca2c1f-cc8e-4268-9f25-2efc655ddfac
md"""
## Automatic Differentiation
"""

# ╔═╡ bf54a867-1338-4305-85b7-f39b7db066e9
md"""
Let's say I have a homemade algorithm for computing the square root.
"""

# ╔═╡ d604a886-8c56-49b6-8ea4-601ed10e48ed
md"""
What if I want to compute its derivative?
  - If I'm a mathematician: apply the definition with a pen and paper.
  
```math
  f(x + \delta) = f(x) + \delta \times f'(x) + o(x)
```
  - If I'm a Julia coder: reimplement this definition with a custom type storing $x + \delta$.
"""

# ╔═╡ 7afd6c30-b290-45ad-8ddf-7c28a4b34872
struct Dual{T}
	x::T
	δ::T
end

# ╔═╡ 73ebd870-8e95-4dee-8e63-3cfcb9018e08
Base.:*(m, a::Dual) = Dual(m * a.x, m * a.δ)

# ╔═╡ 46088004-6d59-4059-8536-b571810d8646
t = collect(0:0.01:2π)

# ╔═╡ e283e03a-b0f6-485a-94c7-93db9a5ddd40
date = range(;start = date_start, step = Day(1), length = length(t));

# ╔═╡ 1055b847-6fa9-4f0d-924a-45d8b9d45ad0
plot(date, sin.(Ω * t); label=nothing)

# ╔═╡ 228acf65-2f5b-4e45-9a7e-2bdef932105f
cartesian(r, θ, ϕ = 0) = r*sin(θ)*cos(ϕ), r*sin(θ)*sin(ϕ), r*cos(θ) 

# ╔═╡ 577205fb-1ab3-4305-9add-042315b079c9
∇f(x) = [2x[1], 2x[2]]

# ╔═╡ 5726299f-3857-4467-bea2-dceefb9ba7b7
∇²f(x) = 2*I

# ╔═╡ aa3e7729-3b2e-4824-92af-09d15894b521
function myfillmat(x, n)
	v2 = fill(x, n)
	v = sqrt.(v2)
	M = v * v'
	return M
end

# ╔═╡ 988269f3-1e76-4cc3-88a9-392620efc000
@code_warntype myfillmat(2, 20)

# ╔═╡ f3b1e50a-8e2d-42de-9f1a-b3ae27bb8769
v_unit = [1u"m", 2u"m", 3u"m"]

# ╔═╡ e28bda7b-2dde-4387-b9c6-ca11ef104999
mynorm(v_unit)

# ╔═╡ 72ba1d12-43be-4910-b16f-9296a556be95
v_symb = [1p, 2q, 3r]  

# ╔═╡ e6610f5a-e3c1-4954-b7f1-86ecedc045db
mynorm(v_symb)

# ╔═╡ b3571522-6d85-4ea9-8a7c-b3fac6b600c3
Base.:+(a::Dual, b::Dual) = Dual(a.x + b.x, a.δ + b.δ)  

# ╔═╡ 957ee6e2-25db-41c9-a5a9-8b8efb39e6ff
mydouble(x,y) = 2 * (x + y)

# ╔═╡ add00c30-7aa9-47f9-ac3b-4a1e97e23d09
let
	if @isdefined mydouble
		x, y = 3, 2
		try
			z = mydouble(x, y)
			if z isa promote_type(typeof(x), typeof(y))
				if z ≈ 2(x + y)
					correct()
				else
					almost(md"`mydouble` returns the wrong numerical value")
				end
			else
				almost(md"`mydouble` returns the wrong type")
			end
		catch e
			keep_working(md"`mydouble` throws an error")
		end
	else
		keep_working(md"`mydouble` is not defined")
	end
end

# ╔═╡ 6fabb945-3626-452b-a471-4abcadbb9592
function λ(x,y)
	1+1
end

# ╔═╡ 8c1fc621-500f-484d-91d8-75e8d564ce9e
f(x) = x[1]^2 + x[2]^2

# ╔═╡ e498d0c5-104e-4db6-91fc-9562faa7dfb4
[1, 2, 3] .+ 1

# ╔═╡ bfa46a2d-36ad-41c3-befb-053fa5c99b23
rand(dist, 1) .+ 1

# ╔═╡ ac7408c8-c366-46ab-9515-93bc55dda4ac
(1+2)::AbstractFloat

# ╔═╡ ee8b8ad6-70d9-49d5-b2c0-1be93da8255c
(1+2)::Int

# ╔═╡ 16af7868-f4fe-4720-98f7-095f96b0ac7a
@which 1 + 1

# ╔═╡ b676581c-a8ec-44ae-a4d3-31efd57ef445
@which true + true

# ╔═╡ 29b05d28-662a-4413-ba9c-bd45e9e50135
@which 1//1 + 1//1

# ╔═╡ f0d0773c-e933-487d-939d-5bba8e886fb5
1//3 + 1//2

# ╔═╡ cf12ffe3-42b0-43f7-bf2a-bc13ea12ce05
@which 1.0 + 1.0

# ╔═╡ 8a1c1942-ec43-452f-9b35-0a99587b26d8
@which [1 0] + [0 1]

# ╔═╡ 18a34595-d7ee-4131-939f-a48f197e87f1
length(methods(+))

# ╔═╡ e4907d4e-9d1f-48a0-a11b-0ac6479b7b62
    2sqrt((v[1]*0.1)^2 + (v[2]*0.2)^2 + (v[3]*0.3)^2)
    
  

# ╔═╡ 3a377bf4-518f-46ea-bb18-d433f0a09d04
function mandelbrot(z; N=100)
	w = z
    for n in 1:N
        if abs2(w) < 4
			w = w^2 + z
		else
			return n
		end
    end
	return N + 1
end

# ╔═╡ 88b5be8c-8b2c-4b04-9f91-c7fe5929ddc2
Base.:/(a::Dual, b::Dual) = Dual(a.x / b.x, (b.x * a.δ - a.x * b.δ) / b.x^2)

# ╔═╡ 9506fe42-d4a2-4055-8429-021ff5bebb8b
φ₁(x) = exp(-x^2) / √(2π)

# ╔═╡ 37e6add7-46c6-4ece-9b14-f2bafb66a8a1
φ₁.([1, 2, 3])

# ╔═╡ f3b572ef-b338-4b12-b1b8-08364fabf487
@time 1+1

# ╔═╡ 2ea84a40-f68a-465e-bf76-e8edb2573429
function mysqrt(a)
	x = a
	for k in 1:100
		x = 0.5 * (x + a / x)
	end
	return x
end 

# ╔═╡ d666646f-a1b9-4ca6-8ef4-15557312cc8c
mysqrt(2)

# ╔═╡ 962eb933-3d01-41ae-898d-2e97553ffa6b
mysqrt(Dual(2, 1))

# ╔═╡ 8e362a49-fdfe-499d-abf1-40005f25aec8
1 / 2√2 

# ╔═╡ 13328cb8-56c3-47bf-a375-0a5758492ebd
md"""
## Dataframes
"""

# ╔═╡ 82c6dfe8-080a-4b8d-ae80-a6bfaafd3281
md"""
- Reference ecosystem: [JuliaData](https://github.com/JuliaData).
- Super fast
"""

# ╔═╡ d20b5ccc-280a-47fe-bf2d-5ece3bf370d7
DataFrame(
  "customer age" => [15, 20, 25],
  "first name" => ["Rohit", "Rahul", "Akshat"]
)

# ╔═╡ cb166e16-d822-4537-a1a2-d242658912ae
md"""
The package DataFrames.jl blows Pandas and others out of the water: see [H2O benchmark](https://h2oai.github.io/db-benchmark/)
"""

# ╔═╡ 46dd0c2c-9460-4d9f-9f8b-df5dabd4daf1
md"""
**Manipulating DataFrames**

-> DataFrameMeta.jl, Tidier.jl
"""

# ╔═╡ b49f8963-6f6c-423b-8559-3bf538f7ae88
WebPage("https://tidierorg.github.io/Tidier.jl/dev/")

# ╔═╡ b9b896dd-5c35-4711-8885-71af1547d644
md"""
## Graphs?
"""

# ╔═╡ 98048ed6-a03c-400d-a6a2-3172caa418c7
md"""
Reference ecosystem: [JuliaGraphs](https://juliagraphs.org/)
"""

# ╔═╡ cb7ea381-1732-4578-8bf8-1d8839350371
md"""
## For Biologist
"""

# ╔═╡ 2b3d27a3-9814-4a18-b8e0-96fe8cde6f63
md"""
[This paper](https://www.nature.com/articles/s41592-023-01832-z) sells Julia pretty well for Biologist (and others)
"""

# ╔═╡ 7bdc98d0-86ff-431d-95ae-201da3ca8a83
Resource("https://media.springernature.com/full/springer-static/image/art%3A10.1038%2Fs41592-023-01832-z/MediaObjects/41592_2023_1832_Fig2_HTML.png?as=webp")

# ╔═╡ 05c088e3-572b-4bcd-aa60-5a8265dacfd7
md"""
## Calling other languages
"""

# ╔═╡ 109b6045-fdf3-41eb-977c-a6d5717cee8b
md"""
Interfaces with C(++), Python and R are solid and easy to use.
"""

# ╔═╡ f086b824-bc3f-4d72-8878-7a8e3c8da42d
md"""
## Parallel computing
"""

# ╔═╡ befe57d0-5c74-4d16-9875-d3a822dadbba
md"""
[Official Documentation link](https://docs.julialang.org/en/v1/manual/parallel-computing/) + a [great video](https://www.youtube.com/watch?v=uKdpY6Je6Oc)

1. Multi-threading
2. Distributed computing:
3. GPU computing:
4. Asynchronous "tasks", or coroutines:
"""

# ╔═╡ 2345567b-3d2d-4b9c-bac6-2d753280fb48
md"""
## MetaProgramming (macros)
"""

# ╔═╡ e9cf406d-2f81-4bb1-98f7-b9b6d118fd08
md"""
Basically metaprogramming refers to a variety of ways a program has knowledge of itself or can manipulate itself. [See docs more more details](https://docs.julialang.org/en/v1/manual/metaprogramming/)) 

!!! note "In pratice: cool macros"
	- Use to have simple call to other language
	- `@time`, `@.`, `@ode_def` `@lie`, `@reaction_network`, ...

```julia
macro time(ex)
  return quote
    local t0 = time_ns()
    local val = $ex
    local t1 = time_ns()
    println("elapsed time: ", (t1-t0)/1e9, " seconds")
    val
  end
end
```
"""

# ╔═╡ ff8beb7f-a458-4b24-bd6b-d4667f88d99b
md"""
## Some success stories
"""

# ╔═╡ 1853271a-d192-41bd-9bbe-b68237748ff4
md"""
* Large scale academic projects:
  - [Climate Modeling Alliance](https://clima.caltech.edu/)
  - [Celeste project](https://juliahub.com/case-studies/celeste/index.html) for astronomy
  - [Julia joins Petaflop club](https://info.juliahub.com/julia-joins-petaflop-club) after 
- Companies:
  - [Pumas AI](https://pumas.ai/) for drug discovery
  - [Invenia](https://www.invenia.ca/) for energy grids
  - [JuliaHub](https://juliahub.com/) for lots of stuff
- Random
  - [ChatGPT works best in Julia for LLM Code Generation over Python/R](https://arxiv.org/pdf/2308.04477.pdf) see Figure 1.
"""

# ╔═╡ 2b80967a-7dda-4bc9-81da-f236f6b92eaf
md"""
# Writing/Developping in Julia
"""

# ╔═╡ 0031e69a-5463-4cae-84f7-357414bb7ee8
md"""
## Style
Check the [style guide](https://docs.julialang.org/en/v1/manual/style-guide/) to write idiomatic Julia
"""

# ╔═╡ 1dcc351e-0056-4372-bd4f-e8e7d15227de
Resource("https://imgs.xkcd.com/comics/code_quality.png")

# ╔═╡ ec0ed1b5-db84-45c0-99a7-b2d0b99ef865
md"""
**Example:** in-place (mutating) function that modify their argument(s) take a `!`
```julia
function double_me!(x)
  for i eachindex(x)
    x[i] = 2*x[i]
  end
end
```
More efficient in general!
You see this convention everywhere (plots, seed, etc)
"""

# ╔═╡ 3d776522-9821-475c-a45d-88d28abc6d13
md"""
## Performance tips
See the great official documentation: [Performance tips](https://docs.julialang.org/en/v1/manual/performance-tips/).
"""

# ╔═╡ 6f4f76a3-8413-4e77-8db9-0073232bfa1c
WebPage("https://docs.julialang.org/en/v1/manual/performance-tips/")

# ╔═╡ e8c8ad53-6430-4391-96da-71b31ed8e4c2
md"""
## Profiling

[Profiling tools](https://docs.julialang.org/en/v1/manual/profile/): Benchmark, Profiler, code inspection etc
"""

# ╔═╡ f296fdb3-ae28-434c-9eac-64bb5603758d
md"""
## Package management
"""

# ╔═╡ 3c6e7597-5ae6-45b1-97e2-b1e535d446d4
Resource("https://imgs.xkcd.com/comics/python_environment.png")

# ╔═╡ 08e40303-fe22-4c5b-a54b-66bcb3eaad2a
md"""
- The package manager comes with the language
- Creates reproducible environments
- Handles dependencies and versions properly
- Unit testing and documentation easy to set up
"""

# ╔═╡ 89067140-1253-45a5-807d-6e6f8b6c65bc
md"""
#### Live exemple!
"""

# ╔═╡ 7a18486a-847a-417b-a28e-463df434640e
md"""
# Why not?
"""

# ╔═╡ 2e423841-4bdc-4a60-ac97-446abe726217
md"""
## Commun arguments
"""

# ╔═╡ 3b267f71-8ed7-44f4-a653-918ecab5f0d3
md"""
- The **Entry cost**
- > "I invested too much in Python"
- You have one package that does exactly what you want fast and easy and you just use that.
"""

# ╔═╡ 3e5557d3-4e9f-488b-8725-b396a02fc18a
md"""
## Package reliability
"""

# ╔═╡ 30d89ed0-f1a5-4537-9085-b133de9c81a4
md"""
- Packages are often academic in nature even the big ones
- Documentation and maintenance can be lacking
- Be ready to open (and solve) issues yourself
"""

# ╔═╡ 4093f40d-b6ff-4bfe-ba44-02c23dba816c
md"""
To be fair this is also true for other languages!
"""

# ╔═╡ f1c177e3-52c8-444e-b24e-9ff149592931
Resource("https://imgs.xkcd.com/comics/dependency.png")

# ╔═╡ 9c250234-9e87-4862-9ad3-7e5d7907f7f4
md"""
## Deep learning is still maturing
"""

# ╔═╡ beb4699b-50e6-4e04-b227-f33c87defe46
md"""
- No big company supports it $\neq$ PyTorch (Facebook), Tensorflow (Google), JAX (Google)
- Only some areas are state-of-the-art (scientific machine learning)
- Recent and less recent discussions among the Julia community:
- [State of machine learning (2022)](https://discourse.julialang.org/t/state-of-machine-learning-in-julia/74385/)
- [State of automatic differentiation (2023)](https://discourse.julialang.org/t/whats-the-state-of-automatic-differentiation-in-julia-january-2023/92473/)
- [Why I no longer recommend Julia](https://discourse.julialang.org/t/discussion-on-why-i-no-longer-recommend-julia-by-yuri-vishnevsky/81151)
"""

# ╔═╡ a6cc9772-9856-40d5-bd7e-30945b161719
Resource("https://imgs.xkcd.com/comics/machine_learning.png")

# ╔═╡ bab7ce3d-4cee-487a-b5d6-cd08f8c1145b
md"""
# Resource
"""

# ╔═╡ 0a573998-6a80-4dad-99cb-6d9d56745b10
md"""
- [Modern Julia Workflows](https://modernjuliaworkflows.github.io/): A must read for beginner and advanced used.
- [Julia Academy](https://juliaacademy.com/p/intro-to-julia) and here for the [first lecture video](https://www.youtube.com/watch?v=4igzy3bGVkQ&list=PLP8iPy9hna6SCcFv3FvY_qjAmtTsNYHQE)
- [DataFrames.jl Cheat Sheet](https://ahsmart.com/assets/pages/data-wrangling-with-data-frames-jl-cheat-sheet/DataFramesCheatSheet_v1.x_rev1.pdf?ref=juliafordatascience.com), also look at [DataFramesMeta.jl](https://juliadata.org/DataFramesMeta.jl/stable/)
- [Julia Data Science](https://juliadatascience.io/): Big overview aimed for Data science
- [doggo dot jl Youtube videos](https://www.youtube.com/@doggodotjl) and [associated repo](https://github.com/julia4ta/tutorials): Tutorial over plenty of basics and advanced topics.
"""

# ╔═╡ 9794b531-30a4-46a3-97d2-443e6289ba6d
md"""
I should definitly add more!
"""

# ╔═╡ ad25926a-31e8-48c2-b22e-f96009a4872a
md"""
!!! warning
    Sometimes you will find resources that are a bit outdated. The language and packages have evolved quite rapidly over the past few years.
	Always check the dates. More than 3 years old might be too old.
"""

# ╔═╡ 0912c886-2a33-4fce-a805-7829f7a143e8
md"""
# Appendix
"""

# ╔═╡ 4a5ba23a-df28-4f34-9f24-ae1a07c6e5c0
md"""
## Packages used
"""

# ╔═╡ 819b644e-a7a0-4d49-83d4-01c41653eea2
md"""
Package extension to pimp Pluto
"""

# ╔═╡ e1c0635c-c469-4ea6-845f-94bb7a58cac3
function Base.show(io::IO, ::MIME"text/html", page::WebPage)
	print(io, ShortCodes.webpage(page.url, 400*1.5,700*1.5))
end

# ╔═╡ 0c32f263-55ab-40d2-a626-1825109d2665
ExtendedTableOfContents(hide_preamble = false)

# ╔═╡ 91592a94-32c7-4c60-90bb-981643e473d8
md"""
## Look of the notebook
"""

# ╔═╡ 695c8e1b-e9f7-4aa9-9543-5ed69227e7ab
md"""
Font size $(@bind fontsize_md NumberField(1:100, default=25))
"""

# ╔═╡ 8b8af85b-8327-4f3b-9134-4b6d17d69ad4
md"""
Page width = $(@bind max_width NumberField(1:100, default=70))
"""

# ╔═╡ d44835c4-ab05-4258-a841-a55521f8cec9
begin
	md_font=".markdown{ font-size: $(string(fontsize_md))px; }"
	max_width_html="max-width: $(max_width)%;"
	htl"""<style>
	pluto-output>div>img { margin: auto; display: block; }
    .toc-row { margin: 0 !important; padding: 0.5 !important; }
	main {
	    $(max_width_html)
	}
	$(md_font)
	"""
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
BenchmarkTools = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Dates = "ade2ca70-3891-5945-98fb-dc099432e06a"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
IntervalArithmetic = "d1acc4aa-44c8-5952-acd4-ba5d80a2a253"
LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
LogarithmicNumbers = "aa2f6b4e-9042-5d33-9679-40d3a6b85899"
Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
Pkg = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoExtras = "ed5d0301-4775-4676-b788-cf71e66ff8ed"
PlutoReport = "ab5eb977-4f23-42a0-954d-2743fb6218c4"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoTest = "cb4044da-4d16-4ffa-a6a3-8cad7f73ebdc"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
ShortCodes = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"
Symbolics = "0c5d862f-8b57-4792-8d23-62f2024744c7"
Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[compat]
BenchmarkTools = "~1.3.2"
DataFrames = "~1.6.1"
Distributions = "~0.25.103"
HypertextLiteral = "~0.9.5"
IntervalArithmetic = "~0.20.8"
LogarithmicNumbers = "~1.3.0"
Measurements = "~2.11.0"
Plots = "~1.38.10"
PlutoExtras = "~0.7.11"
PlutoReport = "~0.4.0"
PlutoTeachingTools = "~0.2.13"
PlutoTest = "~0.2.2"
PlutoUI = "~0.7.54"
ShortCodes = "~0.3.6"
Symbolics = "~5.10.0"
Unitful = "~1.18.0"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.2"
manifest_format = "2.0"
project_hash = "3e0a21077a43b286db8d9a53ee4654296b4b576f"

[[deps.ADTypes]]
git-tree-sha1 = "016833eb52ba2d6bea9fcb50ca295980e728ee24"
uuid = "47edcb42-4c32-4615-8424-f2b9edc5f35b"
version = "0.2.7"

[[deps.AbstractAlgebra]]
deps = ["GroupsCore", "InteractiveUtils", "LinearAlgebra", "MacroTools", "Preferences", "Random", "RandomExtensions", "SparseArrays", "Test"]
git-tree-sha1 = "c3c29bf6363b3ac3e421dc8b2ba8e33bdacbd245"
uuid = "c3fe647b-3220-5bb0-a1ea-a7954cac585d"
version = "0.32.5"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AbstractTrees]]
git-tree-sha1 = "2d9c9a55f9c93e8887ad391fbae72f8ef55e1177"
uuid = "1520ce14-60c1-5f80-bbc7-55ef81b5835c"
version = "0.4.5"

[[deps.Accessors]]
deps = ["CompositionsBase", "ConstructionBase", "Dates", "InverseFunctions", "MacroTools"]
git-tree-sha1 = "3b86719127f50670efe356bc11073d84b4ed7a5d"
uuid = "7d9f7c33-5ae7-4f3b-8dc6-eff91059b697"
version = "0.1.42"

    [deps.Accessors.extensions]
    AxisKeysExt = "AxisKeys"
    IntervalSetsExt = "IntervalSets"
    LinearAlgebraExt = "LinearAlgebra"
    StaticArraysExt = "StaticArrays"
    StructArraysExt = "StructArrays"
    TestExt = "Test"
    UnitfulExt = "Unitful"

    [deps.Accessors.weakdeps]
    AxisKeys = "94b1ba4f-4ee9-5380-92f1-94cde586c3c5"
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"
    StructArrays = "09ab397b-f2b6-538f-b94a-2f83cf4a842a"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "cde29ddf7e5726c9fb511f340244ea3481267608"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "3.7.2"
weakdeps = ["StaticArrays"]

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra", "Requires", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "c5aeb516a84459e0318a02507d2261edad97eb75"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.7.1"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.BenchmarkTools]]
deps = ["JSON", "Logging", "Printf", "Profile", "Statistics", "UUIDs"]
git-tree-sha1 = "d9a9701b899b30332bbcb3e1679c41cce81fb0e8"
uuid = "6e4b80f9-dd63-53aa-95a3-0cdb28fa8baf"
version = "1.3.2"

[[deps.BibInternal]]
deps = ["TestItems"]
git-tree-sha1 = "b3107800faf461eca3281f89f8d768f4b3e99969"
uuid = "2027ae74-3657-4b95-ae00-e2f7d55c3e64"
version = "0.3.7"

[[deps.BibParser]]
deps = ["BibInternal", "DataStructures", "Dates", "JSONSchema", "TestItems", "YAML"]
git-tree-sha1 = "33478bed83bd124ea8ecd9161b3918fb4c70e529"
uuid = "13533e5b-e1c2-4e57-8cef-cac5e52f6474"
version = "0.2.2"

[[deps.Bibliography]]
deps = ["BibInternal", "BibParser", "DataStructures", "Dates", "FileIO", "YAML"]
git-tree-sha1 = "520c679daed011ce835d9efa7778863aad6687ed"
uuid = "f1be7e48-bf82-45af-a471-ae754a193061"
version = "0.2.20"

[[deps.Bijections]]
git-tree-sha1 = "d8b0439d2be438a5f2cd68ec158fe08a7b2595b7"
uuid = "e2ed5e7c-b2de-5872-ae92-c73ca462fb04"
version = "0.1.9"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b96ea4a01afe0ea4090c5c8039690672dd13f2e"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.9+0"

[[deps.CRlibm]]
deps = ["CRlibm_jll"]
git-tree-sha1 = "66188d9d103b92b6cd705214242e27f5737a1e5e"
uuid = "96374032-68de-5a5b-8d9e-752f78720389"
version = "1.0.2"

[[deps.CRlibm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e329286945d0cfc04456972ea732551869af1cfc"
uuid = "4e9b3aee-d8a1-5a3d-ad8b-7d824db253f0"
version = "1.0.1+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "2ac646d71d0d24b44f3f8c84da8c9f4d70fb67df"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.18.4+0"

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "9cb23bbb1127eefb022b022481466c0f1127d430"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.2"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra"]
git-tree-sha1 = "1713c74e00545bfe14605d2a2be1712de8fbcb58"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.25.1"
weakdeps = ["SparseArrays"]

    [deps.ChainRulesCore.extensions]
    ChainRulesCoreSparseArraysExt = "SparseArrays"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "7eee164f122511d3e4e1ebadb7956939ea7e1c77"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.6"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "962834c22b66e32aa10f7611c08c8ca4e20749a9"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.8"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "403f2d8e209681fcbd9468a8514efff3ea08452e"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.29.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "Requires", "Statistics", "TensorCore"]
git-tree-sha1 = "a1f44953f2382ebb937d60dafbe2deea4bd23249"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.10.0"
weakdeps = ["SpecialFunctions"]

    [deps.ColorVectorSpace.extensions]
    SpecialFunctionsExt = "SpecialFunctions"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "64e15186f0aa277e174aa81798f7eb8598e0157e"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.13.0"

[[deps.Combinatorics]]
git-tree-sha1 = "08c8b6831dc00bfea825826be0bc8336fc369860"
uuid = "861a8166-3701-5b0c-9a16-15d98fcdc6aa"
version = "1.0.2"

[[deps.CommonSolve]]
git-tree-sha1 = "0eee5eb66b1cf62cd6ad1b460238e60e4b09400c"
uuid = "38540f10-b2f7-11e9-35d8-d573e4eb0ff2"
version = "0.2.4"

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.CompositeTypes]]
git-tree-sha1 = "bce26c3dab336582805503bed209faab1c279768"
uuid = "b152e2b5-7a66-4b01-a709-34e65c35f657"
version = "0.1.4"

[[deps.CompositionsBase]]
git-tree-sha1 = "802bb88cd69dfd1509f6670416bd4434015693ad"
uuid = "a33af91c-f02d-484b-be07-31d278c5ca2b"
version = "0.1.2"
weakdeps = ["InverseFunctions"]

    [deps.CompositionsBase.extensions]
    CompositionsBaseInverseFunctionsExt = "InverseFunctions"

[[deps.ConcreteStructs]]
git-tree-sha1 = "f749037478283d372048690eb3b5f92a79432b34"
uuid = "2569d6c7-a4a2-43d3-a901-331e8e4be471"
version = "0.2.3"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "d9d26935a0bcffc87d2613ce14c527c99fc543fd"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.5.0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "d8a9c0b6ac2d9081bf76324b39c78ca3ce4f0c98"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.6"
weakdeps = ["IntervalSets", "StaticArrays"]

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

[[deps.Contour]]
git-tree-sha1 = "439e35b0b36e2e5881738abc8857bd92ad6ff9a8"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.3"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "04c738083f29f86e62c8afc341f0967d8717bdb8"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.6.1"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "4e1fe97fdaed23e9dc21d4d664bea76b65fc50a0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.22"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Dbus_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "fc173b380865f70627d7dd1190dc2fce6cc105af"
uuid = "ee1fde0b-3d02-5ea6-8484-8dfef6360eab"
version = "1.14.10+0"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "0b4190661e8a4e51a842070e7dd4fae440ddb7f4"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.118"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.DomainSets]]
deps = ["CompositeTypes", "IntervalSets", "LinearAlgebra", "Random", "StaticArrays", "Statistics"]
git-tree-sha1 = "51b4b84d33ec5e0955b55ff4b748b99ce2c3faa9"
uuid = "5b8099bc-c8ec-5219-889f-1d9e522a28bf"
version = "0.6.7"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DynamicPolynomials]]
deps = ["Future", "LinearAlgebra", "MultivariatePolynomials", "MutableArithmetics", "Pkg", "Reexport", "Test"]
git-tree-sha1 = "30a1848c4f4fc35d1d4bbbd125650f6a11b5bc6c"
uuid = "7c1d4256-1411-5781-91ec-d7bc3513ac07"
version = "0.5.7"

[[deps.EnumX]]
git-tree-sha1 = "bdb1942cd4c45e3c678fd11569d5cccd80976237"
uuid = "4e289a0a-7415-4d19-859d-a7e5c4648b56"
version = "1.0.4"

[[deps.EpollShim_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a4be429317c42cfae6a7fc03c31bad1970c310d"
uuid = "2702e6a9-849d-5ed8-8c21-79e8b8f9ee43"
version = "0.0.20230411+1"

[[deps.ErrorfreeArithmetic]]
git-tree-sha1 = "d6863c556f1142a061532e79f611aa46be201686"
uuid = "90fa49ef-747e-5e6f-a989-263ba693cf1a"
version = "0.5.2"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "d36f682e590a83d63d1c7dbd287573764682d12a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.11"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "d55dffd9ae73ff72f1c0482454dcf2ec6c6c4a63"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.6.5+0"

[[deps.ExprTools]]
git-tree-sha1 = "27415f162e6028e81c72b82ef756bf321213b6ec"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.10"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "53ebe7511fa11d33bec688a9178fac4e49eeee00"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.2"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "466d45dc38e15794ec7d5d63ec03d776a9aff36e"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.4+1"

[[deps.FastRounding]]
deps = ["ErrorfreeArithmetic", "LinearAlgebra"]
git-tree-sha1 = "6344aa18f654196be82e62816935225b3b9abe44"
uuid = "fa42c844-2597-5d31-933b-ebd51ab2693f"
version = "0.3.1"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "b66970a70db13f45b7e57fbda1736e1cf72174ea"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.17.0"
weakdeps = ["HTTP"]

    [deps.FileIO.extensions]
    HTTPExt = "HTTP"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "6a70198746448456524cb442b8af316927ff3e1a"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.13.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Zlib_jll"]
git-tree-sha1 = "21fac3c77d7b5a9fc03b0ec503aa1a6392c34d2b"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.15.0+0"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "a2df1b776752e3f344e5116c06d75a10436ab853"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.38"
weakdeps = ["StaticArrays"]

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "786e968a8d2fb167f2e4880baba62e0e26bd8e4e"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.13.3+1"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "846f7026a9decf3679419122b49f8a1fdb48d2d5"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.16+0"

[[deps.FunctionWrappers]]
git-tree-sha1 = "d62485945ce5ae9c0c48f124a84998d755bae00e"
uuid = "069b7b12-0de2-55c6-9aab-29f3d0a68a2e"
version = "1.1.3"

[[deps.FunctionWrappersWrappers]]
deps = ["FunctionWrappers"]
git-tree-sha1 = "b104d487b34566608f8b4e1c39fb0b10aa279ff8"
uuid = "77dc65aa-8811-40c2-897b-53d922fa7daf"
version = "0.1.3"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll", "libdecor_jll", "xkbcommon_jll"]
git-tree-sha1 = "fcb0584ff34e25155876418979d4c8971243bb89"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.4.0+2"

[[deps.GPUArraysCore]]
deps = ["Adapt"]
git-tree-sha1 = "2d6ca471a6c7b536127afccfa7564b5b39227fe0"
uuid = "46192b85-c4d5-4398-a991-12ede77f4527"
version = "0.1.5"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "27442171f28c952804dede8ff72828a96f2bfc1f"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.10"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "FreeType2_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt6Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "025d171a2847f616becc0f84c8dc62fe18f0f6dd"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.10+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Zlib_jll"]
git-tree-sha1 = "b0036b392358c80d2d2124746c2bf3d48d457938"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.82.4+0"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "01979f9b37367603e2848ea225918a3b3861b606"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+1"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.Groebner]]
deps = ["AbstractAlgebra", "Combinatorics", "ExprTools", "Logging", "MultivariatePolynomials", "Primes", "Random", "SIMD", "SnoopPrecompile"]
git-tree-sha1 = "44f595de4f6485ab5ba71fe257b5eadaa3cf161e"
uuid = "0b43b601-686d-58a3-8a1c-6623616c7cd4"
version = "0.4.4"

[[deps.GroupsCore]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "6df9cd6ee79fc59feab33f63a1b3c9e95e2461d5"
uuid = "d5909c97-4eac-4ecc-a3dc-fdd0858a4120"
version = "0.4.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "PrecompileTools", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "c67b33b085f6e2faf8bf79a61962e7339a81129c"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.15"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll"]
git-tree-sha1 = "55c53be97790242c29031e5cd45e8ac296dadda3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "8.5.0+0"

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "68c173f4f449de5b438ee67ed0c9c748dc31a2ec"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.28"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.IfElse]]
git-tree-sha1 = "debdd00ffef04665ccbb3e150747a77560e8fad1"
uuid = "615f187c-cbe4-4ef1-ba3b-2fcf58d6d173"
version = "0.1.1"

[[deps.InlineStrings]]
git-tree-sha1 = "6a9fde685a7ac1eb3495f8e812c5a7c3711c2d5e"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.3"

    [deps.InlineStrings.extensions]
    ArrowTypesExt = "ArrowTypes"
    ParsersExt = "Parsers"

    [deps.InlineStrings.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"
    Parsers = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"

[[deps.IntegerMathUtils]]
git-tree-sha1 = "b8ffb903da9f7b8cf695a8bead8e01814aa24b30"
uuid = "18e54dd8-cb9d-406c-a71d-865a43cbb235"
version = "0.1.2"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.IntervalArithmetic]]
deps = ["CRlibm", "FastRounding", "LinearAlgebra", "Markdown", "Random", "RecipesBase", "RoundingEmulator", "SetRounding", "StaticArrays"]
git-tree-sha1 = "5ab7744289be503d76a944784bac3f2df7b809af"
uuid = "d1acc4aa-44c8-5952-acd4-ba5d80a2a253"
version = "0.20.9"

[[deps.IntervalSets]]
git-tree-sha1 = "dba9ddf07f77f60450fe5d2e2beb9854d9a49bd0"
uuid = "8197267c-284f-5f27-9208-e0e47529a953"
version = "0.7.10"
weakdeps = ["Random", "RecipesBase", "Statistics"]

    [deps.IntervalSets.extensions]
    IntervalSetsRandomExt = "Random"
    IntervalSetsRecipesBaseExt = "RecipesBase"
    IntervalSetsStatisticsExt = "Statistics"

[[deps.InverseFunctions]]
git-tree-sha1 = "a779299d77cd080bf77b97535acecd73e1c5e5cb"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.17"
weakdeps = ["Dates", "Test"]

    [deps.InverseFunctions.extensions]
    InverseFunctionsDatesExt = "Dates"
    InverseFunctionsTestExt = "Test"

[[deps.InvertedIndices]]
git-tree-sha1 = "6da3c4316095de0f5ee2ebd875df8721e7e0bdbe"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.1"

[[deps.IrrationalConstants]]
git-tree-sha1 = "e2222959fbc6c19554dc15174c81bf7bf3aa691c"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.4"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "71b48d857e86bf7a1838c4736545699974ce79a2"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.9"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "a007feb38b422fbdab534406aeca1b86823cb4d6"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.7.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JSON3]]
deps = ["Dates", "Mmap", "Parsers", "PrecompileTools", "StructTypes", "UUIDs"]
git-tree-sha1 = "1d322381ef7b087548321d3f878cb4c9bd8f8f9b"
uuid = "0f8b85d8-7281-11e9-16c2-39a750bddbf1"
version = "1.14.1"

    [deps.JSON3.extensions]
    JSON3ArrowExt = ["ArrowTypes"]

    [deps.JSON3.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"

[[deps.JSONSchema]]
deps = ["Downloads", "JSON", "JSON3", "URIs"]
git-tree-sha1 = "243f1cdb476835d7c249deb9f29ad6b7827da7d3"
uuid = "7d188eb4-7ad8-530c-ae41-71a32a6d4692"
version = "1.4.1"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "eac1206917768cb54957c65a615460d87b455fc1"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "3.1.1+0"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "a434e811d10e7cbf4f0674285542e697dca605d0"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.42"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "170b660facf5df5de098d866564877e119141cbd"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.2+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "78211fb6cbc872f77cad3fc0b6cf647d923f4929"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "18.1.7+0"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1c602b1127f4751facb671441ca72715cc95938a"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.3+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

[[deps.LabelledArrays]]
deps = ["ArrayInterface", "ChainRulesCore", "ForwardDiff", "LinearAlgebra", "MacroTools", "PreallocationTools", "RecursiveArrayTools", "StaticArrays"]
git-tree-sha1 = "d1f981fba6eb3ec393eede4821bca3f2b7592cd4"
uuid = "2ee39098-c373-598a-b85f-a56591580800"
version = "1.15.1"

[[deps.LambertW]]
git-tree-sha1 = "c5ffc834de5d61d00d2b0e18c96267cffc21f648"
uuid = "984bce1d-4616-540c-a9ee-88d1112d94c9"
version = "0.4.6"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "cd714447457c660382fe634710fb56eb255ee42e"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.6"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LatticeRules]]
deps = ["Random"]
git-tree-sha1 = "7f5b02258a3ca0221a6a9710b0a0a2e8fb4957fe"
uuid = "73f95e8e-ec14-4e6a-8b18-0d2e271c4e55"
version = "0.0.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "27ecae93dd25ee0909666e6835051dd684cc035e"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+2"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll"]
git-tree-sha1 = "8be878062e0ffa2c3f67bb58a595375eda5de80b"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.11.0+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "ff3b4b9d35de638936a525ecd36e86a8bb919d11"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.7.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "df37206100d39f79b3376afb6b9cee4970041c61"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.51.1+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "be484f5c92fad0bd8acfef35fe017900b0b73809"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.18.0+0"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "89211ea35d9df5831fca5d33552c02bd33878419"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.40.3+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "XZ_jll", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "2da088d113af58221c52828a80378e16be7d037a"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.5.1+1"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e888ad02ce716b319e6bdb985d2ef300e7089889"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.40.3+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "13ca9e2586b89836fd20cccf56e57e2b9ae7f38f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.29"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.LogarithmicNumbers]]
deps = ["Random"]
git-tree-sha1 = "d5b819cf4d82bbcb9f45a4a3ed37e7a694f8e287"
uuid = "aa2f6b4e-9042-5d33-9679-40d3a6b85899"
version = "1.3.0"
weakdeps = ["ForwardDiff"]

    [deps.LogarithmicNumbers.extensions]
    LogarithmicNumbersForwardDiffExt = "ForwardDiff"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "f02b56007b064fbfddb4c9cd60161b6dd0f40df3"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.1.0"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "688d6d9e098109051ae33d126fcfc88c4ce4a021"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.1.0"

[[deps.MIMEs]]
git-tree-sha1 = "c64d943587f7187e751162b3b84445bbbd79f691"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "1.1.0"

[[deps.MacroTools]]
git-tree-sha1 = "72aebe0b5051e5143a079a4685a46da330a40472"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.15"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Measurements]]
deps = ["Calculus", "LinearAlgebra", "Printf", "Requires"]
git-tree-sha1 = "bdcde8ec04ca84aef5b124a17684bf3b302de00e"
uuid = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
version = "2.11.0"

    [deps.Measurements.extensions]
    MeasurementsBaseTypeExt = "BaseType"
    MeasurementsJunoExt = "Juno"
    MeasurementsRecipesBaseExt = "RecipesBase"
    MeasurementsSpecialFunctionsExt = "SpecialFunctions"
    MeasurementsUnitfulExt = "Unitful"

    [deps.Measurements.weakdeps]
    BaseType = "7fbed51b-1ef5-4d67-9085-a4a9b26f478c"
    Juno = "e5e0dc1b-0480-54bc-9374-aad01c23163d"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    SpecialFunctions = "276daf66-3868-5448-9aa4-cd146d93841b"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Memoize]]
deps = ["MacroTools"]
git-tree-sha1 = "2b1dfcba103de714d31c033b5dacc2e4a12c7caa"
uuid = "c03570c3-d221-55d1-a50c-7939bbd78826"
version = "0.4.4"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.MultivariatePolynomials]]
deps = ["ChainRulesCore", "DataStructures", "LinearAlgebra", "MutableArithmetics"]
git-tree-sha1 = "8d39779e29f80aa6c071e7ac17101c6e31f075d7"
uuid = "102ac46a-7ee4-5c85-9060-abc95bfdeaa3"
version = "0.5.7"

[[deps.MutableArithmetics]]
deps = ["LinearAlgebra", "SparseArrays", "Test"]
git-tree-sha1 = "491bdcdc943fcbc4c005900d7463c9f216aabf4c"
uuid = "d8a4904e-b15c-11e9-3269-09a3773c0cb0"
version = "1.6.4"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "cc0a5deefdb12ab3a096f00a6d42133af4560d71"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.1.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "38cb508d080d21dc1128f7fb04f20387ed4c0af4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.3"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "a9697f1d06cc3eb3fb3ad49cc67f2cfabaac31ea"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.16+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1346c9208249809840c91b26703912dff463d335"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.6+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6703a85cb3781bd5909d48730a67205f3f31a575"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.3+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "cc4054e898b852042d7b503313f7ad03de99c3dd"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.8.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.42.0+1"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "966b85253e959ea89c53a9abebbf2e964fbf593b"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.32"

[[deps.Pango_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "FriBidi_jll", "Glib_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl"]
git-tree-sha1 = "3b31172c032a1def20c98dae3f2cdc9d10e3b561"
uuid = "36c8627f-9965-5494-a995-c6b170f724f3"
version = "1.56.1+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "db76b1ecd5e9715f3d043cec13b2ec93ce015d53"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.44.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "41031ef3a1be6f5bbbf3e8073f210556daeae5ca"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.3.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "StableRNGs", "Statistics"]
git-tree-sha1 = "3ca9a356cd2e113c420f2c13bea19f8d3fb1cb18"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.4.3"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "9f8675a55b37a70aa23177ec110f6e3f4dd68466"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.17"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoExtras]]
deps = ["AbstractPlutoDingetjes", "DocStringExtensions", "HypertextLiteral", "InteractiveUtils", "Markdown", "PlutoUI", "REPL", "Random"]
git-tree-sha1 = "8933d5e99795923433eb161223dc666d70b18a09"
uuid = "ed5d0301-4775-4676-b788-cf71e66ff8ed"
version = "0.7.14"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

[[deps.PlutoReport]]
deps = ["Bibliography", "Downloads", "HTTP", "HypertextLiteral", "JSON3", "PlutoUI", "Reexport"]
git-tree-sha1 = "6dd9866473320c5ec5cd139f3a093cedbdf4cbb3"
uuid = "ab5eb977-4f23-42a0-954d-2743fb6218c4"
version = "0.4.0"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "LaTeXStrings", "Latexify", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "5d9ab1a4faf25a62bb9d07ef0003396ac258ef1c"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.15"

[[deps.PlutoTest]]
deps = ["HypertextLiteral", "InteractiveUtils", "Markdown", "Test"]
git-tree-sha1 = "17aa9b81106e661cffa1c4c36c17ee1c50a86eda"
uuid = "cb4044da-4d16-4ffa-a6a3-8cad7f73ebdc"
version = "0.2.2"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "7e71a55b87222942f0f9337be62e26b1f103d3e4"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.61"

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

[[deps.PreallocationTools]]
deps = ["Adapt", "ArrayInterface", "ForwardDiff"]
git-tree-sha1 = "6c62ce45f268f3f958821a1e5192cf91c75ae89c"
uuid = "d236fae5-4411-538c-8e31-a6e3d9e00b46"
version = "0.4.24"

    [deps.PreallocationTools.extensions]
    PreallocationToolsReverseDiffExt = "ReverseDiff"

    [deps.PreallocationTools.weakdeps]
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1101cd475833706e4d0e7b122218257178f48f34"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.4.0"

[[deps.Primes]]
deps = ["IntegerMathUtils"]
git-tree-sha1 = "25cdd1d20cd005b52fc12cb6be3f75faaf59bb9b"
uuid = "27ebfcd6-29c5-5fa9-bf4b-fb8fc14df3ae"
version = "0.5.7"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.Profile]]
uuid = "9abbd945-dff8-562f-b5e8-e1ebf5ef1b79"
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "1d36ef11a9aaf1e8b74dacc6a731dd1de8fd493d"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.3.0"

[[deps.Qt6Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Vulkan_Loader_jll", "Xorg_libSM_jll", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_cursor_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "libinput_jll", "xkbcommon_jll"]
git-tree-sha1 = "37b7bb7aabf9a085e0044307e1717436117f2b3b"
uuid = "c0090381-4147-56d7-9ebc-da0b1113ec56"
version = "6.5.3+1"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "9da16da70037ba9d701192e27befedefb91ec284"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.2"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

[[deps.QuasiMonteCarlo]]
deps = ["Accessors", "ConcreteStructs", "LatticeRules", "LinearAlgebra", "Primes", "Random", "Requires", "Sobol", "StatsBase"]
git-tree-sha1 = "cc086f8485bce77b6187141e1413c3b55f9a4341"
uuid = "8a4e6c94-4038-4cdc-81c3-7e6ffdb2a71b"
version = "0.3.3"
weakdeps = ["Distributions"]

    [deps.QuasiMonteCarlo.extensions]
    QuasiMonteCarloDistributionsExt = "Distributions"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.RandomExtensions]]
deps = ["Random", "SparseArrays"]
git-tree-sha1 = "b8a399e95663485820000f26b6a43c794e166a49"
uuid = "fb686558-2515-59ef-acaa-46db3789a887"
version = "0.4.4"

[[deps.RecipesBase]]
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

[[deps.RecursiveArrayTools]]
deps = ["Adapt", "ArrayInterface", "DocStringExtensions", "GPUArraysCore", "IteratorInterfaceExtensions", "LinearAlgebra", "RecipesBase", "Requires", "StaticArraysCore", "Statistics", "SymbolicIndexingInterface", "Tables"]
git-tree-sha1 = "d7087c013e8a496ff396bae843b1e16d9a30ede8"
uuid = "731186ca-8d62-57ce-b412-fbd966d074cd"
version = "2.38.10"

    [deps.RecursiveArrayTools.extensions]
    RecursiveArrayToolsMeasurementsExt = "Measurements"
    RecursiveArrayToolsMonteCarloMeasurementsExt = "MonteCarloMeasurements"
    RecursiveArrayToolsTrackerExt = "Tracker"
    RecursiveArrayToolsZygoteExt = "Zygote"

    [deps.RecursiveArrayTools.weakdeps]
    Measurements = "eff96d63-e80a-5855-80a2-b1b0885c5ab7"
    MonteCarloMeasurements = "0987c9cc-fe09-11e8-30f0-b96dd679fdca"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "ffdaf70d81cf6ff22c2b6e733c900c3321cab864"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.1"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "62389eeff14780bfe55195b7204c0d8738436d64"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.1"

[[deps.Revise]]
deps = ["CodeTracking", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "9bb80533cb9769933954ea4ffbecb3025a783198"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.7.2"
weakdeps = ["Distributed"]

    [deps.Revise.extensions]
    DistributedExt = "Distributed"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "852bd0f55565a9e973fcfee83a84413270224dc4"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.8.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

[[deps.RoundingEmulator]]
git-tree-sha1 = "40b9edad2e5287e05bd413a38f61a8ff55b9557b"
uuid = "5eaf0fd0-dfba-4ccb-bf02-d820a40db705"
version = "0.2.1"

[[deps.RuntimeGeneratedFunctions]]
deps = ["ExprTools", "SHA", "Serialization"]
git-tree-sha1 = "04c968137612c4a5629fa531334bb81ad5680f00"
uuid = "7e49a35a-f44a-4d26-94aa-eba1b4ca6b47"
version = "0.5.13"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.SIMD]]
deps = ["PrecompileTools"]
git-tree-sha1 = "fea870727142270bdf7624ad675901a1ee3b4c87"
uuid = "fdea26ae-647d-5447-a871-4b548cad5224"
version = "3.7.1"

[[deps.SciMLBase]]
deps = ["ADTypes", "ArrayInterface", "CommonSolve", "ConstructionBase", "Distributed", "DocStringExtensions", "EnumX", "FillArrays", "FunctionWrappersWrappers", "IteratorInterfaceExtensions", "LinearAlgebra", "Logging", "Markdown", "PrecompileTools", "Preferences", "Printf", "QuasiMonteCarlo", "RecipesBase", "RecursiveArrayTools", "Reexport", "RuntimeGeneratedFunctions", "SciMLOperators", "StaticArraysCore", "Statistics", "SymbolicIndexingInterface", "Tables", "TruncatedStacktraces"]
git-tree-sha1 = "32ea825941f7b58a6f48268f4b76971ae8eb9eec"
uuid = "0bca4576-84f4-4d90-8ffe-ffa030f20462"
version = "2.10.0"

    [deps.SciMLBase.extensions]
    SciMLBaseChainRulesCoreExt = "ChainRulesCore"
    SciMLBasePartialFunctionsExt = "PartialFunctions"
    SciMLBasePyCallExt = "PyCall"
    SciMLBasePythonCallExt = "PythonCall"
    SciMLBaseRCallExt = "RCall"
    SciMLBaseZygoteExt = "Zygote"

    [deps.SciMLBase.weakdeps]
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    PartialFunctions = "570af359-4316-4cb7-8c74-252c00c2016b"
    PyCall = "438e738f-606a-5dbb-bf0a-cddfbfd45ab0"
    PythonCall = "6099a3de-0909-46bc-b1f4-468b9a2dfc0d"
    RCall = "6f49c342-dc21-5d91-9882-a32aef131414"
    Zygote = "e88e6eb3-aa80-5325-afca-941959d7151f"

[[deps.SciMLOperators]]
deps = ["Accessors", "ArrayInterface", "DocStringExtensions", "LinearAlgebra", "MacroTools"]
git-tree-sha1 = "6149620767866d4b0f0f7028639b6e661b6a1e44"
uuid = "c0aeaf25-5076-4817-a8d5-81caf7dfa961"
version = "0.3.12"
weakdeps = ["SparseArrays", "StaticArraysCore"]

    [deps.SciMLOperators.extensions]
    SciMLOperatorsSparseArraysExt = "SparseArrays"
    SciMLOperatorsStaticArraysCoreExt = "StaticArraysCore"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "712fb0231ee6f9120e005ccd56297abbc053e7e0"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.8"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.SetRounding]]
git-tree-sha1 = "d7a25e439d07a17b7cdf97eecee504c50fedf5f6"
uuid = "3cc68bcd-71a2-5612-b932-767ffbe40ab0"
version = "0.2.1"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "c5391c6ace3bc430ca630251d02ea9687169ca68"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.2"

[[deps.ShortCodes]]
deps = ["Base64", "CodecZlib", "Downloads", "JSON3", "Memoize", "URIs", "UUIDs"]
git-tree-sha1 = "5844ee60d9fd30a891d48bab77ac9e16791a0a57"
uuid = "f62ebe17-55c5-4640-972f-b59c0dd11ccf"
version = "0.3.6"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sobol]]
deps = ["DelimitedFiles", "Random"]
git-tree-sha1 = "5a74ac22a9daef23705f010f72c81d6925b19df8"
uuid = "ed01d8cd-4d21-5b2a-85b4-cc3bdc58bad4"
version = "1.5.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "64cca0c26b4f31ba18f13f6c12af7c85f478cfde"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.5.0"
weakdeps = ["ChainRulesCore"]

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

[[deps.StableRNGs]]
deps = ["Random"]
git-tree-sha1 = "83e6cce8324d49dfaf9ef059227f91ed4441a8e5"
uuid = "860ef19b-820b-49d6-a774-d7a799459cd3"
version = "1.0.2"

[[deps.StaticArrays]]
deps = ["LinearAlgebra", "PrecompileTools", "Random", "StaticArraysCore"]
git-tree-sha1 = "0feb6b9031bd5c51f9072393eb5ab3efd31bf9e4"
uuid = "90137ffa-7385-5640-81b9-e52037218182"
version = "1.9.13"
weakdeps = ["ChainRulesCore", "Statistics"]

    [deps.StaticArrays.extensions]
    StaticArraysChainRulesCoreExt = "ChainRulesCore"
    StaticArraysStatisticsExt = "Statistics"

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["AliasTables", "DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "29321314c920c26684834965ec2ce0dacc9cf8e5"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.4"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "b423576adc27097764a90e163157bcfc9acf0f46"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.2"
weakdeps = ["ChainRulesCore", "InverseFunctions"]

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

[[deps.StringEncodings]]
deps = ["Libiconv_jll"]
git-tree-sha1 = "b765e46ba27ecf6b44faf70df40c57aa3a547dcb"
uuid = "69024149-9ee7-55f6-a4c4-859efe599b68"
version = "0.3.7"

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "725421ae8e530ec29bcbdddbe91ff8053421d023"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.4.1"

[[deps.StructTypes]]
deps = ["Dates", "UUIDs"]
git-tree-sha1 = "159331b30e94d7b11379037feeb9b690950cace8"
uuid = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"
version = "1.11.0"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

[[deps.SymbolicIndexingInterface]]
deps = ["DocStringExtensions"]
git-tree-sha1 = "f8ab052bfcbdb9b48fad2c80c873aa0d0344dfe5"
uuid = "2efcf032-c050-4f8e-a9bb-153293bab1f5"
version = "0.2.2"

[[deps.SymbolicUtils]]
deps = ["AbstractTrees", "Bijections", "ChainRulesCore", "Combinatorics", "ConstructionBase", "DataStructures", "DocStringExtensions", "DynamicPolynomials", "IfElse", "LabelledArrays", "LinearAlgebra", "MultivariatePolynomials", "NaNMath", "Setfield", "SparseArrays", "SpecialFunctions", "StaticArrays", "TimerOutputs", "Unityper"]
git-tree-sha1 = "2f3fa844bcd33e40d8c29de5ee8dded7a0a70422"
uuid = "d1185830-fcd6-423d-90d6-eec64667417b"
version = "1.4.0"

[[deps.Symbolics]]
deps = ["ArrayInterface", "Bijections", "ConstructionBase", "DataStructures", "DiffRules", "Distributions", "DocStringExtensions", "DomainSets", "DynamicPolynomials", "Groebner", "IfElse", "LaTeXStrings", "LambertW", "Latexify", "Libdl", "LinearAlgebra", "LogExpFunctions", "MacroTools", "Markdown", "NaNMath", "PrecompileTools", "RecipesBase", "RecursiveArrayTools", "Reexport", "Requires", "RuntimeGeneratedFunctions", "SciMLBase", "Setfield", "SparseArrays", "SpecialFunctions", "StaticArrays", "SymbolicUtils", "TreeViews"]
git-tree-sha1 = "4d4e922e160827388c003a9a088a4c63f339f6c0"
uuid = "0c5d862f-8b57-4792-8d23-62f2024744c7"
version = "5.10.0"

    [deps.Symbolics.extensions]
    SymbolicsSymPyExt = "SymPy"

    [deps.Symbolics.weakdeps]
    SymPy = "24249f21-da20-56a4-8eb1-6a02cf4ae2e6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "598cd7c1f68d1e205689b1c2fe65a9f85846f297"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.TestItems]]
git-tree-sha1 = "42fd9023fef18b9b78c8343a4e2f3813ffbcefcb"
uuid = "1c621080-faea-4a02-84b6-bbd5e436b8fe"
version = "1.0.0"

[[deps.TimerOutputs]]
deps = ["ExprTools", "Printf"]
git-tree-sha1 = "f57facfd1be61c42321765d3551b3df50f7e09f6"
uuid = "a759f4b9-e2f1-59dc-863e-4aeb61b1ea8f"
version = "0.5.28"

    [deps.TimerOutputs.extensions]
    FlameGraphsExt = "FlameGraphs"

    [deps.TimerOutputs.weakdeps]
    FlameGraphs = "08572546-2f56-4bcf-ba4e-bab62c3a3f89"

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

[[deps.TreeViews]]
deps = ["Test"]
git-tree-sha1 = "8d0d7a3fe2f30d6a7f833a5f19f7c7a5b396eae6"
uuid = "a2a6695c-b41b-5b7d-aed9-dbfdeacea5d7"
version = "0.3.0"

[[deps.Tricks]]
git-tree-sha1 = "6cae795a5a9313bbb4f60683f7263318fc7d1505"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.10"

[[deps.TruncatedStacktraces]]
deps = ["InteractiveUtils", "MacroTools", "Preferences"]
git-tree-sha1 = "ea3e54c2bdde39062abf5a9758a23735558705e1"
uuid = "781d530d-4396-4725-bb49-402e4bee1e77"
version = "1.4.0"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unitful]]
deps = ["Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "242982d62ff0d1671e9029b52743062739255c7e"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.18.0"
weakdeps = ["ConstructionBase", "InverseFunctions"]

    [deps.Unitful.extensions]
    ConstructionBaseUnitfulExt = "ConstructionBase"
    InverseFunctionsUnitfulExt = "InverseFunctions"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "975c354fcd5f7e1ddcc1f1a23e6e091d99e99bc8"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.4"

[[deps.Unityper]]
deps = ["ConstructionBase"]
git-tree-sha1 = "25008b734a03736c41e2a7dc314ecb95bd6bbdb0"
uuid = "a7c27f48-0311-42f6-a7f8-2c11e75eb415"
version = "0.1.6"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Vulkan_Loader_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Wayland_jll", "Xorg_libX11_jll", "Xorg_libXrandr_jll", "xkbcommon_jll"]
git-tree-sha1 = "2f0486047a07670caad3a81a075d2e518acc5c59"
uuid = "a44049a8-05dd-5a78-86c9-5fde0876e88c"
version = "1.3.243+0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "EpollShim_jll", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "85c7811eddec9e7f22615371c3cc81a504c508ee"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+2"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "5db3e9d307d32baba7067b13fc7b5aa6edd4a19a"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.36.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Zlib_jll"]
git-tree-sha1 = "b8b243e47228b4a3877f1dd6aee0c5d56db7fcf4"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.13.6+1"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "7d1671acbe47ac88e981868a078bd6b4e27c5191"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.42+0"

[[deps.XZ_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "56c6604ec8b2d82cc4cfe01aa03b00426aac7e1f"
uuid = "ffd25f8a-64ca-5728-b0f7-c24cf3aae800"
version = "5.6.4+1"

[[deps.Xorg_libICE_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "326b4fea307b0b39892b3e85fa451692eda8d46c"
uuid = "f67eecfb-183a-506d-b269-f58e52b52d7c"
version = "1.1.1+0"

[[deps.Xorg_libSM_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libICE_jll"]
git-tree-sha1 = "3796722887072218eabafb494a13c963209754ce"
uuid = "c834827a-8449-5923-a945-d239c165b7dd"
version = "1.2.4+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "9dafcee1d24c4f024e7edc92603cedba72118283"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.8.6+3"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "e9216fdcd8514b7072b43653874fd688e4c6c003"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.12+0"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "807c226eaf3651e7b2c468f687ac788291f9a89b"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.3+0"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "89799ae67c17caa5b3b5a19b8469eeee474377db"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.5+0"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "d7155fea91a4123ef59f42c4afb5ab3b4ca95058"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.6+3"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "6fcc21d5aea1a0b7cce6cab3e62246abd1949b86"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "6.0.0+0"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "984b313b049c89739075b8e2a94407076de17449"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.8.2+0"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll"]
git-tree-sha1 = "a1a7eaf6c3b5b05cb903e35e8372049b107ac729"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.5+0"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "b6f664b7b2f6a39689d822a6300b14df4668f0f4"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.4+0"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "a490c6212a0e90d2d55111ac956f7c4fa9c277a6"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.11+1"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "c57201109a9e4c0585b208bb408bc41d205ac4e9"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.2+0"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "1a74296303b6524a0472a8cb12d3d87a78eb3612"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.17.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libX11_jll"]
git-tree-sha1 = "dbc53e4cf7701c6c7047c51e17d6e64df55dca94"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.2+1"

[[deps.Xorg_xcb_util_cursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_jll", "Xorg_xcb_util_renderutil_jll"]
git-tree-sha1 = "04341cb870f29dcd5e39055f895c39d016e18ccd"
uuid = "e920d4aa-a673-5f3a-b3d7-f755a4d47c43"
version = "0.1.4+0"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "ab2221d309eda71020cdda67a973aa582aa85d69"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.6+1"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "691634e5453ad362044e2ad653e79f3ee3bb98c3"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.39.0+0"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6dba04dbfb72ae3ebe5418ba33d087ba8aa8cb00"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.5.1+0"

[[deps.YAML]]
deps = ["Base64", "Dates", "Printf", "StringEncodings"]
git-tree-sha1 = "b46894beba6c05cd185d174654479aaec09ea6b1"
uuid = "ddb6d928-2868-570f-bddf-ab3f9cf99eb6"
version = "0.4.13"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "446b23e73536f84e8037f5dce465e92275f6a308"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.7+1"

[[deps.eudev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "gperf_jll"]
git-tree-sha1 = "431b678a28ebb559d224c0b6b6d01afce87c51ba"
uuid = "35ca27e7-8b34-5b7f-bca9-bdc33f59eb06"
version = "3.2.9+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6e50f145003024df4f5cb96c7fce79466741d601"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.56.3+0"

[[deps.gperf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0ba42241cb6809f1a278d0bcb976e0483c3f1f2d"
uuid = "1a1c6b14-54f6-533d-8383-74cd7377aa70"
version = "3.1.1+1"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "522c1df09d05a71785765d19c9524661234738e9"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.11.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "e17c115d55c5fbb7e52ebedb427a0dca79d4484e"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.2+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.libdecor_jll]]
deps = ["Artifacts", "Dbus_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pango_jll", "Wayland_jll", "xkbcommon_jll"]
git-tree-sha1 = "9bf7903af251d2050b467f76bdbe57ce541f7f4f"
uuid = "1183f4f0-6f2a-5f1a-908b-139f9cdfea6f"
version = "0.2.2+0"

[[deps.libevdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "141fe65dc3efabb0b1d5ba74e91f6ad26f84cc22"
uuid = "2db6ffa8-e38f-5e21-84af-90c45d0032cc"
version = "1.11.0+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "8a22cf860a7d27e4f3498a0fe0811a7957badb38"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.3+0"

[[deps.libinput_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "eudev_jll", "libevdev_jll", "mtdev_jll"]
git-tree-sha1 = "ad50e5b90f222cfe78aa3d5183a20a12de1322ce"
uuid = "36db933b-70db-51c0-b978-0f229ee0e533"
version = "1.18.0+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Zlib_jll"]
git-tree-sha1 = "068dfe202b0a05b8332f1e8e6b4080684b9c7700"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.47+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "490376214c4721cdaca654041f635213c6165cb3"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+2"

[[deps.mtdev_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "814e154bdb7be91d78b6802843f76b6ece642f11"
uuid = "009596ad-96f7-51b1-9f1b-5ce2d5e8a71e"
version = "1.1.6+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "63406453ed9b33a0df95d570816d5366c92b7809"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+2"
"""

# ╔═╡ Cell order:
# ╟─908af3d7-63ba-4e79-9311-786bce192079
# ╟─6afdd882-b89b-4bad-9aa4-cd4867551b92
# ╟─918409c6-896b-4395-b73e-25a52a550798
# ╟─02ef5c10-95ec-41b8-ba31-6f9ea8521106
# ╟─a82888b4-c842-4e15-9696-06a707547c32
# ╟─88dd0962-6bef-4451-8083-a898603ba7f6
# ╟─ec18f430-1b1c-4967-9689-6e2904e56ada
# ╟─a8f66490-b43e-484d-80cb-fa7c74370d70
# ╟─cc0a50bf-60ed-4291-a704-9b1095335ab3
# ╟─08413add-1c85-4922-a47a-66e5d4944a1d
# ╟─c75d7ce5-4250-447c-a8e6-4ca95edc2aeb
# ╟─ea0001c1-cfaa-432f-95a4-b3b4914e4fc5
# ╟─dd796fa6-fa31-4559-9855-f6ade6a6c510
# ╟─f45d46f4-9c7f-458a-a26a-429b0294e614
# ╟─5c1790e6-4b0d-41a3-9a73-a56cce53a4f5
# ╟─f289dbb7-29c9-4eac-a281-5bdf4612d1a6
# ╟─6fd06cfa-37c3-4e16-b3f5-15a8688fe51a
# ╟─7b3b504e-37af-4b62-a029-868f6f1dfdde
# ╟─a7d86d97-4e98-4f87-acce-92241e9b9d51
# ╟─7b21340d-e638-4581-afa9-878fc0d3842f
# ╟─fd55ba42-e17e-47f7-a629-1b0a3f2c2c74
# ╟─a039f988-8993-4538-bee9-d4fc6bb94aaf
# ╟─a3ea30b3-0e2a-407d-b5ba-e577e63f9e8f
# ╟─fd937762-0915-4655-846a-0e6fa735e239
# ╟─36dcfe6a-d9bc-448f-a359-620261eaa6df
# ╟─325d8c57-41d2-4fa8-843e-78c34dcfc341
# ╟─064bec79-f5e3-4841-ac6e-68fddcb9df34
# ╟─16691b2c-ae6d-4eb7-9f28-6cf6c66922b7
# ╟─c28338a5-bbb3-45c0-8a39-786264333d5f
# ╟─dd06f7c7-a85f-4ad4-a5d3-a0c1d5ddf884
# ╟─573a1b02-7269-4c3e-91c1-019ec3a5d358
# ╟─9059970a-e0e6-4228-b371-1e93d57f66d7
# ╟─46dd469b-2acd-4d8a-a112-9b550d27ced8
# ╟─d8518bca-9dde-496d-b9fc-5565019a0ef0
# ╟─957ee8fd-63d2-4363-a519-13bd73648e48
# ╟─1fb9b22a-61a4-4c4c-b1c2-71b27b303bc2
# ╟─7af69029-d39c-46ab-955c-22b43c0cb1e0
# ╟─f09162c1-f36c-404a-b342-10e9f9339d17
# ╟─eaf2cc1a-f844-4b00-897f-245207963a89
# ╟─86d5f4a4-12bc-40db-9afd-b26a3de633f9
# ╟─877544e1-cf7c-4f6e-a746-67e5f418611d
# ╟─1572d39d-dc9e-4b5a-95c6-53beeb32af17
# ╟─b89236fb-7775-4e16-93dc-bc9a025b3023
# ╟─36863f50-68b0-42bc-a038-e5d02c58e8c1
# ╟─ea3bf775-808e-42e1-85c6-7d432a44db41
# ╟─eeca76c4-491b-4197-8580-e4010df945f3
# ╟─affc0d38-2833-403b-8610-eb03d10f469d
# ╟─c0614c97-bd5e-440b-9381-0427f3758c8c
# ╟─499c26ba-8df5-4087-80de-a3efb5293f16
# ╟─f767e601-08da-436a-a4ea-fc92e18c1bec
# ╟─193a7b1e-5683-4cef-902e-ef351dd3e89d
# ╟─499b4667-111d-4408-8cb8-4de0d6182673
# ╟─38d6ab9e-3aa0-4890-b8a6-ae1bc3dd4d00
# ╟─28f20cfe-7439-4090-aa23-ec2257a9fc9c
# ╟─fc58d729-8594-4607-bf7f-0f730a3be9ac
# ╟─faa36c56-bd6b-45b7-89b6-1555a2515bfd
# ╟─af6007fc-39ac-401d-a03d-16fe39917951
# ╟─24b9edbe-88e6-4ede-bb59-5c32d8f1514c
# ╟─f67f535b-3d05-4bd6-a7bd-21556f4c41dc
# ╟─1ead6b3e-3e1c-49b0-a834-fd587b00c5a5
# ╟─1a1b54fd-61e3-4fd3-a3d7-77f015c9d0be
# ╟─9bcb3ff4-28ff-4525-94b8-38f6c6f07d9d
# ╟─f8884266-8ede-4dde-aa18-adc89f621157
# ╟─2b4d5107-68d5-40d5-93b5-67188c8e4e55
# ╟─67e46709-8850-463e-a0be-b0dafdce2751
# ╟─b9d8f2f3-f2b2-4f35-b792-df71e240d92a
# ╟─e715e9bb-a9cb-49d8-ac75-16e67a4667db
# ╟─62c5b08c-b574-4043-8bab-5493f2462dd7
# ╟─8b9ce2bc-f8a9-4cbf-8fd8-e0bf31dbbee9
# ╟─b527f54c-53ae-4aa6-a5f2-c61fa6633bd3
# ╟─6232d13a-c1f9-4df2-8549-e43f6fc4ed9f
# ╟─1895474c-022b-4efa-ab68-6e33564b22ed
# ╟─489823e8-1e5f-4493-a0c3-2dbbec842142
# ╟─ce1b65a1-847c-4808-bd18-0207562bc6de
# ╟─f742b185-773e-4aba-a894-9e1b91cafa2f
# ╠═8e14f37c-4095-4553-a08c-f100190d40bc
# ╠═a4500168-ea47-4f03-8c2e-e08901d82d2d
# ╠═07a6cf77-e119-4050-a109-3fa1377f3fdb
# ╠═46088004-6d59-4059-8536-b571810d8646
# ╠═e283e03a-b0f6-485a-94c7-93db9a5ddd40
# ╠═1055b847-6fa9-4f0d-924a-45d8b9d45ad0
# ╟─a66290bb-101f-4196-8cc8-1c05e949553b
# ╟─ed04f3b6-dcba-4d2c-b539-bf4d77ff33b3
# ╠═957ee6e2-25db-41c9-a5a9-8b8efb39e6ff
# ╟─add00c30-7aa9-47f9-ac3b-4a1e97e23d09
# ╟─ad197457-601d-494f-b058-70235391cdc8
# ╟─27ea92e4-041c-479c-aad4-5369370572a6
# ╟─afcdf710-cfed-4d7d-817d-cdf9932ebe8d
# ╟─2ce2824f-52b7-444e-950f-5370b4ba59e0
# ╟─22b1bb59-f0de-4888-9b9c-fbaf0fab773c
# ╠═9506fe42-d4a2-4055-8429-021ff5bebb8b
# ╠═53d07c05-a15a-450a-83c4-4da91dd5b6a5
# ╠═6fabb945-3626-452b-a471-4abcadbb9592
# ╠═228acf65-2f5b-4e45-9a7e-2bdef932105f
# ╟─3447169b-b41f-4b63-9251-ef6d14846b82
# ╠═e832133e-6b8a-4557-be97-6d54f2e1b6b3
# ╠═4ef6d842-457d-447b-b7c1-27ae00b10c4b
# ╠═8c1fc621-500f-484d-91d8-75e8d564ce9e
# ╠═577205fb-1ab3-4305-9add-042315b079c9
# ╠═5726299f-3857-4467-bea2-dceefb9ba7b7
# ╠═638a91bb-0157-4954-919e-c7368b531629
# ╠═459e2de0-afc8-4032-ad3c-72c53a55d270
# ╠═bb3048cc-6eab-48e7-85e1-d632f81369dc
# ╟─94835866-0c2a-49db-b537-aa31261348b6
# ╟─89e86e3a-674c-4c49-b59d-ddf09060e106
# ╠═b0e2f33c-bc5d-49ec-bcc5-47e4054eb7e8
# ╟─eab33b6a-482a-40c1-8120-f87fa31ba109
# ╠═6b4021c2-c4b3-4f82-9869-0aab827e6056
# ╟─138bc84e-5261-4120-ad95-871db9144692
# ╟─70c3206a-ef54-4fc7-a85c-d6725f577199
# ╟─a16a6f2d-1a2a-48ff-a303-e6f0c80a3289
# ╠═e498d0c5-104e-4db6-91fc-9562faa7dfb4
# ╠═f140a80d-1ec3-4a0c-b35b-1d117c3e7adc
# ╠═37e6add7-46c6-4ece-9b14-f2bafb66a8a1
# ╠═7f8e1d7e-b7a0-42f2-80ce-f0e98cdea9d2
# ╟─a9dc3572-5b3e-4a2e-8aed-1d7c82ee2acf
# ╟─e9b2fbfc-07ff-4276-916a-0d3d00676f55
# ╠═e7fef034-89aa-48b7-a046-7ad65967892d
# ╠═3c3bd174-ac9a-4fb6-8230-2540d6330aee
# ╟─7ac4238c-e7fe-4039-a89f-4f43fdb98063
# ╠═21458cb4-1b58-441d-9aec-cd14c59d9332
# ╟─bff77839-efac-488a-be60-da970266c860
# ╟─edef726b-0eb6-46b9-935e-c151977d15a0
# ╠═b61894d9-bdbd-4f9b-b4ec-a6dd555a5aec
# ╠═3819d633-4531-4053-b063-501c7060d7a5
# ╟─f8a8d46a-a4d9-42a0-a5f9-8ee04ccc15a9
# ╠═bfa46a2d-36ad-41c3-befb-053fa5c99b23
# ╠═4449508f-df28-4d2d-aa14-46dd0902de46
# ╟─e500f340-b53c-46b2-a3fd-46d563c86df9
# ╟─9425a024-fe6d-4cc8-b2ab-25e6a20bf4ed
# ╟─fbb026ed-d295-44dc-93c5-1455f3ffd848
# ╟─e8bddc9f-3b27-4dd5-815b-47bcba7c0845
# ╟─7708599d-7236-483b-8745-975476f72d9e
# ╠═c6ca8823-f8c3-49c8-acb9-f2ef56f176e2
# ╟─c3b6d389-52ac-421d-ab2a-d1cbc13c970c
# ╠═ac7408c8-c366-46ab-9515-93bc55dda4ac
# ╠═ee8b8ad6-70d9-49d5-b2c0-1be93da8255c
# ╠═6782cd70-71dd-4504-a6b6-e4b0da3d9126
# ╟─772d1148-5181-425e-b2ca-365aa2b5c2a4
# ╟─e6429073-ffe9-4153-b90f-e55b27e2817d
# ╟─42dd87b3-b9a2-4f57-bcac-3a191ab76380
# ╠═4cd408a5-f78a-4393-9ffe-61598f17f326
# ╠═aa3e7729-3b2e-4824-92af-09d15894b521
# ╠═988269f3-1e76-4cc3-88a9-392620efc000
# ╟─259910c4-5af2-44c7-a77e-3fd0de1d86e0
# ╟─c9fe918e-6910-41f8-9042-a35e7fe1fd00
# ╠═f3b572ef-b338-4b12-b1b8-08364fabf487
# ╠═16af7868-f4fe-4720-98f7-095f96b0ac7a
# ╠═b676581c-a8ec-44ae-a4d3-31efd57ef445
# ╠═29b05d28-662a-4413-ba9c-bd45e9e50135
# ╠═f0d0773c-e933-487d-939d-5bba8e886fb5
# ╠═cf12ffe3-42b0-43f7-bf2a-bc13ea12ce05
# ╠═8a1c1942-ec43-452f-9b35-0a99587b26d8
# ╟─9c024d61-b080-4d33-8bdf-d887daad54a6
# ╠═18a34595-d7ee-4131-939f-a48f197e87f1
# ╟─5a13d6f6-cb6b-4e2b-b190-0f9bdfaf3098
# ╟─89c1d82b-c661-42c4-b254-974d673cf9b7
# ╟─ee3c9d50-72e2-4f11-b486-1275d20d5c72
# ╟─eb5f8c91-b636-46ff-bd28-023116954829
# ╟─67abb3db-2e1e-4edf-99c2-f17f44a47b9f
# ╟─c5839b75-d47f-4545-8b21-5d15b0f39e6f
# ╟─c531ed94-708a-4ea3-a227-bc6ed79761c8
# ╟─d5059a11-fbb1-4d01-9931-6de4e297768c
# ╟─5b605cde-da9f-447c-b1e5-15a78e669701
# ╟─8b18afe0-c62a-4cc3-8b41-1ba527309484
# ╟─a3771e8a-1b07-4d31-b4ad-19e3ede8ffaa
# ╟─6097217e-c193-4877-af31-6430636988bf
# ╟─7e3a8d7f-2c99-4d56-b78e-ba68cf400fbe
# ╟─65c2d1ed-6fd1-47f1-b51b-269c7941ae2f
# ╟─f8a0b5ec-1623-4f25-b6dc-c859dab34037
# ╟─683dd9c7-a40e-4702-8d6b-943d515117f1
# ╟─782b4b45-8f00-4805-b70f-6a527d5dba60
# ╟─f6bf0d32-8524-4a7c-8458-63ca4ff14f81
# ╟─1010b109-e5e3-4f33-b0f7-b5c5ece41a92
# ╠═1c2ca520-a2f3-48f4-a983-681c762c1ea9
# ╟─153164ac-1196-48b1-a484-5be9f79e6088
# ╠═4cbb9bcb-db63-4771-bd00-4cc109a8c46c
# ╠═90257139-4107-4b33-95f9-ef11524b67a2
# ╟─fb7498d1-1003-48ee-a557-a3911038058e
# ╠═b58c5deb-2cef-4658-8bd5-cacda65e620b
# ╠═f0fb6911-536c-40f7-a87f-822a90b6efe9
# ╟─96a1ec6c-e21d-40e2-991b-3838c6085ea4
# ╠═f3b1e50a-8e2d-42de-9f1a-b3ae27bb8769
# ╠═e28bda7b-2dde-4387-b9c6-ca11ef104999
# ╟─629fab7f-c134-4127-a2c4-7f84d485f655
# ╟─5d58433f-e8b0-46ed-ad11-71ed41de19e5
# ╠═31b0876b-5295-4d83-b5cf-6109ec2b603e
# ╟─50bb9586-4c61-48ff-bc38-2bfa7e40d0c1
# ╟─e4907d4e-9d1f-48a0-a11b-0ac6479b7b62
# ╠═9541bf3c-8809-44ba-bcde-0794c164d7d5
# ╟─d1bfc038-6c04-4bb6-99f6-d098e160b3e5
# ╠═b585c9d5-6bf3-4635-a873-9d9ef94f9d08
# ╠═2f15f153-4113-4c20-8a6e-4117751d616c
# ╟─d68e7a74-de79-45cf-adf5-f1dd6a003976
# ╠═beda159f-b853-43c7-a087-4d182965ce40
# ╠═72ba1d12-43be-4910-b16f-9296a556be95
# ╠═e6610f5a-e3c1-4954-b7f1-86ecedc045db
# ╟─b5f1432a-6c49-4325-90a3-a1acb91f9862
# ╟─787b287f-1738-40e0-852d-a48bf4e5e14e
# ╟─0c55f8fe-29b6-493c-8a73-8ab5efc09409
# ╟─4684f800-6da4-4f02-9aca-e2816b5afdb4
# ╟─e4a55ceb-b632-421d-a525-524350cf7b24
# ╟─063869ae-0d30-4626-9491-bcc6faa3c760
# ╟─499176b7-20ab-4ca1-a3e5-c33b34c59c35
# ╟─98688cd7-a0da-4ed7-a6d4-83c62a4904ee
# ╟─75a7cf61-10c7-4788-8e18-af5a28112c0d
# ╟─b49ef5bd-543c-4841-bb6b-40a588173efe
# ╟─93b29b75-24f8-494a-a1f8-48b7d5a44b79
# ╟─1edf689e-2119-4007-be02-eb7aae43db3b
# ╟─6426c5be-4336-4705-b37d-426d748f420d
# ╟─cc87181a-5b6f-4d02-bb11-0698530478b9
# ╟─8974d32f-4a0c-4ccb-b6c6-ff59b672c9a4
# ╟─b62b5753-fb75-493e-ae37-75331384a747
# ╟─1665a02f-6053-4a60-8cff-70bd0fe5dc93
# ╟─4be1270c-be70-4bdd-a015-ad92ff765124
# ╟─982de518-2ab6-4299-8624-c1074a880082
# ╟─a47cced1-e43f-4c17-85b1-20c65df7ff32
# ╟─a0312030-1ade-42d3-9a5c-332ac0cffc7a
# ╟─31ce0ecf-69ea-41c6-970f-7117d8399ad2
# ╟─d7987ebe-ad03-4b64-b975-572c5f5cbcdb
# ╠═3a377bf4-518f-46ea-bb18-d433f0a09d04
# ╟─229c8602-65b8-4ddc-8994-1d0e9dc576bd
# ╠═0e0fac4b-02de-4ec1-b54f-b78a68aaa18e
# ╟─01c815ae-f018-425a-995d-fda5892d7ed2
# ╟─22d20ff6-8cd1-4699-9e5d-303f820c7db1
# ╟─18214f16-a66c-421b-8254-23180de50ee9
# ╟─68bdad76-5be7-4824-8c8b-7412fd5ef7a3
# ╟─a002b72e-b1ec-4c82-8765-2c1470176d47
# ╟─d213be62-11c7-4574-bd94-2714af1712ac
# ╟─302d0702-02c7-4d1d-b0db-9910fa0c871a
# ╟─ee0f10e1-1e35-47b4-b2bb-2b44d37e626c
# ╟─48ca2c1f-cc8e-4268-9f25-2efc655ddfac
# ╟─bf54a867-1338-4305-85b7-f39b7db066e9
# ╠═2ea84a40-f68a-465e-bf76-e8edb2573429
# ╠═d666646f-a1b9-4ca6-8ef4-15557312cc8c
# ╟─d604a886-8c56-49b6-8ea4-601ed10e48ed
# ╠═7afd6c30-b290-45ad-8ddf-7c28a4b34872
# ╠═73ebd870-8e95-4dee-8e63-3cfcb9018e08
# ╠═b3571522-6d85-4ea9-8a7c-b3fac6b600c3
# ╠═88b5be8c-8b2c-4b04-9f91-c7fe5929ddc2
# ╠═962eb933-3d01-41ae-898d-2e97553ffa6b
# ╠═8e362a49-fdfe-499d-abf1-40005f25aec8
# ╟─13328cb8-56c3-47bf-a375-0a5758492ebd
# ╟─82c6dfe8-080a-4b8d-ae80-a6bfaafd3281
# ╟─d20b5ccc-280a-47fe-bf2d-5ece3bf370d7
# ╟─cb166e16-d822-4537-a1a2-d242658912ae
# ╟─46dd0c2c-9460-4d9f-9f8b-df5dabd4daf1
# ╟─b49f8963-6f6c-423b-8559-3bf538f7ae88
# ╟─b9b896dd-5c35-4711-8885-71af1547d644
# ╟─98048ed6-a03c-400d-a6a2-3172caa418c7
# ╟─cb7ea381-1732-4578-8bf8-1d8839350371
# ╟─2b3d27a3-9814-4a18-b8e0-96fe8cde6f63
# ╟─7bdc98d0-86ff-431d-95ae-201da3ca8a83
# ╟─05c088e3-572b-4bcd-aa60-5a8265dacfd7
# ╟─109b6045-fdf3-41eb-977c-a6d5717cee8b
# ╟─f086b824-bc3f-4d72-8878-7a8e3c8da42d
# ╟─befe57d0-5c74-4d16-9875-d3a822dadbba
# ╟─2345567b-3d2d-4b9c-bac6-2d753280fb48
# ╟─e9cf406d-2f81-4bb1-98f7-b9b6d118fd08
# ╟─ff8beb7f-a458-4b24-bd6b-d4667f88d99b
# ╟─1853271a-d192-41bd-9bbe-b68237748ff4
# ╟─2b80967a-7dda-4bc9-81da-f236f6b92eaf
# ╟─0031e69a-5463-4cae-84f7-357414bb7ee8
# ╟─1dcc351e-0056-4372-bd4f-e8e7d15227de
# ╟─ec0ed1b5-db84-45c0-99a7-b2d0b99ef865
# ╟─3d776522-9821-475c-a45d-88d28abc6d13
# ╟─6f4f76a3-8413-4e77-8db9-0073232bfa1c
# ╟─e8c8ad53-6430-4391-96da-71b31ed8e4c2
# ╟─f296fdb3-ae28-434c-9eac-64bb5603758d
# ╟─3c6e7597-5ae6-45b1-97e2-b1e535d446d4
# ╟─08e40303-fe22-4c5b-a54b-66bcb3eaad2a
# ╟─89067140-1253-45a5-807d-6e6f8b6c65bc
# ╟─7a18486a-847a-417b-a28e-463df434640e
# ╟─2e423841-4bdc-4a60-ac97-446abe726217
# ╟─3b267f71-8ed7-44f4-a653-918ecab5f0d3
# ╟─3e5557d3-4e9f-488b-8725-b396a02fc18a
# ╟─30d89ed0-f1a5-4537-9085-b133de9c81a4
# ╟─4093f40d-b6ff-4bfe-ba44-02c23dba816c
# ╟─f1c177e3-52c8-444e-b24e-9ff149592931
# ╟─9c250234-9e87-4862-9ad3-7e5d7907f7f4
# ╟─beb4699b-50e6-4e04-b227-f33c87defe46
# ╟─a6cc9772-9856-40d5-bd7e-30945b161719
# ╟─bab7ce3d-4cee-487a-b5d6-cd08f8c1145b
# ╟─0a573998-6a80-4dad-99cb-6d9d56745b10
# ╟─9794b531-30a4-46a3-97d2-443e6289ba6d
# ╟─ad25926a-31e8-48c2-b22e-f96009a4872a
# ╟─0912c886-2a33-4fce-a805-7829f7a143e8
# ╟─4a5ba23a-df28-4f34-9f24-ae1a07c6e5c0
# ╠═8edb1e45-934a-453c-a5e2-4e5a7847767a
# ╟─819b644e-a7a0-4d49-83d4-01c41653eea2
# ╠═dbc5dedf-cc89-4eb2-96dc-9fbeec25025d
# ╠═e1c0635c-c469-4ea6-845f-94bb7a58cac3
# ╠═0c32f263-55ab-40d2-a626-1825109d2665
# ╟─91592a94-32c7-4c60-90bb-981643e473d8
# ╟─695c8e1b-e9f7-4aa9-9543-5ed69227e7ab
# ╟─8b8af85b-8327-4f3b-9134-4b6d17d69ad4
# ╠═d44835c4-ab05-4258-a841-a55521f8cec9
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
