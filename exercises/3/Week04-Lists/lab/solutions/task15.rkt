#lang racket

(define (my-cartesian-product xs ys)
  ; Всички двойки с първа компонента x.
  (define (pairs-with x)
    (map (λ (y) (cons x y)) ys)
    )
  ; Залепваме групите за x1, x2, ... една след друга, за да запазим реда.
  (foldl (λ (x acc) (append acc (pairs-with x))) '() xs)
  )

; Алтернативно решение: за всяко x строим с map списъка от двойки (x . y),
; а (apply append ...) залепва тези списъци един след друг в реда на x-овете.
(define (my-cartesian-product-apply xs ys)
  (apply append (map (λ (x) (map (λ (y) (cons x y)) ys)) xs))
  )

(equal? (my-cartesian-product '(1 2) '(3 4)) '((1 . 3) (1 . 4) (2 . 3) (2 . 4)))
(equal? (my-cartesian-product '(1 2 3 4 5) '(6 7 8)) '((1 . 6) (1 . 7) (1 . 8) (2 . 6) (2 . 7) (2 . 8) (3 . 6) (3 . 7) (3 . 8) (4 . 6) (4 . 7) (4 . 8) (5 . 6) (5 . 7) (5 . 8)))

(equal? (my-cartesian-product-apply '(1 2) '(3 4)) '((1 . 3) (1 . 4) (2 . 3) (2 . 4)))
(equal? (my-cartesian-product-apply '(1 2 3 4 5) '(6 7 8)) '((1 . 6) (1 . 7) (1 . 8) (2 . 6) (2 . 7) (2 . 8) (3 . 6) (3 . 7) (3 . 8) (4 . 6) (4 . 7) (4 . 8) (5 . 6) (5 . 7) (5 . 8)))
