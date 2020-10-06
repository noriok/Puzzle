;; ピーターの問題
;; https://twitter.com/keisei_otsuka/status/1223841916405440512

(use util.combinations)
(use util.match)

(define (peter)
  (define (frac a b c)
    (/ a (+ (* 10 b) c)))

  (dolist (p (permutations (iota 9 1)))
    (match p
      ((a b c d e f g h i)
       (let ((x (frac a b c))
             (y (frac d e f))
             (z (frac g h i)))
         (when (and (= (+ x y z) 1)
                    (<= x y z))
           (apply format #t "~a/~a~a + ~a/~a~a + ~a/~a~a = 1~%" p)))))))
