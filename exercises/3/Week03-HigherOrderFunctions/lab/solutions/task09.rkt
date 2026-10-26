#lang racket

(define (accumulate op nv a b term next)
    (if (> a b) nv
        (op (term a) (accumulate op nv (next a) b term next))))

; Започваме с a като "текущ минимум" и обхождаме [a + 1; b],
; като на всяка стъпка пазим по-доброто от двете числа.
(define (argmin f a b)
  (accumulate (λ (x y) (if (< (f x) (f y)) x y)) a (add1 a) b identity add1)
  )

(define (mod7 x) (remainder x 7))
(= (argmin mod7 45 50) 49)
(= (argmin mod7 45 45) 45)
(= (argmin (λ (x) (* x x)) -3 3) 0)
