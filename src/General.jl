################################################
### Defines generic functions for GridWorlds ###
################################################

POMDPs.discount(mdp::GridWorld) = mdp.discount
POMDPs.stateindex(mdp::GridWorld, s::Vec2) = LinearIndices(mdp.size)[s...]
POMDPs.reward(mdp::GridWorld, s::Vec2, a::Symbol) = get(mdp.rewards, s, 0.0)


POMDPs.initialstate_distribution(mdp::GridWorld) = uniform_belief(mdp)
POMDPs.initialstate(mdp::GridWorld, rng::AbstractRNG) = Vec2(rand(rng, 1:mdp.size[1]), rand(rng, 1:mdp.size[2]))
POMDPs.isterminal(mdp::GridWorld, s::Vec2) = s ∈ mdp.terminate_in
inbounds(mdp::GridWorld, nb::Vec2) = ( 0 < nb[1] < mdp.size[1] ) && ( 0 < nb[2] < mdp.size[2] )

POMDPs.convert_a(::Type{A}, a::Symbol, mdp::GridWorld) where A<:AbstractArray = convert(A, SVector(actionindex(mdp)[a]))
POMDPs.convert_a(::Type{Symbol}, a::AbstractArray, mdp::GridWorld) = actions(mdp)[first(a)]

# If directions(mdp,s) is not overloaded, it will automatically dispatch to
# its non-state dependent version
directions(mdp::GridWorld, s::Vec2) = directions(mdp::GridWorld)

"""
    Returns a Categorical sparse probability distribution over the set of possible
    future states given current state s, and action a.
"""
function POMDPs.transition(mdp::GridWorld, s::Vec2, a::Symbol)
    dir = directions(mdp, s)
    if s in mdp.terminate_in
        return SparseCat([s], [1.0])
    end

    neighbors = map(actions(mdp)) do act
        nb = s+dir[act]
        if !inbounds(mdp, nb)
            # If not inbounds, don't move
            nb = s
        end
        nb
    end

    probs = map(actions(mdp)) do act
        if act == a
            return mdp.tprob # probability of transitioning to the desired cell
        else
            return (1.0 - mdp.tprob)/( length(dir)-1 ) # probability of transitioning to another cell
        end
    end

    return SparseCat(neighbors, probs)
end
