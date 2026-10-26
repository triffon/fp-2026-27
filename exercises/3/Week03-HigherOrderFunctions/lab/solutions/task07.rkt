#lang racket

(define (accumulate op nv a b term next)
    (if (> a b) nv
        (op (term a) (accumulate op nv (next a) b term next))))

; Неутралният елемент за and е #t - в празен интервал
; всички (нула на брой) числа изпълняват предиката.
(define (all? a b pred?)
  (accumulate (λ (x y) (and x y)) #t a b pred? add1)
  )

(equal? (all? 100 999 (λ (x) (< x 1000))) #t)
(equal? (all? 1 100 odd?) #f)
(equal? (all? 5 4 odd?) #t)
