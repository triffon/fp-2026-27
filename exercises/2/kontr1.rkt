#lang racket
(define head car)
(define tail cdr)
(define (++ x) (+ x 1))

(define (prime? n)
  ; Инвариант: n не се дели на нито едно число измежду 2 и i-1, вкл.
  (define (loop i)
    (cond [(= i n) #t]
          [(= (remainder n i) 0) #f]
          [else (loop (+ i 1))]))
  ; Заб.: обработваме специалния случай за 1 извън цикъла,
  ; вместо да проверяваме за него на всяка итерация
  ;(if (= n 1) #f (loop 2))
  (and (> n 1) (loop 2)))

; Зад.1, двата варианта са аналогични
(define (removals n)
  (if (< n 10) '()
      (cons (quotient n 10)
            (map (lambda (k) (+ (* 10 k) (remainder n 10)))
                 (removals (quotient n 10))))))

(define (additions n)
  (if (= n 0) (list 1)
      (cons (+ (* 10 n) 1)
            (map (lambda (k) (+ (* 10 k) (remainder n 10)))
                 (additions (quotient n 10))))))

(define (special? n)
  (all? (lambda (x) (not (prime? x))) (additions n)))

(define (all? p? lst)
  ;(cond [(null? lst) #t]
  ;      [(p? (head lst)) (all? p? (tail lst))]
  ;      [else #f]))
  ; Декларативен стил: "предикатът е изпълнен за всички, ако списъкът е празен
  ; или предикатът е изпълнен и за главата, и за всички от опашката"
  (or (null? lst)
      (and (p? (head lst))
           (all? p? (tail lst)))))

(define (accumulate op nv a b term next)
  (if (> a b) nv
      (op (term a) (accumulate op nv (next a) b term next))))

(define (too-sus a b)
  (accumulate + 0
              a b
              (lambda (i) (if (special? i) 1 0))
              ++))

; Зад.3
(define (play-match draw res)
  (cond [(not (pair? draw)) draw]
        [(pair? (car draw)) (cons (play-match (car draw) res)
                                  (cdr draw))]
        [(pair? (cdr draw)) (cons (car draw)
                                  (play-match (cdr draw) res))]
        [else (if (> (car res) (cdr res)) (car draw) (cdr draw))]))

(define draw '((("Federer" . "Dimitrov") . ("Nadal" . "Murray")) .
               (("Djokovic" . "Medvedev") . ("Alcaraz" . "Sinner"))))

;(play-match draw '(2 . 3))

; Локалните дефиниции винаги са от помощ
(define (find-winner draw results)
  (let [(final (foldl (lambda (res x) (play-match x res))
                      draw
                      results))]
    (if (pair? final) #f final)))

(find-winner draw '((2 . 3) (3 . 1)))
(find-winner draw '((2 . 3) (3 . 1) (2 . 3) (3 . 0) (3 . 1) (2 . 3) (3 . 2)))

(define (is-in-tree? tree name)
  (if (pair? tree)
      (or (is-in-tree? (car tree) name)
          (is-in-tree? (car tree) name))
      (equal? tree name)))

(define (height tree)
  (if (pair? tree) (+ 1 (height (car tree))) 0))

; Сигурно има и по-красив начин...
(define (would-meet-in name1 name2 tree)
  (cond [(and (is-in-tree? name1 (car tree))
              (is-in-tree? name2 (cdr tree))) (height tree)]
        [(and (is-in-tree? name1 (cdr tree))
              (is-in-tree? name2 (car tree))) (height tree)]
        [(and (is-in-tree? name1 (car tree))
              (is-in-tree? name2 (car tree))) (would-meet-in name1 name2 (car tree))]
        [(and (is-in-tree? name1 (cdr tree))
              (is-in-tree? name2 (cdr tree))) (would-meet-in name1 name2 (cdr tree))]
        [else #f]))
