#lang racket

; Зад.1
(define // quotient)
(define % remainder)

; Рекурсивно решение
(define (max-jump n)
  (if (< n 10) 0
      (max (abs (- (% n 10) (% (// n 10) 10)))
           (max-jump (// n 10)))))

; Итеративно решение
(define (max-jump* n)
  (define (loop n best)
    (if (< n 10) best
        (loop (// n 10) (max best (abs (- (% n 10) (% (// n 10) 10)))))))
  (loop n 0))

(max-jump  1326453721) ; 5=7-2
(max-jump* 1326453721) ; 5=7-2

; Зад.2
; Задачата се решава "естествено" с итеративен процес
(define (solve f a b eps)
  (define (different-signs? x1 x2)
    (< (* (f x1) (f x2)) 0))
  (let [(mid (/ (+ a b) 2))] ; за удобство
    (cond [(< (- b a) eps) a]
          [(different-signs? a mid) (solve f a mid eps)]
          [else (solve f mid b eps)])))

(solve sin 1.0 4.0 0.0001) ; pi
(solve (lambda (x) (+ (* x x x) (* -6 x x) (* 11 x) -6)) 0.0 5.0 0.0001); 3

; Зад.3
(define head car)
(define tail cdr)
; Рекурсивно решение
(define (take n lst)
  (cond [(null? lst) '()]
        [(= n 0) '()]
        [else (cons (head lst) (take (- n 1) (tail lst)))]))

; Както повечето задачи, в които изграждаме списъци, рекурсивното решение е по-удобно
(define (moving-average lst k)
  (if (< (length lst) k) '()
      (cons (/ (apply + (take k lst)) k) ; може и (foldr + 0 (take k lst))
            (moving-average (tail lst) k))))

; Итеративно решение
(define (moving-average* lst k)
  ; Ако сме решили да ползваме помощна функция, можем да ѝ дадем повече информация,
  ; напр. след колко итерации да спре, вместо на всяка стъпка да преизчислява (length lst).
  (define (loop lst res numIters)
    (if (< numIters 0) (reverse res)
        (loop (tail lst) (cons (/ (apply + (take k lst)) k) res) (- numIters 1))))
  (loop lst '() (- (length lst) k)))

(moving-average  '(3 2 7 0 -1 1) 3) ; '(4 3 2 0)
(moving-average* '(3 2 7 0 -1 1) 3) ; '(4 3 2 0)
