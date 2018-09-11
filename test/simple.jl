using Test
using GridWorlds
using POMDPModelTools

let
    problem = SimpleGridWorld()

	@test n_states(problem) == 100
	@test n_actions(problem) == 4

	s = Vec2(1,1)
	@test GridWorlds.inbounds(problem, s) == true

	T = transition(problem, s, :down)
	@test typeof(T) <: POMDPModelTools.SparseCat
	@test T.vals == [ Vec2(1,2), Vec2(1,1), Vec2(1,1), Vec2(2,1)]
	@test T.probs ≈ [ 0.1, 0.7, 0.1, 0.1 ]

	@test isterminal(problem, first(problem.terminate_in) ) == true

	@test reward(problem, Vec2(4,3), :up) == -10.

	for s in states(problem)
		for a in actions(problem)
			T = transition(problem, s, a)
			@assert sum(T.probs) ≈ 1.00
		end
	end
end
