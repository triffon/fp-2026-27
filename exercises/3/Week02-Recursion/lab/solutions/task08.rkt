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

(define (palindrome? n)
  (= n (rev n))
  )

(define (palindromes-between a b)
  (define (helper current count)
    (cond
      [(> current b) count]
      [(palindrome? current) (helper (add1 current) (add1 count))]
      [else (helper (add1 current) count)]
      )
    )
  (if (> a b) (palindromes-between b a) (helper a 0))
  )

(= (palindromes-between 1 101) 19)
(= (palindromes-between 1 100) 18)
(= (palindromes-between 100 1) 18)