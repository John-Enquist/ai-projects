%% Implementation of forward planning using iterative deepening to
%% search through the state space.

:- ['blocks'].

run :- 
    initial_state(InitialStateUnsorted),
    sort(InitialStateUnsorted, InitialState),
    goal(Goals),
    limit_plan_length(Plan),
    plan(InitialState, Goals, Plan, FinalState, []),
    write('INITIAL STATE'), nl,
    write(InitialState), nl,
    write('GOAL'), nl,
    write(Goals), nl,
    write('PLAN'), nl,
    write(Plan), nl,
    write('FINAL STATE'), nl,
    write(FinalState).


%% first look for plans of length 0, then lenght 1, length 2, etc.
limit_plan_length([]).
limit_plan_length([_|Rest]) :-
    limit_plan_length(Rest).


%% plan(CurrentState, Goals, Plan, FinalState, Visited)
plan(State, Goals, [], State, _) :-
    satisfied(Goals, State).
plan(State, Goals, [Action|RestPlan], FinalState, Visited) :-
    applicable(Action, State),
    apply(Action, State, NextState),
    \+ member(NextState, Visited),
    plan(NextState, Goals, RestPlan, FinalState, [State|Visited]).


%% All Goals/Conditions are satisfied in State.
satisfied([], _).
satisfied([Goal|OtherGoals], State) :-
    %% Goal literal is either in State or true due to background knowledge
    (member(Goal, State) ;
     Goal),
    satisfied(OtherGoals, State).


%% Find an applicable Action.
applicable(Action, State) :-
    %% This predicate succeeds if Action is an action that is
    %% applicable in the given State. Normally, this will be called
    %% with a fully specified State and Action not instantiated.
    preconditions(Action, X),
    satisfied(X, State).


%% Apply an Action.
apply(Action, State, NextState) :-
    %% This predicate succeeds if applying the given Action in the
    %% given State yields NextState. Normally this will be called with
    %% Action and State instantiated and NextState not instantiated.
    add(Action, T),
    del(Action, L),
    subtract(State, L, C),
    append(C, T, NextState).
