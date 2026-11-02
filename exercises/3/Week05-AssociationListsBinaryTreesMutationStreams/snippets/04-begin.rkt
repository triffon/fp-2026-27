#lang racket

(define x 5)

; begin изпълнява изразите последователно (заради страничните им ефекти)
; и връща стойността на последния - тук 15.
(begin
  (display "Hello, ")
  (displayln "world!")
  (+ x 10))
