(use gauche.generator)
(use util.combinations)

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
     (let loop ((rpn rpn)
                (stack ()))
       (cond ((null? rpn)
              (car stack))
             ((integer? (car rpn))
              (loop (cdr rpn)
                    (cons (car rpn) stack)))
             (else
              (let ((b (car  stack))
                    (a (cadr stack)))
                (let ((x (case (car rpn)
                           ((+) (+ a b))
                           ((-) (- a b))
                           ((*) (* a b))
                           ((/) (if (= b 0) ; zero division
                                    (break #f)
                                    (/ a b))))))
                  (loop (cdr rpn)
                        (cons x (cddr stack)))))))))))


(define (rpn->expr rpn)
  (let loop ((rpn rpn)
             (stack ()))
    (cond ((null? rpn)
           (car stack))
          ((integer? (car rpn))
           (loop (cdr rpn)
                 (cons (car rpn) stack)))
          (else
           (let ((b (car  stack))
                 (a (cadr stack)))
             (loop (cdr rpn)
                   (cons (format "(~a~a~a)" a (car rpn) b)
                         (cddr stack))))))))
