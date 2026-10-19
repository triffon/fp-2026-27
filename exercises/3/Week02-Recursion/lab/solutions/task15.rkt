#lang racket

(define (partition-function n)
  ; remaining - колко остава да разбием
  ; min-part  - най-малкото допустимо събираемо
  (define (helper remaining min-part)
    (cond
      [(zero? remaining) 1]
      [(> min-part remaining) 0]
      ; Начините, в които участва min-part (махаме едно min-part),
      ; плюс начините, в които min-part не участва (забраняваме го).
      [else (+ (helper (- remaining min-part) min-part)
               (helper remaining (add1 min-part)))]
      )
    )
  (helper n 1)
  )

(= (partition-function 4) 5)
(= (partition-function 5) 7)
(= (partition-function 6) 11)
(= (partition-function 10) 42)
