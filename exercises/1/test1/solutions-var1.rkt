#lang racket

; 01

(define (1+ x) (+ x 1))

(define (accumulate op nv a b term next)
  (if (> a b)
      nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (count-digits n)
  (cond [(< n 0) (count-digits (- n))]
        [(< n 10) 1]
        [else (+ 1 (count-digits (quotient n 10)))]))

(define (insert-digit-at digit pos n)
  (if (zero? pos)
      (+ (* n 10) digit)
      (+ (* (insert-digit-at digit (- pos 1) (quotient n 10)) 10)
         (remainder n 10))))

(define (prime? n)
  (and (>= n 2)
       (accumulate
         (λ (b1 b2) (and b1 b2))
         #t
         2
         (- n 1)
         (λ (x) (not (= (remainder n x) 0)))
         1+)))

(define (too-composite? n)
  (accumulate
    (λ (b1 b2)
      (and b1 b2))
    #t
    0
    (count-digits n)
    (λ (i) (not (prime? (insert-digit-at 1 i n))))
    1+))

(define (too-composite a b)
  (accumulate + 0 a b
              (λ (x)
                (if (too-composite? x)
                    1
                    0))
              1+))

; 02

(define exps '(("Хачо" ("хотел" . 80) ("масаж" . 50) ("бар" . 500))
                       ("Фичо" ("хотел" . 80) ("масаж" . 50) ("такси" . 40))))

(define (approve e) (and (not (equal? (car e) "масаж")) (< (cdr e) 100)))

(define (lookup key alist)
  (define result (filter (λ (kvp) (equal? key (car kvp))) alist))
  (and (not (null? result)) (cdar result)))

(define (reimburse exps approve name)
  (define exprenses (lookup name exps))
  (apply + (map cdr (filter approve exprenses))))

(define (flatten lst)
  (foldr append '() lst))

(define (hack-approve exps approve)
  (define hacho-exp-names (map car (lookup "Хачо" exps)))
  (define other-exp-names
    (map car (flatten (map cdr
      (filter (λ (kvp) (not (equal? (car kvp) "Хачо"))) exps)))))
  (λ (kvp)
    (if (and (member (car kvp) hacho-exp-names)
             (not (member (car kvp) other-exp-names)))
        #t
        (approve kvp))))


; 03

(define draw '((("Federer" . "Dimitrov") . ("Nadal" . "Murray")) .
                       (("Djokovic" . "Medvedev") . ("Alcaraz" . "Sinner"))))

(define (empty-tree? tree) (not (pair? tree)))
(define get-left-subtree car)
(define get-right-subtree cdr)

(define (height tree)
  (if (empty-tree? tree)
      1
      (+ 1 (max (height (get-left-subtree tree))
                (height (get-right-subtree tree))))))

(define (has-path-to? x tree)
  (if (empty-tree? tree)
      (equal? x tree)
      (or (has-path-to? x (get-left-subtree tree))
          (has-path-to? x (get-right-subtree tree)))))

(define (would-meet-in p1 p2 draw)
  (cond [(empty-tree? draw) #f]
        [(or (and (has-path-to? p1 (get-left-subtree draw))
                  (has-path-to? p2 (get-right-subtree draw)))
             (and (has-path-to? p2 (get-left-subtree draw))
                  (has-path-to? p1 (get-right-subtree draw))))
         (- (height draw) 1)]
        [else (or
                (would-meet-in p1 p2 (get-left-subtree draw))
                (would-meet-in p1 p2 (get-right-subtree draw)))]))

(define (tree->list tree)
  (if (empty-tree? tree)
      (list tree)
      (append (tree->list (get-left-subtree tree))
              (tree->list (get-right-subtree tree)))))

(define (opponents-in-round p n draw)
  (filter (λ (p2)
            (let ([round (would-meet-in p p2 draw)])
              (and round (= round n))))
          (tree->list draw)))
