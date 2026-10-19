#lang racket

(define (my-recursive-pow x n)
  (if (zero? n)
      1
      (* x (my-recursive-pow x (sub1 n)))
      )
  )

(= (my-recursive-pow 2 5) 32)
(= (my-recursive-pow 15 3) 3375)