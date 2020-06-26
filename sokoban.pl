:-include(game).

solve(Problem, Solution):-
  Problem = [Tops, Rights, Boxes, Solutions, sokoban(Sokoban)],
  abolish_all_tables,
  retractall(top(_,_)),
  findall(_, ( member(P, Tops), assert(P) ), _),
  retractall(right(_,_)),
  findall(_, ( member(P, Rights), assert(P) ), _),
  retractall(solution(_)),
  findall(_, ( member(P, Solutions), assert(P) ), _),

  retractall(initial_state(_,_)),
  findall(Box, member(box(Box), Boxes), BoxLocs),
  assert(initial_state(sokoban, state(Sokoban, BoxLocs))),
  solve_problem(Solution).


solve_problem(Solution) :-
  initial_state(sokoban, Initial),
  search(Initial, [Initial], Solution).

search(State, _, []) :-
  final_state(sokoban, State).

search(State, VisitedStates, ResultMoves) :-
  movement(State, Move, SokobanMoves),
  update(State, Move, NewState),
  \+ member(NewState, VisitedStates),
  search(NewState, [NewState|VisitedStates], Moves),
  append(SokobanMoves, [Move|Moves], ResultMoves).


