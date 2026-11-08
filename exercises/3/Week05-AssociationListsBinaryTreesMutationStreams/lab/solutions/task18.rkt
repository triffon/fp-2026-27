#lang racket

(define our-cool-tree '(1 (2 () ())
                          (3 (4 () ())
                             (5 () ()))))

(define (root bt) (car bt))
(define (left-subtree bt) (cadr bt))
(define (right-subtree bt) (caddr bt))

(define (make-tree root left right) (list root left right))

; От Задача 6.
(define (inorder bt)
  (if (empty? bt)
      '()
      (append (inorder (left-subtree bt)) (list (root bt)) (inorder (right-subtree bt)))
      )
  )

; Вмъкване в двоично наредено дърво: по-малките отиват наляво, по-големите и равните - надясно.
; Дървото е неизменимо, затова "променяме" само пътя от корена до новото листо и строим нов възел на всяка стъпка.
(define (bst-insert x bt)
  (cond
    [(empty? bt) (make-tree x '() '())]
    [(< x (root bt)) (make-tree (root bt) (bst-insert x (left-subtree bt)) (right-subtree bt))]
    [else (make-tree (root bt) (left-subtree bt) (bst-insert x (right-subtree bt)))]
    )
  )

; foldl подава елемента и натрупаната стойност точно в реда (x, дърво), който bst-insert очаква.
(define (list->bst xs)
  (foldl bst-insert '() xs)
  )

; Сортиране "безплатно": inorder на двоично наредено дърво е сортираният списък.
(define (tree-sort xs)
  (inorder (list->bst xs))
  )

(define (sorted? xs)
  (or (< (length xs) 2)
      (and (<= (car xs) (cadr xs)) (sorted? (cdr xs))))
  )

; Двоично наредено е точно това дърво, чийто inorder е сортиран.
(define (bst? bt)
  (sorted? (inorder bt))
  )

; Алтернативно решение: всеки елемент трябва да е в интервала [low, high), който се стеснява, докато слизаме -
; наляво горната граница става коренът, надясно долната граница става коренът (равните са надясно).
(define (bst-bounds? bt)
  (define (helper bt low high)
    (or (empty? bt)
        (and (<= low (root bt))
             (< (root bt) high)
             (helper (left-subtree bt) low (root bt))
             (helper (right-subtree bt) (root bt) high)))
    )
  (helper bt -inf.0 +inf.0)
  )

(equal? (list->bst '(5 2 8)) '(5 (2 () ()) (8 () ())))
(equal? (tree-sort '(5 2 8 1 9 3)) '(1 2 3 5 8 9))
(equal? (tree-sort '(91.2 90.5 92.1 90.9)) '(90.5 90.9 91.2 92.1))
(equal? (tree-sort '(3 1 3 2 1)) '(1 1 2 3 3))
(equal? (tree-sort '()) '())
(equal? (bst? our-cool-tree) #f)
(equal? (bst? (list->bst '(5 2 8 1 9 3))) #t)
(equal? (bst? '()) #t)
(equal? (bst-bounds? our-cool-tree) #f)
(equal? (bst-bounds? (list->bst '(5 2 8 1 9 3))) #t)
(equal? (bst-bounds? (list->bst '(3 1 3 2 1))) #t)
(equal? (bst-bounds? '()) #t)
