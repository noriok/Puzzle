(use gauche.generator)
(use scheme.list)

(define (iterate f x)
   (generate
    (^[yield]
      (let loop ((x x))
        (yield x)
        (loop (f x))))))

;; pascal's triangle with n rows
(define (pascal n)

  (define (f lis)
    (let ((x (map (cut fold + 0 <>)
                  (zip lis (drop lis 1)))))
      (append '(1) x '(1))))

  (generator->list (iterate f '(1)) n))

#|

gosh> (for-each print (pascal 8))
(1)
(1 1)
(1 2 1)
(1 3 3 1)
(1 4 6 4 1)
(1 5 10 10 5 1)
(1 6 15 20 15 6 1)
(1 7 21 35 35 21 7 1)
#<undef>

|#
