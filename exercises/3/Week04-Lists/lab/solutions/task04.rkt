#lang racket

(define (remove-first x xs)
  (cond
    [(empty? xs) xs]
    [(equal? (car xs) x) (cdr xs)]
    [else (cons (car xs) (remove-first x (cdr xs)))]
    )
  )

; Разликата с remove-first е само в това, че след намерено срещане
; продължаваме да търсим в остатъка, вместо да спрем.
(define (remove-all x xs)
  (cond
    [(empty? xs) xs]
    [(equal? (car xs) x) (remove-all x (cdr xs))]
    [else (cons (car xs) (remove-all x (cdr xs)))]
    )
  )

; Алтернативно решение: "премахни всички срещания на x" е същото като
; "запази елементите, различни от x" - точно това прави filter.
(define (remove-all-filter x xs)
  (filter (λ (y) (not (equal? y x))) xs)
  )

(equal? (remove-first 1 '(1 1 1 2)) '(1 1 2))
(equal? (remove-first 1 '(2 5 6)) '(2 5 6))
(equal? (remove-first 1 '(1)) '())
(equal? (remove-first 1 '(2 1)) '(2))
(equal? (remove-first "RNN" '("CNN" "RNN" "GAN" "RNN")) '("CNN" "GAN" "RNN"))

(equal? (remove-all 1 '(1 1 1 2)) '(2))
(equal? (remove-all 1 '(2 5 6)) '(2 5 6))
(equal? (remove-all 1 '(1)) '())
(equal? (remove-all 1 '(1 2 1 1)) '(2))
(equal? (remove-all "RNN" '("CNN" "RNN" "GAN" "RNN")) '("CNN" "GAN"))

(equal? (remove-all-filter 1 '(1 1 1 2)) '(2))
(equal? (remove-all-filter 1 '(2 5 6)) '(2 5 6))
(equal? (remove-all-filter 1 '(1)) '())
(equal? (remove-all-filter 1 '(1 2 1 1)) '(2))
(equal? (remove-all-filter "RNN" '("CNN" "RNN" "GAN" "RNN")) '("CNN" "GAN"))
