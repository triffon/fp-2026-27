#lang racket

(define (assoc-rec key xs)
  (cond
    [(empty? xs) #f]
    [(equal? key (caar xs)) (cdar xs)]
    [else (assoc-rec key (cdr xs))]
  )
  )

(define (assoc-hop key xs)
  (define filtered-xs (filter (λ (pair) (equal? (car pair) key)) xs))
  (if (empty? filtered-xs) #f (cdar filtered-xs))
  )

; Алтернативно решение: ormap връща първия истинен резултат, така че намира първата двойка
; с този ключ и направо дава стойността ѝ, а ако няма такава - #f. Отпада отделната проверка за празен списък.
(define (assoc-hop-ormap key xs)
  (ormap (λ (pair) (and (equal? (car pair) key) (cdr pair))) xs)
  )

(define (assoc-assoc key xs)
  (define maybe-pair (assoc key xs))
  (if (pair? maybe-pair) (cdr maybe-pair) #f)
  )

(equal? (assoc-rec 1 (list '(2 . "Two") '(3 . "Three") '(1 . "One"))) "One")
(equal? (assoc-rec 4 (list '(2 . "Two") '(3 . "Three") '(1 . "One"))) #f)

(equal? (assoc-hop 1 (list '(2 . "Two") '(3 . "Three") '(1 . "One"))) "One")
(equal? (assoc-hop 4 (list '(2 . "Two") '(3 . "Three") '(1 . "One"))) #f)

(equal? (assoc-hop-ormap 1 (list '(2 . "Two") '(3 . "Three") '(1 . "One"))) "One")
(equal? (assoc-hop-ormap 4 (list '(2 . "Two") '(3 . "Three") '(1 . "One"))) #f)

(equal? (assoc-assoc 1 (list '(2 . "Two") '(3 . "Three") '(1 . "One"))) "One")
(equal? (assoc-assoc 4 (list '(2 . "Two") '(3 . "Three") '(1 . "One"))) #f)
