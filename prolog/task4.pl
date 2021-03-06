:- dynamic(on_table/1), dynamic(left/2), dynamic(on/3), dynamic(direct_left/4), dynamic(above/5).

on_table(b).
on_table(f).
on_table(g).
    
left(a,f).   
left(a,e).
left(a,d).
left(a,c).
left(a,g).
left(b,f).   
left(b,e).
left(b,d).
left(b,c).
left(b,g).
left(c,g).   
left(d,g).
left(e,g).
left(f,g).
   
on(a,b).
on(e,f).
on(d,e).
on(c,d).

direct_left(a,e).
direct_left(b,f).    
direct_left(f,g).

above(a,b).
above(e,f).
above(d,f).
above(c,f).
above(d,e).    
above(c,e).
above(c,d).
    
just_left(X,Y) :-
                 on_table(X),
                 on_table(Y),                 
                 direct_left(X,Y).
  
right(X,Y) :- left(Y,X).


