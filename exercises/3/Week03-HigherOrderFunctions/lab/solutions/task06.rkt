#lang racket

(define (accumulate op nv a b term next)
    (if (> a b) nv
        (op (term a) (accumulate op nv (next a) b term next))))

; n е просто, ако n > 1 и никое d от [2; корен от n] не дели n.
; and е специална форма, а не процедура, затова не можем да подадем
; директно and като op и я "опаковаме" в ламбда.
; Забележете, че accumulate не спира рано - дори да намерим делител,
; ще проверим всички числа до корен от n.
(define (prime? n)
  (and (> n 1)
       (accumulate (λ (x y) (and x y)) #t 2 (integer-sqrt n) (λ (d) (not (zero? (remainder n d)))) add1))
  )

(equal? (prime? 0) #f)
(equal? (prime? 1) #f)
(equal? (prime? 2) #t)
(equal? (prime? 3) #t)
(equal? (prime? 4) #f)
(equal? (prime? 6) #f)
(equal? (prime? 42) #f)
(equal? (prime? 61) #t)
