#lang racket

(define (accumulate op nv a b term next)
    (if (> a b) nv
        (op (term a) (accumulate op nv (next a) b term next))))

; За всяко x от [a; b] двойката му е еднозначно определена - y = n - x.
; За да не броим (3, 7) и (7, 3) два пъти, искаме x <= y.
; Остава да проверим, че y също е в интервала, т.е. x <= y <= b.
(define (count-pairs a b n)
  (accumulate + 0 a b (λ (x) (if (<= x (- n x) b) 1 0)) add1)
  )

(= (count-pairs 1 10 14) 4)
(= (count-pairs 1 10 2) 1)
(= (count-pairs 1 10 20) 1)
(= (count-pairs 1 10 21) 0)
(= (count-pairs 5 10 3) 0)
