# GridWorlds.jl

This package provides a way to customise GridWorlds-like MDPs. It is based on the [POMDPs.jl](https://github.com/JuliaPOMDP/POMDPs.jl) generic MDP framework.
Currently, solvers are not available, since they're in the process of being upgraded to `Julia 0.7`.

## Simple Usage

```julia
  # Instantiate with default values, 10x10 grid
  mdp = GridWorld() 
  # Pick a state
  s = Vec2(2,1)
  # Find the transition probability distribution for move ":up"
  transition(mdp, s, :up)
```
## State Structure

The type `GridWorld` is based around the use of a grid, where states are defined by their 2D cartesian coordinate (`Vec2`), as well as _state type_, which has transition directions associated to it. When instantiating a `GridWorld` structure, the default state type is chosen through the notation `GridWorld{StateType}(...)`. The default constructor `GridWorld()` is equivalent to `GridWorld{SimpleGWState}`

`SimpleGWState` is one of the two provided state-types, together with `DiagonalGWState`. The former allows for the movements `:up, :down, :left, :right`, whereas the latter allows 8 movements, `:n, :nw, :w, :sw, :s, :se, :e, :ne` (north, north-west..). 

### Customised State Transitions

New state-type are very easily created. Suppose you want to make a state that will force the agent to the left. This can be simply done as follows:

```julia
# Create new state type. Note: MUST INHERIT FROM AbstractGWState
abstract type LeftGWState <: AbstractGWState end

# Manually import directions functions, which returns a dictionary associating an action to the direction.
import GridWorlds: directions

function directions(mdp::GridWorld{SimpleGWState}, t::Type{LeftGWState})
  # Make all the directions go left, i.e. move (x,y) = (-1,0)
	Dict(:up => Vec2(-1,0), :down => Vec2(-1,0), :left => Vec2(-1,0), :right => Vec2(-1,0))
end
```


## TODO
- Allow for both state-action and state reward (only the latter currently implemented)
- Generate macros for customised action and their movement

### Collaborators are highly welcome!
