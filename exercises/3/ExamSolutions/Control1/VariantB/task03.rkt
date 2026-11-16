#lang racket

(define (leaf? draw) (string? draw))
(define (left-subtree draw) (car draw))
(define (right-subtree draw) (cdr draw))
(define (make-draw left right) (cons left right))

(define (height draw)
  (if (leaf? draw) 0 (add1 (max (height (left-subtree draw)) (height (right-subtree draw)))))
  )

; Следващата среща е бащата на най-лявото най-дълбоко листо. Брат му също е листо - ако беше
; двойка, щеше да има по-дълбоко листо. Най-лявото най-дълбоко листо е в лявото поддърво точно
; когато то е поне толкова високо, колкото дясното - натам и слизаме.
; Схемата е неизменима, затова строим нов възел на всяка стъпка по пътя до срещата.
(define (play-match draw result)
  (define (winner match)
    (if (> (car result) (cdr result)) (left-subtree match) (right-subtree match))
    )
  (cond
    [(leaf? draw) draw] ; турнирът е приключил - няма какво да се играе
    [(= (height draw) 1) (winner draw)]
    [(>= (height (left-subtree draw)) (height (right-subtree draw)))
     (make-draw (play-match (left-subtree draw) result) (right-subtree draw))]
    [else (make-draw (left-subtree draw) (play-match (right-subtree draw) result))]
    )
  )

; Бонус
; foldl подава първо елемента (резултата), а после натрупаната стойност (схемата),
; затова обръщаме реда на аргументите на play-match в ламбдата.
; Турнирът е приключил точно когато от схемата е останало само едно листо - победителят.
(define (find-winner draw results)
  (define final-draw (foldl (λ (result acc) (play-match acc result)) draw results))
  (if (leaf? final-draw) final-draw #f)
  )

(define draw '((("Federer" . "Dimitrov") . ("Nadal" . "Murray")) .
               (("Djokovic" . "Medvedev") . ("Alcaraz" . "Sinner"))))

(equal? (play-match draw '(2 . 3))
        '(("Dimitrov" . ("Nadal" . "Murray")) .
          (("Djokovic" . "Medvedev") . ("Alcaraz" . "Sinner"))))
(equal? (play-match (play-match draw '(2 . 3)) '(3 . 1))
        '(("Dimitrov" . "Nadal") .
          (("Djokovic" . "Medvedev") . ("Alcaraz" . "Sinner"))))
(equal? (play-match '("A" . ("B" . "C")) '(0 . 3)) '("A" . "C")) ; "A" почива в кръг 1

(equal? (find-winner draw '((2 . 3) (3 . 1))) #f)
(equal? (find-winner draw '((2 . 3) (3 . 1) (2 . 3) (3 . 0) (3 . 1) (2 . 3) (3 . 2))) "Dimitrov")
(equal? (find-winner draw '()) #f)
