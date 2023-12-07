using MyJuliaIntroDocs
using Documenter

DocMeta.setdocmeta!(MyJuliaIntroDocs, :DocTestSetup, :(using MyJuliaIntroDocs); recursive=true)

const liveserver = "liveserver" in ARGS

if liveserver
    using Revise
    Revise.revise()
end

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
    pages = [
        "Talk 2 neurones" => "talk.md",
        # "First things first" => "index.md",
        # "Get Started" => "GetStarted.md",
        # "Get Help" => "FAQ.md",
        # "Get Packages" => "packages.md",
        # "Scientific computing" => "ScientificComputing.md",
    ],
)

deploydocs(;
    repo="github.com/dmetivie/MyJuliaIntroDocs.jl",
    devbranch="master",
)
