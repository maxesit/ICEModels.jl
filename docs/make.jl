using ICEModels
using Documenter

DocMeta.setdocmeta!(ICEModels, :DocTestSetup, :(using ICEModels); recursive=true)

makedocs(;
    modules=[ICEModels],
    authors="Marko Polic mpolic2000@gmail.com",
    repo="https://github.com/maxesit/ICEModels.jl/blob/{commit}{path}#{line}",
    sitename="ICEModels.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://maxesit.github.io/ICEModels.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/maxesit/ICEModels.jl",
    devbranch="main",
)
