
POMDPs.actions(mdp::GridWorld{DiagonalGWState}) = SVector(:n, :nw, :w, :sw, :s, :se, :e, :ne)
POMDPs.n_states(mdp::GridWorld{DiagonalGWState}) = prod(mdp.size)
POMDPs.n_actions(mdp::GridWorld{DiagonalGWState}) = 8

""" returns the index corresponding to a 'symbolic' action """
function POMDPs.actionindex(mdp::GridWorld{DiagonalGWState}, a::Symbol)
    aind = Dict(:n=>1, :nw=>2, :w=>3, :sw=>4, :s=>5, :se=>6, :e=>7, :ne=>8)
    aind[a]
end

""" Returns dictionary connecting action to the 2D vector movement it represents """
function directions(mdp::GridWorld{DiagonalGWState})
    Dict(:n=>Vec2(0,1), :nw=>Vec2(-1,1), :w=>Vec2(-1,0), :sw=>Vec2(-1,-1), :s=>Vec2(0,-1), :se=>Vec2(1,-1), :e=>Vec2(1,0), :ne=>Vec2(1,1))
end
