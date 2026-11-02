#lang racket

(define (ordered? xs)
  ; Проверяваме всяка двойка съседи (car current) и (cadr current)
  ; и натрупваме конюнкцията на резултатите в result.
  (define (helper current pred? result)
    (if (< (length current) 2)
        result
        (helper (cdr current) pred? (and (pred? (car current) (cadr current)) result))
        )
    )
  (λ (pred?) (helper xs pred? #t))
  )

; Алтернативно решение: вместо да трупаме конюнкцията в акумулатор, разчитаме на
; or/and - списък с под два елемента е нареден, а иначе първата двойка трябва да
; удовлетворява pred? и опашката да е наредена. При първа неуспешна двойка спираме веднага.
(define (ordered-rec? xs)
  (define (helper pred? rest)
    (or (< (length rest) 2)
        (and (pred? (car rest) (cadr rest)) (helper pred? (cdr rest))))
    )
  (λ (pred?) (helper pred? xs))
  )

(equal? ((ordered? '(1 2 3 5)) (λ (x y) (< x y))) #t)
(equal? ((ordered? '(1 8 29 92)) (λ (x y) (= y (+ (* x 3) 5)))) #t)
(equal? ((ordered? '(1 8 3 14)) (λ (x y) (= y (+ (* x 3) 5)))) #f)

(equal? ((ordered-rec? '(1 2 3 5)) (λ (x y) (< x y))) #t)
(equal? ((ordered-rec? '(1 8 29 92)) (λ (x y) (= y (+ (* x 3) 5)))) #t)
(equal? ((ordered-rec? '(1 8 3 14)) (λ (x y) (= y (+ (* x 3) 5)))) #f)
