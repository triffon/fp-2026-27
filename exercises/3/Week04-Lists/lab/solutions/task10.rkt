#lang racket

(define (where xs ps)
  ; Елементът остава, ако конюнкцията на резултатите от всички предикати е #t.
  (define (satisfies-all? x)
    (foldl (λ (res acc) (and res acc)) #t (map (λ (pred?) (pred? x)) ps))
    )

  (filter satisfies-all? xs)
  )

; Алтернативно решение: andmap проверява дали всички предикати връщат истина за x,
; така че не ни трябват отделни map и foldl за конюнкцията.
(define (where-andmap xs ps)
  (filter (λ (x) (andmap (λ (pred?) (pred? x)) ps)) xs)
  )

(equal? (where '(3 4 5 6 7 8 9 10) (list even? (λ (x) (> x 5)))) '(6 8 10))
(equal? (where '(3 4 5 7) (list even? (λ (x) (> x 5)))) '())
(equal? (where '() (list odd? (λ (x) (> x 3)) (λ (x) (< x 20)))) '())
(equal? (where '(1 2 3 4 5 6 7 8 9 10 11 13 15) (list odd? (λ (x) (> x 3)) (λ (x) (< x 20)))) '(5 7 9 11 13 15))

(equal? (where-andmap '(3 4 5 6 7 8 9 10) (list even? (λ (x) (> x 5)))) '(6 8 10))
(equal? (where-andmap '(3 4 5 7) (list even? (λ (x) (> x 5)))) '())
(equal? (where-andmap '() (list odd? (λ (x) (> x 3)) (λ (x) (< x 20)))) '())
(equal? (where-andmap '(1 2 3 4 5 6 7 8 9 10 11 13 15) (list odd? (λ (x) (> x 3)) (λ (x) (< x 20)))) '(5 7 9 11 13 15))
