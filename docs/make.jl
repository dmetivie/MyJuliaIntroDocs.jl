using MyJuliaIntroDocs
using Documenter

DocMeta.setdocmeta!(MyJuliaIntroDocs, :DocTestSetup, :(using MyJuliaIntroDocs); recursive=true)

makedocs(;
    modules=[MyJuliaIntroDocs],
    authors="David Métivier <david.metivier@inrae.fr>",
    repo="https://github.com/dmetivie/MyJuliaIntroDocs.jl/blob/{commit}{path}#{line}",
    sitename="MyJuliaIntroDocs.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://dmetivie.github.io/MyJuliaIntroDocs.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/dmetivie/MyJuliaIntroDocs.jl",
    devbranch="master",
)
