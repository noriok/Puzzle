#|

% cat quine.scm
((lambda (x) (list x (list 'quote x))) '(lambda (x) (list x (list 'quote x))))
% gosh quine-test.scm
((lambda (x) (list x (list 'quote x))) '(lambda (x) (list x (list 'quote x))))
% gosh quine-test.scm > out
% diff quine.scm out

|#

(print (eval (read (open-input-file "./quine.scm")) (current-module)))
