@with_kw struct DiagonalGridWorld <: GridWorld
    size::Tuple{Int, Int}           = (10,10)
    rewards::Dict{Vec2, Float64}    = Dict(Vec2(4,3)=>-10.0, Vec2(4,6)=>-5.0, Vec2(9,3)=>10.0, Vec2(8,8)=>3.0)
    terminate_in::Set{Vec2}         = Set((Vec2(4,3), Vec2(4,6), Vec2(9,3), Vec2(8,8)))
    tprob::Float64                  = 0.7
    discount::Float64               = 0.95
end

function POMDPs.states(mdp::GridWorld)
    vec(StateTypes[Vec2(x, y) for x in 1:mdp.size[1], y in mdp.size[2]])
end

POMDPs.actions(mdp::DiagonalGridWorld) = SVector(:n, :nw, :w, :sw, :s, :se, :e, :ne)
POMDPs.n_states(mdp::DiagonalGridWorld) = prod(mdp.size)
POMDPs.n_actions(mdp::DiagonalGridWorld) = 8
POMDPs.discount(mdp::DiagonalGridWorld) = mdp.discount

""" returns the index corresponding to a 'symbolic' action """
function POMDPs.actionindex(mdp::DiagonalGridWorld, a::Symbol)
    aind = Dict(:n=>1, :nw=>2, :w=>3, :sw=>4, :s=>5, :se=>6, :e=>7, :ne=>8)
    aind[a]
end

""" Returns dictionary connecting action to the 2D vector movement it represents """
function directions(mdp::DiagonalGridWorld)
    Dict(:n=>Vec2(0,1), :nw=>Vec2(-1,1), :w=>Vec2(-1,0), :sw=>Vec2(-1,-1), :s=>Vec2(0,-1), :se=>Vec2(1,-1), :e=>Vec2(1,0), :ne=>Vec2(1,1))
end
