%:- [mazes/maze1].
:- [mazes/maze2].
:- debug.
:- [library(aggregate)].

% movement in the maze 
move(pos(_,_),up).
move(pos(_,_),down).
move(pos(_,_),right).
move(pos(_,_),left).

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
    print(Next), nl,
    dfs(Next,[Next|Visited],Path).

solve_dfs(Path) :-
    start(Position),
    dfs(Position,[Position],Path).

% iterative deepening search.
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

% A* search manhattan distance heuristic
h(pos(X,Y),W):-
    goal(pos(X_goal,Y_goal)),
    W is abs(X-X_goal) + abs(Y-Y_goal).

% a star algorithm to find the path from start to goal
% using the manhattan distance heuristic and the weight of each pos
% to find the path with the least cost
% return the path as a list of pos and the cost

%function to move up, down, left, right and return the cost using the weight and heuristic
move_cost(Position,Move,Cost):-
    move(Position,Move),
    changePos(Position,Move,Next),
    valid(Next),
    h(Next,H),
    Cost is H.
%function to find the lowest cost move
lowest_cost(Position,Move,Cost):-
    move_cost(Position,Move,Cost),
    move_cost(Position,Move_new,Cost_new),
    Cost_new > Cost.

lowest_cost(Position,Move,Cost):-
    move_cost(Position,Move,Cost),
    move_cost(Position,Move_new,Cost_new),
    Cost_new >= Cost.

%a star algorithm to find the path from start to goal
% using the manhattan distance heuristic and the weight of each pos
% to find the path with the least cost
% return the path as a list of pos and the cost
astar(Position,_,[]) :-
    goal(Position).
astar(Position,Visited,[Move,Path]) :-
    lowest_cost(Position,Move,Cost),
    changePos(Position,Move,Next),
    \+member(Next,Visited),
    valid(Next),
    print(Next),
    print(Cost), nl,
    astar(Next,[Next|Visited],Path).
astar(Path) :-
    start(Position),
    astar(Position,[Position],Path).











    















