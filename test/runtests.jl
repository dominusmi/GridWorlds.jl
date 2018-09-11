using Test
using GridWorlds

@testset "SimpleGridWorld" begin
    include("simple.jl")
end

@testset "DiagonalGridWorld" begin
    include("diagonal.jl")
end
