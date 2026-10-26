#lang racket

; Двете процедури се различават само по условието (even? / odd?)
; и по това какво сумираме (квадрат / куб), затова ги подаваме като аргументи.
(define (sum-if pred? term a b)
  (if (> a b)
      0
      (+ (if (pred? a) (term a) 0)
         (sum-if pred? term (add1 a) b))
      )
  )

(define (sum-even-squares a b)
  (sum-if even? (λ (x) (* x x)) a b)
  )

(define (sum-odd-cubes a b)
  (sum-if odd? (λ (x) (* x x x)) a b)
  )

(= (sum-even-squares 1 10) 220)
(= (sum-even-squares 5 4) 0)
(= (sum-odd-cubes 1 5) 153)
(= (sum-odd-cubes 2 2) 0)
