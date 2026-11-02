#lang racket

; Двоично дърво представяме като списък от три елемента:
;   (<корен> <ляво поддърво> <дясно поддърво>)
; Празното дърво е празният списък '(). Листо е дърво с две празни поддървета.
;
;        1
;       / \          '(1 (2 () ())
;      2   3    <->      (3 (4 () ())
;         / \               (5 () ())))
;        4   5

; Конструктори - единственият начин, по който "строим" дървета.
(define empty-binary-tree '())
(define (make-tree root left right) (list root left right))

; Селектори - единственият начин, по който "разглобяваме" дървета.
; Така кодът ни не зависи от конкретното представяне: ако утре решим да
; сменим списъка с нещо друго, трябва да пипнем само тези няколко реда.
(define (root bt) (car bt))
(define (left-subtree bt) (cadr bt))
(define (right-subtree bt) (caddr bt))

; Листо: непразно дърво, чиито две поддървета са празни.
(define (leaf? bt)
  (and (not (empty? bt)) (empty? (left-subtree bt)) (empty? (right-subtree bt)))
  )

; Проверка дали стойността изобщо е двоично дърво според представянето ни:
; или е празна, или е списък с точно три елемента, чиито второ и трето
; поддърво също са двоични дървета (рекурсивна дефиниция).
(define (binary-tree? t)
  (or (empty? t)
      (and (list? t) (= (length t) 3) (binary-tree? (left-subtree t)) (binary-tree? (right-subtree t))))
  )

; Едно и също дърво, построено по двата начина:
(define our-cool-tree '(1 (2 () ())
                          (3 (4 () ())
                             (5 () ()))))

(define our-cool-tree-2
  (make-tree 1
             (make-tree 2 empty-binary-tree empty-binary-tree)
             (make-tree 3
                        (make-tree 4 empty-binary-tree empty-binary-tree)
                        (make-tree 5 empty-binary-tree empty-binary-tree))))

(equal? our-cool-tree our-cool-tree-2) ; #t

(root our-cool-tree)                        ; 1
(left-subtree our-cool-tree)                ; '(2 () ())
(right-subtree our-cool-tree)               ; '(3 (4 () ()) (5 () ()))
(root (right-subtree our-cool-tree))        ; 3
(left-subtree (left-subtree our-cool-tree)) ; '() - под 2 няма нищо

(leaf? (left-subtree our-cool-tree)) ; #t - 2 е листо
(leaf? our-cool-tree)                ; #f
(leaf? '())                          ; #f - празното дърво не е листо

(binary-tree? our-cool-tree)   ; #t
(binary-tree? '())             ; #t - празното дърво също е дърво
(binary-tree? '(1 (2 ()) ()))  ; #f - лявото поддърво има само два елемента
(binary-tree? '(1 2 3))        ; #f - 2 и 3 не са дървета

; Почти всяка процедура върху дървета следва един и същ шаблон:
;  - базов случай: празното дърво;
;  - рекурсивен случай: правим нещо с корена и се обаждаме за двете поддървета.
(define (size bt)
  (if (empty? bt)
      0
      (+ 1 (size (left-subtree bt)) (size (right-subtree bt)))
      )
  )

(size our-cool-tree) ; 5

; Когато за дадена стойност няма смислен резултат (напр. коренът на празно
; дърво), спираме с грешка: error приема съобщение и прекъсва изпълнението.
(define (safe-root bt)
  (if (empty? bt)
      (error "safe-root: the tree is empty")
      (root bt)
      )
  )

(safe-root our-cool-tree) ; 1
; (safe-root '())         ; грешка: safe-root: the tree is empty
