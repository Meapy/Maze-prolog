:- [mazes/maze1].
%:- [mazes/maze2].
:- debug.
:- [library(aggregate)].

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
    %valid(Next),
    h(Next,H),
    Cost is H.
find_lowest(Position,Cost,Move):-
    move_cost(Position,up,Cost_up),
    move_cost(Position,down,Cost_down),
    move_cost(Position,left,Cost_left),
    move_cost(Position,right,Cost_right),
    min_list([Cost_up,Cost_down,Cost_left,Cost_right],Cost),
    (Cost == Cost_up -> Move = up;
    (Cost == Cost_down -> Move = down;
    (Cost == Cost_left -> Move = left;
    (Cost == Cost_right -> Move = right)))).




%a star algorithm to find the path from start to goal
% using the manhattan distance heuristic and the weight of each pos
% to find the path with the least cost
% return the path as a list of pos and the cost
astar(Position,_,[]) :-
    goal(Position).
astar(Position,Visited,[Move,Path]) :-
    find_lowest(Position,Cost,Move),
    print(Cost),
    changePos(Position,Move,Next),
    print(Next), nl,
    \+member(Next,Visited),
    astar(Next,[Next|Visited],Path).
astar(Path) :-
    start(Position),
    astar(Position,[Position],Path).











    















