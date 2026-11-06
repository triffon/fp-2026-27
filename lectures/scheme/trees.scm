(define empty-tree '())
(define (leaf x) (list x empty-tree empty-tree))
(define make-tree list)

(define empty-tree? null?)
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)

(define (tree? x)
  (or (null? x) (and (list? x) (= (length x) 3) (tree? (cadr x)) (tree? (caddr x)))))

(define (make-safe f p?)
  (lambda (x)
    (and (p? x) (f x))))

(define t (make-tree 1 (leaf 2) (make-tree 3 (leaf 4) (leaf 5))))

(define safe-root-tree (make-safe root-tree tree?))

(define (depth-tree t)
  (if (empty-tree? t) 0
      (+ 1 (max (depth-tree (left-tree t)) (depth-tree (right-tree t))))))

(define (member-tree? x t)
  (if (empty-tree? t) #f
      (if (equal? x (root-tree t)) #t
          (or (member-tree? x (left-tree t))
              (member-tree? x (right-tree t))))))

(define (member-tree? x t)
  (and (not (empty-tree? t))
       (or (equal? x (root-tree t))
           (member-tree? x (left-tree t))
           (member-tree? x (right-tree t)))))

(define (member-tree x t)
  (and (not (empty-tree? t))
       (or (and (equal? x (root-tree t)) t)
           (member-tree x (left-tree t))
           (member-tree x (right-tree t)))))

(define (path-tree x t)
  (and (not (empty-tree? t))
       (or (and (equal? x (root-tree t)) (list x))
           (safe-cons (root-tree t) (or (path-tree x (left-tree t))
                                        (path-tree x (right-tree t)))))))

(define (safe-cons h t) (and t (cons h t)))
