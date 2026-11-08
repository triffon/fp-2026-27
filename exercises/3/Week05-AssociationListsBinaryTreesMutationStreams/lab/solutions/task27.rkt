#lang racket

(define empty-stream '())

(define-syntax cons-stream
  (syntax-rules () ((cons-stream h t) (cons h (delay t))))
  )

(define head car)
(define (tail s)
  (force (cdr s)))

(define (stream-take n stream)
  (if (or (zero? n) (empty? stream)) '() (cons (head stream) (stream-take (sub1 n) (tail stream))))
  )

; От Задача 26.
(define (stream-filter pred? stream)
  (cond
    [(empty? stream) empty-stream]
    [(pred? (head stream)) (cons-stream (head stream) (stream-filter pred? (tail stream)))]
    [else (stream-filter pred? (tail stream))]
    )
  )

(define (stream-from n)
  (cons-stream n (stream-from (add1 n)))
  )

(define natural-numbers (stream-from 1))

; Решето на Ератостен: първото число в потока е просто; махаме всичките му кратни
; от остатъка и пресяваме наново. Всяко следващо просто число "добавя" още един
; филтър към опашката - но мързеливо, само когато някой поиска следващия елемент.
(define (sieve stream)
  (cons-stream (head stream)
               (sieve (stream-filter (λ (x) (not (zero? (remainder x (head stream))))) (tail stream))))
  )

(define primes (sieve (stream-from 2)))

(define (stream-zip-with f s1 s2)
  (if (or (empty? s1) (empty? s2))
      empty-stream
      (cons-stream (f (head s1) (head s2)) (stream-zip-with f (tail s1) (tail s2)))
      )
  )

; "Връзване на възел": fibs е дефиниран чрез самия себе си. Това работи само защото
; cons-stream отлага опашката - когато се пресмята (stream-zip-with + fibs (tail fibs)),
; fibs вече съществува и първите му два елемента (0 и 1) са налични. Всеки следващ
; елемент е сумата на предишните два: fibs и (tail fibs) са един и същ поток, отместен с едно.
(define fibs
  (cons-stream 0
               (cons-stream 1
                            (stream-zip-with + fibs (tail fibs))))
  )

(equal? (stream-take 10 primes) '(2 3 5 7 11 13 17 19 23 29))
(equal? (stream-take 10 fibs) '(0 1 1 2 3 5 8 13 21 34))
(equal? (stream-take 5 (stream-zip-with * natural-numbers natural-numbers)) '(1 4 9 16 25))
(equal? (stream-take 3 (stream-zip-with + natural-numbers (stream-from 10))) '(11 13 15))
