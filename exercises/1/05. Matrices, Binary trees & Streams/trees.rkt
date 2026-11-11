#lang racket

; Дърво тук ще дефинираме индуктивно:
; - '() е празното дърво;
; - ако T1 и T2 са дървета, а x е стойност, то (list x T1 T2) е дърво.

; Тогава за четимост и улеснение можем да въведем следните функции:

(define empty-tree '())
(define empty-tree? null?)

(define (mk-tree root left right) (list root left right))
(define (mk-leaf root) (mk-tree root empty-tree empty-tree))

(define get-root car)
(define get-left-subtree cadr)
(define get-right-subtree caddr)

(define (tree? t)
  (or (empty-tree? t)
      (and (list? t)
           (= (length t) 3)
           (tree? (get-left-subtree t))
           (tree? (get-right-subtree t)))))

; Ето няколко примерни дървета:

(define tree1 (mk-leaf 10))

(define tree2
  (mk-tree 2
           (mk-leaf 1)
           (mk-leaf 3)))

(define tree3
  (mk-tree 10
           (mk-tree 5
                    (mk-leaf 2)
                    empty-tree)
           (mk-leaf 15)))

(define tree4
    (mk-tree 20
             (mk-tree 10
                      (mk-leaf 5)
                      (mk-leaf 15))
             (mk-tree 30
                      (mk-leaf 25)
                      (mk-leaf 35))))

; Ето няколко примерни функции,
; които работят с дървета:

(define (count-nodes tree)
  (if (empty-tree? tree)
      0
      (+ 1
         (count-nodes (get-left-subtree tree))
         (count-nodes (get-right-subtree tree)))))

(define (min-tree-element tree)
  (if (empty-tree? tree)
      +inf.0
      (min
        (get-root tree)
        (min-tree-element (get-left-subtree tree))
        (min-tree-element (get-right-subtree tree)))))
