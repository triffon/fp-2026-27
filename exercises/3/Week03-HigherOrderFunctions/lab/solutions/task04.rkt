#lang racket

(define (accumulate op nv a b term next)
    (if (> a b) nv
        (op (term a) (accumulate op nv (next a) b term next))))

; 2^3 + 5^3 + 8^3 + ..., докато основата не надвиши n.
; Не е нужно n да е от вида 3k + 2 - accumulate спира при първото
; число, по-голямо от n.
(define (cool-expression n)
  (accumulate + 0 2 n (λ (x) (expt x 3)) (λ (x) (+ x 3)))
  )

(= (cool-expression 11) 1976)
(= (cool-expression 15) 4720)
(= (cool-expression 1) 0)
