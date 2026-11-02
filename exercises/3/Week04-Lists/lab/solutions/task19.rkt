#lang racket

; Ако главата е списък, я "разгъваме" рекурсивно и залепваме резултата
; пред разгънатата опашка; ако е атом, просто я запазваме.
(define (my-flatten xss)
  (cond
    [(empty? xss) xss]
    [(list? (car xss)) (append (my-flatten (car xss)) (my-flatten (cdr xss)))]
    [else (cons (car xss) (my-flatten (cdr xss)))]
    )
  )

; Алтернативно решение: с map превръщаме всеки елемент в плосък списък
; (вложен списък - рекурсивно, атом - в едноелементен списък),
; а (apply append ...) залепва получените списъци в един.
(define (my-flatten-apply xss)
  (apply append (map (λ (x) (if (list? x) (my-flatten-apply x) (list x))) xss))
  )

(equal? (my-flatten '((1 2 3) (4 5 6) ((7 8) (9 10 (11 (12)))))) '(1 2 3 4 5 6 7 8 9 10 11 12))

(equal? (my-flatten-apply '((1 2 3) (4 5 6) ((7 8) (9 10 (11 (12)))))) '(1 2 3 4 5 6 7 8 9 10 11 12))
