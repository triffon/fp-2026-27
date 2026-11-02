#lang racket

(define (concat xs ys)
  (if (empty? xs)
      ys
      (cons (car xs) (concat (cdr xs) ys))
      )
  )

; Алтернативно решение: foldr с cons и начална стойност ys прави точно
; (cons x1 (cons x2 ... (cons xn ys))) - рекурсията отгоре, събрана в един ред.
(define (concat-foldr xs ys)
  (foldr cons ys xs)
  )

(equal? (concat '(1 2 3) '(4 5 6)) '(1 2 3 4 5 6))

(equal? (concat-foldr '(1 2 3) '(4 5 6)) '(1 2 3 4 5 6))
