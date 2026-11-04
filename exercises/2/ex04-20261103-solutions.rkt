#lang racket
(define head car)
(define tail cdr)

; Решение 1: ако първият елемент се среща поне още веднъж,
; можем просто да го игнорираме и да продължим без него
(define (uniques lst)
  (cond [(null? lst) '()]
        [(member (head lst) (tail lst)) (uniques (tail lst))]
        [else (cons (head lst) (uniques (tail lst)))]))

(uniques '(1 2 2 "iei" 1 3 "iei" 'oops))

; Решение 2: итеративно "натрупваме" само елементи, които
; не сме срещнали и натрупали досега
(define (uniques* lst)
  (define (loop lst res)
    (cond [(null? lst) res]
          [(member (head lst) res) (loop (tail lst) res)]
          [else (loop (tail lst) (cons (head lst) res))]))
  (loop lst '()))

(uniques* '(1 2 2 "iei" 1 3 "iei" 'oops))

; Решение 3: наивно, извикваме се за опашката и проверяваме
; дали главата се среща в резултата.
; Проблем: извикваме (uniques (tail lst)) два пъти (!)
(define (uniques** lst)
  (cond [(null? lst) '()]
        [(member (head lst) (uniques** (tail lst)))
         (uniques** (tail lst))]
        [else (cons (head lst) (uniques** (tail lst)))]))

(uniques** '(1 2 2 "iei" 1 3 "iei" 'oops))

(define (cons-if-not x lst)
  (if (member x lst) lst (cons x lst)))

; Решение 4: помощна функция, за да избегнем преизчисляване
(define (uniques*** lst)
  (if (null? lst) '()
      (cons-if-not (head lst) (uniques*** (tail lst)))))

(uniques*** '(1 2 2 "iei" 1 3 "iei" 'oops))

; (define (foldr op nv lst)
;   (if (null? lst) nv
;       (op (head lst) (foldr op nv lst))))

; Решение 5: fold :)
(define (uniques**** lst)
  (foldr cons-if-not '() lst))

(uniques**** '(1 2 2 "iei" 1 3 "iei" 'oops))

; Решение 6: филтрираме опашката, преди да се извикаме за нея
; Често срещан pattern: взимаме данните, даваме ги на една функция, резултатът подаваме на друга и т.н.
(define (uniques***** lst)
  (if (null? lst)
      '()
      (cons (head lst) (uniques*****
                        (filter (lambda (x) (not (equal? x (head lst))))
                                (tail lst))))))

(uniques***** '(1 2 2 "iei" 1 3 "iei" 'oops))

; Зад.2
; Модификация с приемане на предикат за сравнение по избор
(define (insert-by cmp val lst)
  (cond [(null? lst) (list val)]
        [(cmp val (head lst)) (cons val lst)]
        [else (cons (head lst) (insert-by cmp val (tail lst)))]))

; Зад.3
; Същата модификация
(define (insertion-sort cmp lst)
  (foldr (lambda (el res) (insert-by cmp el res)) '() lst))

; Зад.4
; Трудното тук е да идентифицираме всички малки подзадачки
; Лесното е, че те все пак са малки
(define (interval-length i)
  (- (cdr i) (car i)))

(define (sub-interval? i1 i2)
  (and (>= (car i1) (car i2))
       (<= (cdr i1) (cdr i2))))

(define (max-by-length is)
  (define (loop is res) ; стандартно обхождане с натрупване на най-добрият срещнат досега елемент
    (cond [(null? is) res]
          [(> (interval-length (head is)) (interval-length res))
           (loop (tail is) (head is))]
          [else (loop (tail is) res)]))
  (loop (tail is) (head is)))

; Алтернатива, сравняваща елементите на списък по резултата от върната функция за тях
(define (max-by* f lst)
  (foldr (lambda (el res)
           (if (> (f el) (f res)) el res))
         (head lst) ; взимаме първия елемент за "временен" максимум
         (tail lst)))

(define (longest-interval-subsets is)
  (let [(best (max-by-length is))] ; запазваме в локална променлива, за да не го преизчисляваме
    (insertion-sort
     (lambda (i1 i2) (< (car i1) (car i2)))
     (filter (lambda (i) (sub-interval? i best)) is))))

(longest-interval-subsets
  '((24 . 25) (90 . 110) (0 . 100) (10 . 109) (1 . 3) (-4 . 2)))

; Зад.5
(define (group-by f lst)
  ; събиране на всички стойности от lst, за които f връща val
  (define (matches val)
    (filter (lambda (x) (equal? (f x) val)) lst))
  (map (lambda (val) (list val (matches val)))
       (uniques (map f lst))))

(group-by even? '(1 2 3 4 5))
