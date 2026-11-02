#lang racket

(define (count-occurrences xs ys)
  ; Проверяваме дали xs е префикс на всяка опашка на ys. След срещане
  ; се местим само с един елемент напред, затова застъпванията също се броят.
  (define (helper current result)
    (cond
      [(< (length current) (length xs)) result]
      [(equal? (take current (length xs)) xs) (helper (cdr current) (add1 result))]
      [else (helper (cdr current) result)]
      )
    )
  (helper ys 0)
  )

; Алтернативно решение: генерираме с range всички начални индекси, на които
; xs би се събрал в ys, оставяме с filter тези, където опашката започва с xs,
; и броим колко са - без помощна процедура с акумулатор.
(define (count-occurrences-range xs ys)
  (define (match-at? i)
    (equal? (take (drop ys i) (length xs)) xs)
    )
  (length (filter match-at? (range (add1 (- (length ys) (length xs))))))
  )

(= (count-occurrences '(1 5) '(1 5 2 3 1 5 6 7 7 1 5)) 3)
(= (count-occurrences '(5 5) '(5 5 5 3 1 5 6 7 5 5 5)) 4)
(= (count-occurrences '(6 6) '(2 2)) 0)

(= (count-occurrences-range '(1 5) '(1 5 2 3 1 5 6 7 7 1 5)) 3)
(= (count-occurrences-range '(5 5) '(5 5 5 3 1 5 6 7 5 5 5)) 4)
(= (count-occurrences-range '(6 6) '(2 2)) 0)
