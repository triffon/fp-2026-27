#lang racket

(define (deep-delete xss)
  ; current-level е дълбочината на атомите в left-over. При влизане
  ; във вложен списък тя расте с 1, а при движение по опашката остава същата.
  (define (helper current-level left-over)
    (cond
      [(empty? left-over) left-over]
      [(list? (car left-over)) (cons (helper (add1 current-level) (car left-over)) (helper current-level (cdr left-over)))]
      [(>= (car left-over) current-level) (cons (car left-over) (helper current-level (cdr left-over)))]
      [else (helper current-level (cdr left-over))]
      )
    )
  (helper 1 xss)
  )

; Алтернативно решение: на всяко ниво първо махаме с filter атомите, по-малки от
; дълбочината (вложените списъци остават), а после с map обработваме рекурсивно
; вложените списъци с дълбочина + 1 - двете грижи са разделени в две прости стъпки.
(define (deep-delete-map xss)
  (define (helper level xs)
    (map (λ (x) (if (list? x) (helper (add1 level) x) x))
         (filter (λ (x) (or (list? x) (>= x level))) xs))
    )
  (helper 1 xss)
  )

(equal? (deep-delete '(1 (2 (2 4) 1) 0 (3 (1)))) '(1 (2 (4)) (3 ())))

(equal? (deep-delete-map '(1 (2 (2 4) 1) 0 (3 (1)))) '(1 (2 (4)) (3 ())))
