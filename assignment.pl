%:- [mazes/maze1].
:- [mazes/maze2].


% movement in the maze 
move(pos(_,_),up).
move(pos(_,_),down).
move(pos(_,_),left).
move(pos(_,_),right).

% update functionality
update(pos(X,Y),left,pos(X_new,Y)) :- X_new is X-1.
update(pos(X,Y),right,pos(X_new,Y)) :- X_new is X+1.
update(pos(X,Y),down,pos(X,Y_new)) :- Y_new is Y-1.
update(pos(X,Y),up,pos(X,Y_new)) :- Y_new is Y+1.

% check if the move is valid
legal(pos(X,Y)) :-
    mazeSize(X_max,Y_max),
    X >= 1,
    X =< X_max,
    Y >= 1,
    Y =< Y_max.


% depth first search
dfs(Problem,State,_,[]) :-
    goal(Problem,State).
dfs(Problem,State,Visited,[Move,Path]) :-
    move(State,Move),
    update(State,Move,Next),
    legal(Next),
    \+member(Next,Visited),
    print(Next),
    dfs(Problem,Next,[Next|Visited],Path).

solve_dfs(Problem,Path) :-
    start(Problem,State),
    dfs(Problem,State,[State],Path).


