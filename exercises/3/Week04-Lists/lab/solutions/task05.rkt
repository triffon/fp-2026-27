#lang racket

; Първите idx елемента остават преди x, а останалите - след него.
(define (insert-at x idx xs)
  (append (take xs idx) (cons x (drop xs idx)))
  )

(equal? (insert-at 1 0 '()) '(1))
(equal? (insert-at 1 0 '(2)) '(1 2))
(equal? (insert-at 10 1 '(1 2 3)) '(1 10 2 3))
