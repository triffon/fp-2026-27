#lang racket

(define counter 0)

; set! променя стойността на вече дефинирана променлива (мутация) - за разлика
; от define, който създава нова. Процедурата има страничен ефект: всяко извикване
; променя counter, така че една и съща процедура връща различни резултати.
(define (increment-counter)
  (set! counter (+ counter 1)))

(define (get-counter) counter)

(displayln (get-counter))
(increment-counter)
(displayln (get-counter))

(increment-counter)
(increment-counter)
(increment-counter)
(increment-counter)

(displayln (get-counter))
