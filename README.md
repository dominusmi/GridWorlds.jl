# GridWorlds.jl

This package provides a way to customise GridWorlds-like MDPs. It is based on the [POMDPs.jl](https://github.com/JuliaPOMDP/POMDPs.jl) generic MDP framework.

Currently, solvers are not available, since they're in the process of being upgraded to `Julia 0.7`.

## Usage

The package comes with two pre-built MDPs, `SimpleGridWorld`, and `DiagonalGridWorld`. The former allows for 4 base directions, `:up, :down, :left, :right`, whereas the latter for 8, `:n, :nw, :w, :sw, :s, :se, :e, :ne` (north, north-west..).

Example for simple actions:
```julia
  # Instantiate with default values, 10x10 grid
  mdp = SimpleGridWorld() 
  # Pick a state
  s = Vec2(2,1)
  # Find the transition probability distribution for move ":up"
  transition(mdp, s, :up)
```

## TODO
- Allow for both state-action and state reward (only the latter currently implemented)
- Generate macros for customised action and their movement
- Allow for further customisable transitioning

### Collaborators are highly welcome!
