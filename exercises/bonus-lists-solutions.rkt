#lang racket
(define head car)
(define tail cdr)

; Множества, пермутации, комбинации
; Зад.1
(define (subsets lst)
  (if (null? lst) '(()) ; валиден случай, единственото подмножество е празното (2^0=1)
      (let [(rest (subsets (tail lst)))]
        (append rest (map (lambda (l) (cons (head lst) l)) rest)))))

(subsets '(1 2 3))

; Зад.2
(define (rotations lst)
  (define (rotate lst)
    (append (tail lst) (list (head lst))))
  ; Инвариант: връща k на брой ротации на lst
  (define (helper lst k)
    (if (= k 0) '()
        (cons lst (helper (rotate lst) (- k 1)))))
  (helper lst (length lst)))

(rotations '(1 2 3 4 5))

; Зад.3
(define (permutations lst)
  (define (helper r)
    (map (lambda (p) (cons (head r) p)) (permutations (tail r))))
  (if (null? lst) '(()) ; валиден случай, единствена пермутация (0!=1)
      (apply append (map helper (rotations lst)))))

(permutations '(1 2 3))

; Зад.4
(define (combinations k lst)
  (cond [(= k 0) '(())]   ; валиден случай, единствена комбинация ((n над 0)=1)
        [(null? lst) '()] ; невалиден случай, няма какво да вземем от празен списък
        [else (append (map (lambda (c) (cons (head lst) c)) ; (n над k) = (n-1 над k-1) + (n-1 над k)
                           (combinations (- k 1) (tail lst)))
                      (combinations k (tail lst)))]))

(combinations 2 '(1 2 3 4 5))

; Автомати и низове
(define a1 ; (ba)*
  (list (list (cons (cons 'A #\b) 'B)
              (cons (cons 'B #\a) 'A))
        'A
        (list 'A)))

; Зад.5
(define (apply-delta delta state symb)
  (let [(x (assoc (cons state symb) delta))]
    (if x (cdr x) #f))) ; това е (cdr <$> x) :)

(and (equal? 'A (apply-delta (head a1) 'B #\a))
     (not (apply-delta (head a1) 'B #\m)))

; Зад.6
(define (accepts? automaton word)
  ; За низове е по-естествено да итерираме по индекса на следващия символ,
  ; тъй като той се достъпва за константно време (за разлика от списъците).
  (define (helper state k)
    (if (= k (string-length word))
        (not (not (member state (caddr automaton)))) ; като !!x в C++ за "конвертиране" до boolean
        (let [(next (apply-delta (car automaton) state (string-ref word k)))]
          (if next (helper next (+ k 1)) #f))))
  (helper (cadr automaton) 0))

(and (accepts? a1 "baba")
     (not (accepts? a1 "bad")))

; Префиксни дървета
; Заб.: така дефинираното дърво не поддържа добавяне на дума, префикс на някоя друга!
; За да се постигне, трябва допълнителен флаг във всеки възел (вдигнат в листата)...
(define t1
  (list (cons #\b (list (cons #\a (list (cons #\b (list (cons #\a '())))))
                        (cons #\o (list (cons #\b (list (cons #\o '())))))))
        (cons #\d (list (cons #\a '())))))

; Дали елементите на списък са сортирани по даден предикат
(define (sorted? p? lst)
  (or (null? lst)
      (null? (tail lst))
      (and (p? (head lst) (head (tail lst)))
           (sorted? p? (tail lst)))))

; За удобство
(define (trie? t)
  (and (list? t)
       (andmap (lambda (p) (and (pair? p) (char? (car p)) (trie? (cdr p)))) t) ; andmap е нашето all?
       (sorted? char<? (map head t))))

; Зад.7
(define (trie-accepts? trie word)
  ; Отново итерация по k-тия символ на дадената дума
  (define (helper t k)
    (if (= k (string-length word))
        (null? t)
        ; assoc ще върне правилен резултат и за празното дърво, няма нужда от отделен случай
        (let [(x (assoc (string-ref word k) t))]
          (if x (helper (cdr x) (+ k 1)) #f))))
  (helper trie 0))

(and (trie-accepts? t1 "baba")
     (not (trie-accepts? t1 "bad")))

; Зад.8
; Поддържа лексикографската наредба на символите (ключовете) в дадено дърво (асоциативен списък).
; Ако не го правихме, бихме имали много по-просто решение, ползващо assoc за търсене и cons за добавяне при неуспех.
(define (trie-add word trie)
  ; Едновременно обхожда текущия асоциативен списък t, за да добави нова двойка ключ-стойност на правилното място,
  ; и низа символ по символ. Не е итеративен процес, т.к. връща нов списък (т.е. дърво)
  (define (helper t k)
    (cond [(= k (string-length word)) '()]
          ; текущият символ от word е по-голям от всички в списъка
          [(null? t) (list (cons (string-ref word k) (helper '() (+ k 1))))]
          ; намерили сме правилното място за текущия символ в списъка
          [(char<? (string-ref word k) (caar t)) (cons (cons (string-ref word k) (helper '() (+ k 1)))
                                                       t)]
          ; текущият символ вече присъства в списъка
          [(char=? (string-ref word k) (caar t)) (cons (cons (caar t) (helper (cdar t) (+ k 1)))
                                                       (cdr t))]
          ; продължаваме да търсим правилното място на текущия символ в опашката на списъка
          [else (cons (car t) (helper (cdr t) k))]))
  (helper trie 0))

(define (words->trie words) (foldl trie-add '() words))

; Зад.9
(define (trie->words trie)
  (if (null? trie) '("") ; празният низ
      (apply append
             (map (lambda (p)
                    (map (lambda (w) (string-append (string (car p)) w))
                         (trie->words (cdr p))))
                  trie))))

; Зад.10
; Заб.: работи само ако никоя дума в words не е префикс на някоя друга дума
(define (string-sort words) (trie->words (words->trie words)))

(define t2 (words->trie '("baba" "foo" "bad")))
(equal? t2 '((#\b (#\a (#\b (#\a)) (#\d))) (#\f (#\o (#\o)))))
(and (trie? t1) (trie? t2))
(and (trie-accepts? t2 "baba")
     (trie-accepts? t2 "bad")
     (trie-accepts? t2 "foo")
     (not (trie-accepts? t2 "ba"))
     (not (trie-accepts? t2 "baddd"))
     (not (trie-accepts? t2 "fooo")))
(and (equal? (trie->words t1) '("baba" "bobo" "da"))
     (equal? (trie->words t2) '("baba" "bad" "foo")))
(equal? (string-sort '("abc" "test" "abab" "xyz" "check"))
        '("abab" "abc" "check" "test" "xyz"))
