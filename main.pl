%:- [mazes/maze1].
:- [mazes/maze2].


% movement in the maze 
move(pos(_,_),up).
move(pos(_,_),down).
move(pos(_,_),left).
move(pos(_,_),right).

% update functionality
changePos(pos(X,Y),up,pos(X,Y_new)) :- Y_new is Y+1.
changePos(pos(X,Y),down,pos(X,Y_new)) :- Y_new is Y-1.
changePos(pos(X,Y),right,pos(X_new,Y)) :- X_new is X+1.
changePos(pos(X,Y),left,pos(X_new,Y)) :- X_new is X-1.

% check if the move is valid
valid(pos(X,Y)) :-
    mazeSize(X_max,Y_max),
    X >= 1,
    X =< X_max,
    Y >= 1,
    Y =< Y_max,
    \+wall(X,Y).

% depth first search
dfs(Position,_,[]) :-
    goal(Position).
dfs(Position,Visited,[Move,Path]) :-
    move(Position,Move),
    changePos(Position,Move,Next),
    valid(Next),
    \+member(Next,Visited),
    print(Next),
    dfs(Next,[Next|Visited],Path).

solve_dfs(Path) :-
    start(Position),
    dfs(Position,[Position],Path).


id_dfs(Path):-
    start(Position),
    id_dfs(Position,1,[Position],Path).
id_dfs(Position,Depth,Visited,Path):-
    goal(Position),
    write('Goal is: '),
    write(Position), nl,
    write('Depth is: '),
    print(Depth), nl,
    write('Visited: '),
    print(Visited),
    Path = Visited.
id_dfs(Position,Depth,Visited,Path):-
    Depth < 100,
    Depth_new is Depth+1,
    move(Position,Move),
    changePos(Position,Move,Next),
    valid(Next),
    \+member(Next,Visited),
    id_dfs(Next,Depth_new,[Next|Visited],Path).













