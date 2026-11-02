#lang racket

(display "Enter a number:")
; read-line чете един ред от стандартния вход и го връща като низ (без новия ред).
(define input (read-line))

(displayln "You entered:")
(displayln input)

; Входът е низ, затова първо го превръщаме в число.
(+ 3 (string->number input))

; Ред с няколко стойности: string-split го разделя по интервалите в списък от
; низове, а с map string->number превръщаме всяка част в число.
(string-split "10 20 30")                      ; '("10" "20" "30")
(map string->number (string-split "10 20 30")) ; '(10 20 30)
(string-split "a,b,c" ",")                     ; '("a" "b" "c") - може и с друг разделител
