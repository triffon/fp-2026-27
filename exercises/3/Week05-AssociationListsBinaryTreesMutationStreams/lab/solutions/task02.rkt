#lang racket

(define (assoc-del key xs)
  (cond
    [(empty? xs) '()]
    [(equal? (caar xs) key) (cdr xs)]
    [else (cons (car xs) (assoc-del key (cdr xs)))]
    )
  )

; Алтернативно решение: assoc намира първата двойка с този ключ, а remove я маха от списъка.
; Ако няма такава двойка, assoc връща #f, което не е елемент на списъка, и remove го връща непроменен.
(define (assoc-del-remove key xs)
  (remove (assoc key xs) xs)
  )

(equal? (assoc-del 1 (list '(2 . "Two") '(3 . "Three") '(1 . "One"))) '((2 . "Two") (3 . "Three")))
(equal? (assoc-del 1 (list '(2 . "Two") '(3 . "Three"))) '((2 . "Two") (3 . "Three")))
(equal? (assoc-del-remove 1 (list '(2 . "Two") '(3 . "Three") '(1 . "One"))) '((2 . "Two") (3 . "Three")))
(equal? (assoc-del-remove 1 (list '(2 . "Two") '(3 . "Three"))) '((2 . "Two") (3 . "Three")))
