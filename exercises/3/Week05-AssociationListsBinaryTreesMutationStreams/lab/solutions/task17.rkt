#lang racket

(define our-cool-tree '(1 (2 () ())
                          (3 (4 () ())
                             (5 () ()))))

(define (root bt) (car bt))
(define (left-subtree bt) (cadr bt))
(define (right-subtree bt) (caddr bt))

; Обобщение на foldr за дървета: празното дърво дава nv, а всяко друго - f, приложена
; върху корена и върху вече "сгънатите" ляво и дясно поддърво. Това е идеята на accumulate
; от Седмица 3 - шаблонът "базов случай + рекурсия по структурата" е изнесен на едно място,
; а конкретната задача се описва само с f и nv.
(define (tree-fold f nv bt)
  (if (empty? bt)
      nv
      (f (root bt) (tree-fold f nv (left-subtree bt)) (tree-fold f nv (right-subtree bt)))
      )
  )

; Всяка от процедурите по-долу е на един ред - променяме само какво правим с корена
; и с резултатите от двете поддървета.
(define (size bt) (tree-fold (λ (x l r) (+ 1 l r)) 0 bt))

(define (height bt) (tree-fold (λ (x l r) (add1 (max l r))) 0 bt))

(define (sum-tree bt) (tree-fold + 0 bt))

(define (inorder bt) (tree-fold (λ (x l r) (append l (list x) r)) '() bt))

; Листо: и двете поддървета са дали празен списък листа - тогава листото е самият x.
(define (leaves bt) (tree-fold (λ (x l r) (if (and (empty? l) (empty? r)) (list x) (append l r))) '() bt))

; nv е '() и "строим" ново дърво със същата форма - l и r вече са преобразуваните поддървета.
(define (map-tree f bt) (tree-fold (λ (x l r) (list (f x) l r)) '() bt))

(= (size our-cool-tree) 5)
(= (height our-cool-tree) 3)
(= (sum-tree our-cool-tree) 15)
(equal? (inorder our-cool-tree) '(2 1 4 3 5))
(equal? (leaves our-cool-tree) '(2 4 5))
(equal? (map-tree add1 our-cool-tree) '(2 (3 () ())
                                          (4 (5 () ())
                                             (6 () ()))))
(= (size '()) 0)
(= (height '()) 0)
(= (sum-tree '()) 0)
(equal? (inorder '()) '())
(equal? (leaves '()) '())
(equal? (map-tree add1 '()) '())
