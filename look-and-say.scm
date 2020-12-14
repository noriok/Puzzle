(use gauche.generator)
(use gauche.sequence)

;; Look-and-say sequence
;; https://en.wikipedia.org/wiki/Look-and-say_sequence

(define (look-and-say s)
  ($ list->string
     $ concatenate
     $ map (^a (list (integer->digit (length a)) (car a)))
     $ group-sequence s :test char=?))

(define (main args)
  (generator-for-each print (gtake (giterate look-and-say "1") 10)))

#|

$ gosh look-and-say.scm
1
11
21
1211
111221
312211
13112221
1113213211
31131211131221
13211311123113112211

|#
