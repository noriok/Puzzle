(define (hanoi n a b c)
  (when (> n 0)
    (hanoi (- n 1) a c b)
    (print #"~n : ~a -> ~b")
    (hanoi (- n 1) c b a)))

#|

% gosh -l ./hanoi.scm
gosh> (hanoi 3 'a 'b 'c)
1 : a -> b
2 : a -> c
1 : b -> c
3 : a -> b
1 : c -> a
2 : c -> b
1 : a -> b
#<undef>

|#
