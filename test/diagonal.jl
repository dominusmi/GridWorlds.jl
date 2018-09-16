using Test
using GridWorlds
using POMDPModelTools

let
	problem = GridWorld{DiagonalGWState}()

	@test typeof(problem) == GridWorld{DiagonalGWState}

	@test n_states(problem) == 100
	@test n_actions(problem) == 8

	s = Vec2(1,1)
	@test GridWorlds.inbounds(problem, s) == true

	T = transition(problem, s, :n)
	@test typeof(T) <: POMDPModelTools.SparseCat
	@test T.vals == [ Vec2(1,2), Vec2(1,1), Vec2(1,1), Vec2(1,1), Vec2(1,1), Vec2(1,1), Vec2(2,1), Vec2(2,2)]
	@test T.probs ≈ [ 0.7, 0.3/7, 0.3/7, 0.3/7, 0.3/7, 0.3/7, 0.3/7, 0.3/7 ]

	@test isterminal(problem, first(problem.terminate_in) ) == true

	@test reward(problem, Vec2(4,3), :n) == -10.
	@test reward(problem, Vec2(4,2), :n) == 0.


	for s in states(problem)
		for a in actions(problem)
			T = transition(problem, s, a)
			@assert sum(T.probs) ≈ 1.00
		end
	end
end
