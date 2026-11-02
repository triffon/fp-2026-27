#lang racket

(define (my-length xs)
  (if (empty? xs)
      0
      (add1 (my-length (cdr xs)))
      )
  )

; Алтернативно решение: заместваме всеки елемент с 1 чрез map и сумираме с apply -
; дължината е просто сумата на единиците, без явна рекурсия.
(define (my-length-apply xs)
  (apply + (map (λ (x) 1) xs))
  )

; Алтернативно решение: с foldl броим елементите в акумулатора, без да гледаме
; стойностите им - списъкът се обхожда веднъж и не ни трябва помощна процедура.
(define (my-length-foldl xs)
  (foldl (λ (x acc) (add1 acc)) 0 xs)
  )

(= (my-length '()) 0)
(= (my-length '(1 2 5 6 4 8)) 6)

(= (my-length-apply '()) 0)
(= (my-length-apply '(1 2 5 6 4 8)) 6)

(= (my-length-foldl '()) 0)
(= (my-length-foldl '(1 2 5 6 4 8)) 6)
