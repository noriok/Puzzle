(use gauche.generator)


(define (gfibs)
  (generate
   (^(yield)
     (let loop ((a 1)
                (b 1))
       (yield a)
       (loop b (+ a b))))))
