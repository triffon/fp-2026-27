#lang racket


(define (add-one-list n)
  (define (helper i)
    (if (> i n) (list (+ n i))
      (cons (+ (* (+ 1 (* (quotient n i) 10)) i) (remainder n i))
            (helper (* i 10)))))
  (helper 1))

(define (prime? n)
   (define (helper i)
  (if (>= i n) #t
      (if (zero? (remainder n i)) #f
          (helper (+ i 1)))))
  (if (< n 2)
      #f
      (helper 2)))

(define (is-too-composite? n)
  (null? (filter prime? (add-one-list n))))
  

(define (accumulate operation null-value begin end term next)
  (if (> begin end) null-value
      (operation (term begin)
                 (accumulate operation null-value (next begin) end term next))))

(define (++ x) (+ x 1))

(define (too-composite a b)
  (accumulate (lambda (term res) (if term (++ res) res)) 0 a b is-too-composite?  ++))

; zadacha 2
 (define exps '(("Хачо" ("хотел" . 80) ("масаж" . 50) ("бар" . 500))
                       ("Фичо" ("хотел" . 80) ("масаж" . 50) ("такси" . 40))))
(define (approve e) (and (not (equal? (car e) "масаж")) (< (cdr e) 100)))

(define (get-exps exps name)
  (if (null? exps) '()
      (if (equal? (caar exps) name)
          (cdar exps)
          (get-exps (cdr exps) name))))
          

(define (reimburse exps approve name)
  (foldr (lambda (elem res) (if (approve elem) (+ res (cdr elem)) res)) 0 (get-exps exps name)))

(define (member? l x)
  (foldr (lambda (elem res) (or (equal? elem x) res)) #f l))

(define (only-of? exps e name)
  (and (member? (get-exps exps name) e)
      (not (foldr (lambda (elem res) (if (not (equal? (car elem) name)) (or (member? (cdr elem) e) res)  res)) #f exps))))

(define (hack-approve exps approve)
  (lambda (e) (if (only-of? exps e "Хачо") #t (approve e))))

; zadacha 3
(define (tree? t)
  (or (null? t)
      (and (list? t)
           (= (length t) 3))
           (tree? (cadr t))
           (tree? (caddr t))))
(define empty-tree '())
(define (make-tree left right) (list left right))      
(define (make-leaf root) root)
; (define root-tree car)
(define left-tree car)
(define right-tree cdr)
(define empty-tree? null?)


(define draw '((("Federer" . "Dimitrov") . ("Nadal" . "Murray")) .
                       (("Djokovic" . "Medvedev") . ("Alcaraz" . "Sinner"))))



(define (get-path draw p1)
  (cond [(and (not (pair? draw)) (equal? draw p1)) (list p1)]
        [(not (pair? draw)) #f]
        [(get-path (left-tree draw) p1) (cons "left" (get-path (left-tree draw) p1))]
        [(get-path (right-tree draw) p1) (cons "right" (get-path (right-tree draw) p1))]
        [else #f]))

(define (get-common-prefix path1 path2)
  (if (or (null? path1) (null? path2)) '()
      (if (equal? (car path1) (car path2))
          (cons (car path1) (get-common-prefix (cdr path1) (cdr path2)))
          '())))

(define (depth draw)
   (if (not (pair? draw)) 0
       (+ 1 (max (depth (left-tree draw)) (depth (right-tree draw))))))

(define (would-meet-in p1 p2 draw)
  (let ([path1 (get-path draw p1)]
        [path2 (get-path draw p2)])
    (if (and path1 path2)
        (- (depth draw) (length (get-common-prefix path1 path2)))
        #f)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (in-tree? t el)
  (if (not (cons? t)) (equal? el t)
      (or (in-tree? (car t) el)(in-tree? (cdr t) el)
          )))
(define (depth-tree t) (if (not (cons? t)) 0 (1+ (max (depth-tree (car t))(depth-tree (cdr t))))))

(define (both-in-tree? t p1 p2)
  (and (in-tree? t p1) (in-tree? t p2)))

(define (would-meet-in2 p1 p2 draw)
  (if (not (cons? draw)) #f
      (if (would-meet-in p1 p2 (car draw)) 
          (would-meet-in p1 p2 (car draw))
          (if (would-meet-in p1 p2 (cdr draw))
              (would-meet-in p1 p2 (cdr draw))
              (if (both-in-tree? draw p1 p2)
                  (depth-tree draw)
                  #f
                  ))))

  
