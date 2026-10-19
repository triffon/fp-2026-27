#lang racket

(define (rev n)
  (define (helper reversed remaining)
    (if (zero? remaining)
        reversed
        (helper (+ (* reversed 10) (remainder remaining 10)) (quotient remaining 10))
        )
    )
  (helper 0 n)
  )

(= (rev 0) 0)
(= (rev 123) 321)
(= (rev 987654321) 123456789)
(= (rev 12000) 21)