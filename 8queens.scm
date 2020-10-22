(use srfi-42)

(define (good? pos queens)
  (not (find (^p (or (= (car p) (car pos))
                     (= (cdr p) (cdr pos))
                     (= (abs (- (car p) (car pos)))
                        (abs (- (cdr p) (cdr pos))))))
             queens)))

(define (solve)
  (let loop ((n 0)
             (queens ()))
    (cond ((= n 8)
           (print #"found: ~queens"))
          (else
           (do-ec (:range i n 8)
                  (:range j 8)
                  (if (good? (cons i j) queens))
                  (loop (+ n 1) (cons (cons i j) queens)))))))

(define (main args)
  (solve)
  )
