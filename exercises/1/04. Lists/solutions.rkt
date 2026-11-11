#lang racket

; ВАЖНО: ако използвате racket вместо r5rs,
; е възможно вградената дефиниция на foldl
; да ви shadow-не тази, която дефинирате.
; при нея операцията първо приема елемент
; и след това натрупаната стойност, за
; разлика от долната дефиниция и тази,
; която сте писали на лекции. затова
; е именована my-foldl

; 00. Да се дефинират функциите foldl, foldr, map и filter.
(define (my-foldl op nv lst)
  (if (null? lst)
      nv
      (my-foldl op (op nv (car lst)) (cdr lst))))

(define (my-foldr op nv lst)
  (if (null? lst)
      nv
      (op (car lst) (my-foldr op nv (cdr lst)))))

(define (my-map f lst)
  (my-foldr (lambda (x xs) (cons (f x) xs)) '() lst))

(define (my-filter p? lst)
  (my-foldr (lambda (x xs) (if (p? x) (cons x xs) xs)) '() lst))

; 01. Да се дефинира функция, която намира дължината на списък.

; Пример: (len '(1 2 3)) ~> 3
(define (len lst)
  (if (null? lst)
      0
      (+ 1 (len (cdr lst)))))

(define (len* lst)
  (my-foldr (lambda (_ xs) (+ 1 xs)) 0 lst))

; 02. Да се дефинира функция, която намира елемента на даден индекс.
; Ако няма елемент на този индекс, да се върне #f.

; Пример: (at '(10 20 30) 1) ~> 20
(define (at lst idx)
  (cond [(null? lst) #f]
        [(zero? idx) (car lst)]
        [else (at (cdr lst) (- idx 1))]))


; 03. Да се дефинират дуалните функции take и drop, които
; съответно взимат или пропускат първите n елемента на списък.

; Пример: (my-take 2 '(1 2 3 4)) ~> '(1 2)
(define (my-take n lst)
  (if (or (zero? n) (null? lst))
      '()
      (cons (car lst) (my-take (- n 1) (cdr lst)))))

; Пример: (my-drop 2 '(1 2 3 4)) ~> '(3 4)
(define (my-drop n lst)
  (if (or (zero? n) (null? lst))
      lst
      (my-drop (- n 1) (cdr lst))))

; Бонус: Да се дефинират функциите take-while и drop-while,
; които приемат предикати вместо индекси.

; Пример: (take-while even? '(2 4 5 6)) ~> '(2 4)
(define (take-while p? lst)
  (cond [(null? lst) lst]
        [(p? (car lst)) (cons (car lst) (take-while p? (cdr lst)))]
        [else '()]))

; Пример: (drop-while even? '(2 4 5 6)) ~> '(5 6)
(define (drop-while p? lst)
  (cond [(null? lst) lst]
        [(p? (car lst)) (drop-while p? (cdr lst))]
        [else lst]))


; 04. Да се напише функция splitAt, която разделя списък на две
; части спрямо подаден индекс.

; Пример: (split-at 2 '(1 2 3 4)) ~> '((1 2) (3 4))
(define (split-at n lst)
  (list (my-take n lst) (my-drop n lst)))

; Забележете, че тук връщаме СПИСЪК от два списъка
; (list l1 l2), а не наредена двойка (cons l1 l2).
; Затова трябва да използваме cadr вместо само cdr
(define (split-at* n lst)
  (if (or (null? lst) (zero? n))
      (list '() lst)
      (let* ([rest (split-at* (- n 1) (cdr lst))]
             [lhs (car rest)]
             [rhs (cadr rest)])
        (list (cons (car lst) lhs) rhs))))

; 05. Да се дефинира функция, която слепя два списъка.

; Пример: (my-append '(1 2) '(3 4)) ~> '(1 2 3 4)
(define (my-append lst1 lst2)
  (if (null? lst1)
      lst2
      (cons (car lst1) (my-append (cdr lst1) lst2))))

(define (my-append* lst1 lst2)
  (my-foldr cons lst2 lst1))

; 06. Да се дефинира функция, която обръща реда на елементите на списък.

; Пример: (my-reverse '(1 2 3)) ~> '(3 2 1)
(define (my-reverse lst)
  (if (null? lst)
      lst
      (my-append (my-reverse (cdr lst)) (list (car lst)))))

(define (flip f)
  (lambda (y x) (f x y)))

(define (my-reverse* lst)
  (my-foldr cons '() lst))

(define (my-reverse** lst)
  (my-foldl (flip cons) '() lst))

; 07. Да се дефинира функция, която премахва всички повторения в списък.

; Пример: (unique '(1 2 1 3 2)) ~> '(1 2 3)
(define (unique lst)
  (foldr (lambda (x xs)
           (if (member x xs)
               xs
               (cons x xs)))
         '()
         lst))

(define (unique* lst)
  (foldl (lambda (xs x)
           (if (member x xs)
               xs
               (cons x xs)))
         '()
         lst))


; 08. Да се дефинира функция, която премахва всички последователни повторения в списък.

; Пример: (compress '(1 1 2 2 2 3 1 1)) ~> '(1 2 3 1)

; по-оптимално е да използваме foldr, защото
; така ще трябва да взимаме първия елемент
; от натрупания резултат. за разлика от това,
; при foldl бихме взимали последния такъв
(define (compress lst)
  (my-foldr (lambda (x xs)
           (if (and
                 (not (null? xs))
                 (equal? (car xs) x))
               xs
               (cons x xs)))
         '()
         lst))


; 09. Да се дефинира функция, която за всеки елемент от списък намира минималния
; елемент вляво от него.

; Пример: (left-min '(5 3 4 1 2)) ~> '(5 3 3 1 1)
(define (last lst)
  (cond [(null? lst) #f]
        [(null? (cdr lst)) (car lst)]
        [else (last (cdr lst))]))

(define (snoc x lst)
  (append lst (list x)))

(define (left-min lst)
  (if (null? lst)
      lst
      (my-foldl (lambda (xs x)
               (snoc (min x (last xs)) xs))
             (list (car lst))
             (cdr lst))))


; 10. Да се дефинира функция, която проверява дали елемент е част от списък.
; Ако е, да се върне свидетел за това (елементът + останалата част от списъка).

; Пример: (member* 3 '(1 2 3 4 5)) ~> '(3 4 5)
(define (member* el lst)
  (define result (my-foldl (lambda (xs x)
                          (if (or
                                (not (null? xs))
                                (equal? el x))
                              (snoc x xs) ; вместо snoc може cons + reverse накрая
                              xs))
                        '()
                        lst))
  (and (not (null? result)) result))


; 11. Да се дефинират функциите forall? и exists?.

; Пример: (my-forall? even? '(2 4 6)) ~> #t
(define (my-forall? p? lst)
  (my-foldl (lambda (xs x)
              (and xs (p? x)))
              #t
              lst))

; Пример: (my-exists? even? '(1 3 6)) ~> #t
(define (my-exists? p? lst)
  (my-foldl (lambda (xs x)
              (or xs (p? x)))
            #f
            lst))


; 12. Да се дефинира функция, която сортира списък по алгоритъм
; по ваш избор.

; Пример: (my-sort '(3 1 4 1 5 9)) ~> '(1 1 3 4 5 9)
(define (my-sort lst)
  (if (null? lst)
      lst
      (append (my-sort (filter (λ (x) (<= x (car lst))) (cdr lst)))
              (list (car lst))
              (my-sort (filter (λ (x) (> x (car lst))) (cdr lst))))))

; Бонус: Да се дефинира сортираща функция, която приема двуместен предикат,
; който определя дали първият елемент е по-малък от втория.

; Пример: (my-sort-by < '(3 1 4 1 5 9)) ~> '(1 1 3 4 5 9)
(define (my-sort-by pred? lst)
  (if (null? lst)
      lst
      (append (my-sort-by pred? (filter (λ (x) (pred? x (car lst))) (cdr lst)))
              (list (car lst))
              (my-sort-by pred? (filter (λ (x) (not (pred? x (car lst)))) (cdr lst))))))


; 13. Да се дефинира функция maximum-by, която намира най-големият
; елемент в списък по подадена функция.

; Пример: (maximum-by string-length '("a" "abc" "ab")) ~> "abc"
(define (maximum-by f lst)
  (define sort-f (lambda (x y) (> (f x) (f y))))
  (define result (my-sort-by sort-f lst))
  (and (not (null? result)) (car result)))


; 14. Да се дефинира функция group-by, която група последователни
; елементи в списък на база някакъв предикат.

; Пример: (group-by = '(1 1 2 3 3 3 2)) ~> '((1 1) (2) (3 3 3) (2))

(define (my-span p? lst)
  (list (take-while p? lst) (drop-while p? lst)))

; може и с функции от по-висок ред, но е досадно
(define (my-group-by pred? lst)
  (if (null? lst)
      lst
      (let* ([head (car lst)]
             [partitioned (my-span (lambda (x) (pred? x head)) lst)]
             [lhs (car partitioned)]
             [rhs (cadr partitioned)])
        (cons lhs (my-group-by pred? rhs)))))

; 15. Да се дефинират функциите insert, remove и lookup за
; асоциативни списъци.
(define assoc-list
  (list
    (cons 1 "a")
    (cons 2 "b")
    (cons 3 "c")
    (cons 4 "d")))

(define (insert key value assoc-list)
  (cons (cons key value)
        (my-filter (lambda (kvp)
                     (not (equal? key (car kvp))))
                   assoc-list)))

(define (remove key assoc-list)
  (filter (lambda (kvp) (not (equal? key (car kvp)))) assoc-list))

(define (remove* key assoc-list)
  (cdr (insert key 'dummy-value assoc-list)))

(define (lookup key assoc-list)
  (define result (filter (lambda (kvp) (equal? key (car kvp))) assoc-list))
  (and (not (null? result)) (cdar result)))

; 16. Да се дефинира функция, която връща асоциативен списък
; с ключове елементите на списък и стойности броя срещания
; на всеки елемент.
(define (hist lst)
  (define sorted (my-sort lst))
  (define grouped (my-group-by = sorted))
  (my-map (lambda (group) (cons (car group) (length group))) grouped))

; 17. Да се дефинира функция, която слива два асоциативни списъка.
(define (merge lhs rhs)
  (foldr (lambda (kvp xs)
           (let ([key (car kvp)]
                 [value (cdr kvp)])
             (insert key value xs)))
         lhs
         rhs))
