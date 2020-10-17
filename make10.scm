(use gauche.generator)
(use util.combinations)
(use util.match)
(use srfi-42) ; do-ec

(define (make10 a b c d)
  (make (list a b c d) 10))

(define (make digits goal)
  (do-ec (: ds (permutations* (sort digits)))
         (: rpn (make-rpn ds))
         (and-let* ((ret (eval rpn))
                    ((= ret goal)))
           (print (rpn->expr rpn)))))

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
  (let/cc return
    (car (fold (^[lhs rhs]
                 (match (cons lhs rhs)
                   (('+ a b . xs) (cons (+ b a) xs))
                   (('- a b . xs) (cons (- b a) xs))
                   (('* a b . xs) (cons (* b a) xs))
                   (('/ 0 b . xs) (return #f)) ; zero division
                   (('/ a b . xs) (cons (/ b a) xs))
                   (else (cons lhs rhs))))
               ()
               rpn))))

(define (rpn->expr rpn)
  (car (fold (^[lhs rhs]
               (if (symbol? lhs)
                   (match rhs
                     ((a b . xs) (cons #"(~|b|~|lhs|~|a|)" xs)))
                   (cons lhs rhs)))
             ()
             rpn)))
