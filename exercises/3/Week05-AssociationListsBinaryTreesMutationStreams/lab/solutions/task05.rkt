#lang racket

(define (assoc-keys xs)
  (map (λ (pair) (car pair)) xs)
  )

; Алтернативно решение: car вече е унарна процедура, така че не ни трябва ламбда около нея -
; подаваме я директно на map (както при assoc-values с cdr).
(define (assoc-keys-car xs)
  (map car xs)
  )

(define (assoc-values xs)
  (map cdr xs)
  )


(equal? (assoc-keys '((1 . "One") (2 . "Two") (3 . "Three"))) '(1 2 3))
(equal? (assoc-keys '()) '())
(equal? (assoc-keys-car '((1 . "One") (2 . "Two") (3 . "Three"))) '(1 2 3))
(equal? (assoc-keys-car '()) '())

(equal? (assoc-values '((1 . "One") (2 . "Two") (3 . "Three"))) '("One" "Two" "Three"))
(equal? (assoc-values '()) '())
