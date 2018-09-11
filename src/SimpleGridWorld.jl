@with_kw struct SimpleGridWorld <: GridWorld
    size::Tuple{Int, Int}           = (10,10)
    rewards::Dict{Vec2, Float64}    = Dict(Vec2(4,3)=>-10.0, Vec2(4,6)=>-5.0, Vec2(9,3)=>10.0, Vec2(8,8)=>3.0)
    terminate_in::Set{Vec2}         = Set((Vec2(4,3), Vec2(4,6), Vec2(9,3), Vec2(8,8)))
    tprob::Float64                  = 0.7
    discount::Float64               = 0.95
end

function POMDPs.states(mdp::GridWorld)
    vec(StateTypes[Vec2(x, y) for x in 1:mdp.size[1], y in mdp.size[2]])
end

POMDPs.actions(mdp::SimpleGridWorld) = SVector(:up, :down, :left, :right)
POMDPs.n_states(mdp::SimpleGridWorld) = prod(mdp.size)
POMDPs.n_actions(mdp::SimpleGridWorld) = 4

function POMDPs.actionindex(mdp::SimpleGridWorld, a::Symbol)
    aind = Dict(:up=>1, :down=>2, :left=>3, :right=>4)
    aind[a]
end

function directions(mdp::SimpleGridWorld)
    Dict(:up=>Vec2(0,1), :down=>Vec2(0,-1), :left=>Vec2(-1,0), :right=>Vec2(1,0))
end


inbounds(mdp::GridWorld, nb::Vec2) = ( 0 < nb[1] < mdp.size[1] ) && ( 0 < nb[2] < mdp.size[2] )


POMDPs.convert_a(::Type{A}, a::Symbol, mdp::SimpleGridWorld) where A<:AbstractArray = convert(A, SVector(actionindex(mdp)[a]))
POMDPs.convert_a(::Type{Symbol}, a::AbstractArray, mdp::SimpleGridWorld) = actions(mdp)[first(a)]
