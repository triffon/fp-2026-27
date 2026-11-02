#lang racket

; foldl обхожда xs отляво надясно и слага всеки следващ елемент
; в началото на акумулатора, така че последният се оказва пръв.
(define (my-reverse-foldl xs)
  (foldl (λ (x acc) (cons x acc)) '() xs)
  )

(equal? (my-reverse-foldl '(1 2 3 4 5)) '(5 4 3 2 1))
