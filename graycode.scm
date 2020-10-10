;; gray n = n ^ (n >> 1)
(define (gray n)
  (logxor n (ash n -1)))

(let ((n (expt 2 4)))
  (dolist (i (iota n))
    (format #t "~4,'0B~%" (gray i))))

#|

0000
0001
0011
0010
0110
0111
0101
0100
1100
1101
1111
1110
1010
1011
1001
1000

|#
