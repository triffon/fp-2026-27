#lang racket
(define empty-tree '())
(define (make-tree root left right) (list root left right))      ; не искаме просто (define make-tree list) - защо?
(define (make-leaf root) (make-tree root empty-tree empty-tree)) ; за удобство
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
(define empty-tree? null?)

(define test-tree
  (make-tree 10
             (make-tree 7
                        (make-leaf 10)
                        (make-leaf 2))
             (make-tree 3
                        (make-tree 4
                                   (make-leaf 1)
                                   (make-leaf 2))
                        empty-tree)))

; Зад.1
(define (height t)
  (if (empty-tree? t) 0
      (+ 1 (max (height (left-tree t))
                (height (right-tree t))))))

; Зад.2
(define (get-level n t)
  (cond [(empty-tree? t) '()]
        [(= n 0) (list (root-tree t))]
        [(append (get-level (- n 1) (left-tree t))
                 (get-level (- n 1) (right-tree t)))]))

; Зад.3*
; Един вариант за "кеширане" на стойности, за да ги преизползваме удобно: let
; Недостатък: if в let в if не е най-пригледна организация на кода
(define (find-longest-path t)
  (if (empty-tree? t) '()
      (cons (root-tree t)
            (let [(left (find-longest-path (left-tree t)))
                  (right (find-longest-path (right-tree t)))]
              (if (> (length left) (length right)) left right)))))

; Друг вариант: използване на помощна функция
; Недостатък (малък): "разчупва" последователността, в която четем кода, не винаги удобно.
(define (find-longest-path* t)
  (define (longer lst1 lst2)
    (if (> (length lst1) (length lst2)) lst1 lst2))
  (if (empty-tree? t) '()
      (cons (root-tree t)
            (longer (find-longest-path* (left-tree t))
                    (find-longest-path* (right-tree t))))))

; Зад.4
(define (tree-map f t)
  (if (empty-tree? t) empty-tree
      (make-tree (f (root-tree t))
                 (tree-map f (left-tree t))
                 (tree-map f (right-tree t)))))

; Зад.5
(define (tree->list t)
  (if (empty-tree? t) '()
      (append (tree->list (left-tree t))
              (list (root-tree t))
              (tree->list (right-tree t)))))

; Зад.6
; Винаги връщаме ново дърво, в което описваме какъв е коренът (в случая, новият винаги е старият),
; какво е новото ляво и какво е новото дясно поддърво.
; Това е декларативен стил на програмиране :)
(define (bst-insert val t)
  (cond [(empty-tree? t) (make-leaf val)]
        [(< val (root-tree t)) (make-tree (root-tree t)
                                          (bst-insert val (left-tree t))
                                          (right-tree t))]
        [else (make-tree (root-tree t)
                         (left-tree t)
                         (bst-insert val (right-tree t)))]))

; Зад.7
(define (tree-sort lst)
  (tree->list (foldl bst-insert empty-tree lst)))

; Зад.8
; "Канонично" решение, без ненужни допълнителни време/памет.
; Проста алтернатива: (sorted? (tree->list t))
(define (valid-bst? t)
  ; Инвариант: from и to са или числа, или стойността #f, представляваща безкрайност;
  ; функцията връща дали всички стойности са в интервала [from;to]
  (define (helper from to t)
    (or (empty-tree? t)
        (and (or (not from) (>= (root-tree t) from))
             (or (not to) (<= (root-tree t) to))
             (helper from (root-tree t) (left-tree t))
             (helper (root-tree t) to (right-tree t)))))
  (helper #f #f t))

; Зад.9
(define (prune t)
  (cond [(empty-tree? t) '()]
        [(and (empty-tree? (left-tree t))
              (empty-tree? (right-tree t))) '()]
        [else (make-tree (root-tree t)
                         (prune (left-tree t))
                         (prune (right-tree t)))]))

; Зад.10
(define (bloom t)
  ; Хубаво е да разпознаем удобството от такава помощна функция
  (define (helper x)
    (make-tree x (make-leaf x) (make-leaf x)))
  (cond [(empty-tree? t) '()]
        [(and (empty-tree? (left-tree t))
              (empty-tree? (right-tree t))) (helper (root-tree t))]
        [else (make-tree (root-tree t)
                         (bloom (left-tree t))
                         (bloom (right-tree t)))]))

; Зад.11*
; Наивно решение: за всяко дърво събираме всичките му стойности в списък, чийто минимум и максимум взимаме.
; Макар да извикваме tree->list по веднъж за всяко дърво, поддърветата се обхождат по повече от веднъж.
(define (avg t)
  (if (empty-tree? t) '()
      (let* [(vals (tree->list t))
             (minVal (apply min vals))
             (maxVal (apply max vals))]
        (make-tree (/ (+ minVal maxVal) 2)
                   (avg (left-tree t))
                   (avg (right-tree t))))))

; Решение: заедно с новото дърво връщаме минималната и максималната стойност в оригиналното дърво.
; Естествено, ако стойности няма, връщаме #f.
(define (avg* t)
  ; Помощни функции, смятащи min/max между две стойности, само втората от които може да е #f
  (define (min-#f x y) (if y (min x y) x))
  (define (max-#f x y) (if y (max x y) x))
  ; Връща списък с три елемента
  (define (helper t)
    (if (empty-tree? t) (list '() #f #f)
        (let* [(leftRes  (helper (left-tree t)))
               (rightRes (helper (right-tree t)))
               (newMin (min-#f (min-#f (root-tree t) (cadr leftRes)) (cadr rightRes)))
               (newMax (max-#f (max-#f (root-tree t) (caddr leftRes)) (caddr rightRes)))]
          (list (make-tree (/ (+ newMin newMax) 2)
                           (car leftRes)
                           (car rightRes))
                newMin
                newMax))))
  (car (helper t)))

(avg  test-tree)
(avg* test-tree)

; Зад.12*
(define (same-as-code t)
  ; Инвариант: code е числото, чието двоично представяне
  ; е пътят от корена на оригиналното дърво до текущия възел (корена на текущото дърво)
  (define (helper t code)
    (if (empty-tree? t) '()
        ; Във всички случаи връщаме и стойностите отляво, и тези отдясно,
        ; и при нужда добавяме корена в резултата
        (append (if (= (root-tree t) code) (list code) '())
                (helper (left-tree t) (* 2 code))
                (helper (right-tree t) (+ (* 2 code) 1)))))
  (helper t 1))

(same-as-code test-tree) ; '(3)
