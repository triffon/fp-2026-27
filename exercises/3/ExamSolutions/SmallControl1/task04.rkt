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

; Потокът се строи от помощна процедура, която пази състоянието на редицата:
; текущия член, номера на следващата стъпка и вече срещнатите числа.
; При стъпка напред не проверяваме за повторение - тогава то е позволено.
(define (recaman-from current n seen)
  (cons-stream current
               (let ([back (- current n)])
                 (if (and (> back 0) (not (member back seen)))
                     (recaman-from back (add1 n) (cons back seen))
                     (recaman-from (+ current n) (add1 n) (cons (+ current n) seen))
                     )
                 )
               )
  )

(define recaman (recaman-from 0 1 '(0)))

(equal? (stream-take 1 recaman) '(0))
(equal? (stream-take 15 recaman) '(0 1 3 6 2 7 13 20 12 21 11 22 10 23 9))
(equal? (stream-take 25 recaman) '(0 1 3 6 2 7 13 20 12 21 11 22 10 23 9 24 8 25 43 62 42 63 41 18 42)) ; 42 се повтаря
