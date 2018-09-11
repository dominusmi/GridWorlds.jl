module GridWorlds
using Parameters
using POMDPs
using StaticArrays: SVector
using POMDPModelTools: SparseCat

using Random: AbstractRNG

import POMDPs: initialstate, discount, isterminal
import POMDPs: actions, n_actions, actionindex
import POMDPs: states, n_states, stateindex, transition
import POMDPs: initialstate, initialstate_distribution
import POMDPs: reward
import POMDPs: convert_a

const Vec2 = SVector{2,Int}
const StateTypes = Vec2

# TODO: action/state-action reward
# abstract type Reward end
# abstract type StateReward <: Reward end
# abstract type StateActionReward <: Reward end
# TODO: parametrised StateTypes?

abstract type GridWorld <: MDP{StateTypes, Symbol} end

include("General.jl")
include("SimpleGridWorld.jl")
include("DiagonalGridWorld.jl")

export
    Vec2,
    GridWorld,
    SimpleGridWorld,
    DiagonalGridWorld


export
    actions,
    states,
    n_actions,
    n_states,
    actionindex,
    stateindex,
    transition,
    reward,
    isterminal

end
