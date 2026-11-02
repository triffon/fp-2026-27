#lang racket

(define (longest-ascending-sub xs)
  ; Обхождаме списъка веднъж и пазим две редици, и двете обърнати
  ; (за да добавяме елементи отпред с cons):
  ;  - current - ненамаляващата редица, която тече в момента;
  ;  - best - най-дългата приключила редица досега.
  ; Когато срещнем по-малък елемент, редицата се прекъсва и започва нова от него.
  (define (longer current best)
    (if (> (length current) (length best)) current best)
    )
  (define (helper rest current best)
    (cond
      [(empty? rest) (reverse (longer current best))]
      [(<= (car current) (car rest)) (helper (cdr rest) (cons (car rest) current) best)]
      [else (helper (cdr rest) (list (car rest)) (longer current best))]
      )
    )
  ; Строгото > в longer гарантира, че при равни дължини остава първата намерена.
  (if (empty? xs)
      '()
      (helper (cdr xs) (list (car xs)) '())
      )
  )

(equal? (longest-ascending-sub '(1 0 5)) '(0 5))
(equal? (longest-ascending-sub '(1 5 2 3 1 5 6 7 7 1 5)) '(1 5 6 7 7))
(equal? (longest-ascending-sub '(1 5 2 3 1 5 2 7 7 15)) '(2 7 7 15))
(equal? (longest-ascending-sub '(1 5 2 3 4 5 6 7 7 1 5)) '(2 3 4 5 6 7 7))
(equal? (longest-ascending-sub '(1 5 2 4 6 8 3 4 1)) '(2 4 6 8))
(equal? (longest-ascending-sub '(3 4 1 2)) '(3 4))
(equal? (longest-ascending-sub '(5)) '(5))
