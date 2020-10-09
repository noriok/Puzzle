(use gauche.generator)
(use util.combinations)
(use util.match)

(define (make10 digits)
  (make-n digits 10))

(define (make-n digits goal)
  (dolist (ds (permutations* (sort digits)))
    (do-generator (rpn (make-rpn ds))
      (let ((ret (eval rpn)))
        (if (and ret (= ret goal))
            (print (rpn->expr rpn)))))))

;; 逆ポーランド記法の式を生成
(define (make-rpn digits)
  (generate
   (^[yield]
     (let loop ((rpn  ())
                (nums 0)
                (ops  0))
       (if (= (+ nums ops)
              (+ (* 2 (length digits)) -1))
           (yield (reverse rpn)))
       ; push operator
       (if (> nums (+ ops 1))
           (dolist (op '(+ - * /))
             (loop (cons op rpn)
                   nums
                   (+ ops 1))))
       ; push number
       (if (< nums (length digits))
           (loop (cons (list-ref digits nums) rpn)
                 (+ nums 1)
                 ops))))))

;; 逆ポーランド記法の式を評価
(define (eval rpn)
  (call/cc
   (lambda (break)
     (car (fold (^[lhs rhs]
                  (match (cons lhs rhs)
                    (('+ a b . xs) (cons (+ b a) xs))
                    (('- a b . xs) (cons (- b a) xs))
                    (('* a b . xs) (cons (* b a) xs))
                    (('/ 0 b . xs) (break #f)) ; zero division
                    (('/ a b . xs) (cons (/ b a) xs))
                    (else (cons lhs rhs))))
                ()
                rpn)))))

(define (rpn->expr rpn)
  (car (fold (^[lhs rhs]
               (if (symbol? lhs)
                   (match rhs
                     ((a b . xs) (cons #"(~|b|~|lhs|~|a|)" xs)))
                   (cons lhs rhs)))
             ()
             rpn)))
