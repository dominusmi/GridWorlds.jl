
POMDPs.actions(mdp::GridWorld{SimpleGWState}) = SVector(:up, :down, :left, :right)
POMDPs.n_states(mdp::GridWorld{SimpleGWState}) = prod(mdp.size)
POMDPs.n_actions(mdp::GridWorld{SimpleGWState}) = 4

""" returns the index corresponding to a 'symbolic' action """
function POMDPs.actionindex(mdp::GridWorld{SimpleGWState}, a::Symbol)
    aind = Dict(:up=>1, :down=>2, :left=>3, :right=>4)
    aind[a]
end

""" Returns dictionary connecting action to the 2D vector movement it represents """
function directions(mdp::GridWorld{SimpleGWState})
    Dict(:up=>Vec2(0,1), :down=>Vec2(0,-1), :left=>Vec2(-1,0), :right=>Vec2(1,0))
end
