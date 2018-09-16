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
const StateType = Vec2

abstract type AbstractGWState end
abstract type SimpleGWState <: AbstractGWState end
abstract type DiagonalGWState <: AbstractGWState end

# TODO: action/state-action reward
# abstract type Reward end
# abstract type StateReward <: Reward end
# abstract type StateActionReward <: Reward end
# TODO: parametrised StateTypes?

abstract type AbstractGridWorld <: MDP{AbstractGWState, Union{Symbol,Integer} } end

include("General.jl")
include("SimpleGridWorld.jl")
include("DiagonalGridWorld.jl")

export
    Vec2,
	AbstractGWState,
	SimpleGWState,
	DiagonalGWState,
	AbstractGridWorld,
	GridWorld

export
    actions,
    states,
    n_actions,
    n_states,
    actionindex,
    stateindex,
    transition,
    reward,
    isterminal,
	state_type,
	directions

end
