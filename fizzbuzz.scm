(use gauche.generator)
(use util.match)

(define (fizzbuzz)
  (gmap (^[a b c] (match (list a b c)
                    ((x "" "") x)
                    ((_ s t) (string-append s t))))
        (grange 1)
        (circular-generator "" "" "fizz")
        (circular-generator "" "" "" "" "buzz")))

(print (generator->list (fizzbuzz) 32))
;;=> (1 2 fizz 4 buzz fizz 7 8 fizz buzz 11 fizz 13 14 fizzbuzz 16 17 fizz 19
;;    buzz fizz 22 23 fizz buzz 26 fizz 28 29 fizzbuzz 31 32)
