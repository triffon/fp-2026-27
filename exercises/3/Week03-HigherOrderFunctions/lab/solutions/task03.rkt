#lang racket

(define (apply-n f n)
  ; Прилагаме f върху result, докато не остане нито едно прилагане.
  (define (helper remaining result)
    (if (zero? remaining)
        result
        (helper (sub1 remaining) (f result))
        )
    )
  (λ (x) (helper n x))
  )

(= ((apply-n (λ (x) (* 2 x)) 5) 2) 64)
(= ((apply-n (λ (x) (quotient x 10)) 2) 100) 1)
(= ((apply-n add1 0) 5) 5)
