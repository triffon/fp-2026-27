#lang racket

(define (accumulate op nv a b term next)
    (if (> a b) nv
        (op (term a) (accumulate op nv (next a) b term next))))

; n! = 1 * 2 * 3 * ... * n

(define (factorial n)
  (accumulate * 1 1 n (λ (x) x) (λ (x) (add1 x)))
  )

; Същото, но с вградените identity и add1 вместо ламбди.
(define (factorial-short n)
  (accumulate * 1 1 n identity add1)
  )

(= (factorial 5) 120)
(= (factorial 8) 40320)
(= (factorial 0) 1)

(= (factorial-short 5) 120)
(= (factorial-short 8) 40320)
(= (factorial-short 0) 1)
