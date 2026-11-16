#lang racket

; Ако служителят го няма в exps, считаме, че няма разходи.
(define (expenses-of exps name)
  (define maybe-pair (assoc name exps))
  (if (pair? maybe-pair) (cdr maybe-pair) '())
  )

; а)
(define (unapproved exps approve name)
  (filter (λ (e) (not (approve e))) (expenses-of exps name))
  )

; б)
; Разходът "присъства единствено" в списъка на name, ако е в неговия списък и в ничий друг.
; Сравняваме целите двойки (описание . сума) с member, т.е. с equal?.
(define (only-in? exps name e)
  (define others (filter (λ (pair) (not (equal? (car pair) name))) exps))
  (and (member e (expenses-of exps name))
       (not (ormap (λ (pair) (member e (cdr pair))) others)))
  )

; Новата функция трябва да има същия интерфейс като approve - приема само един разход.
; По самия разход не можем да разберем в чии списъци се среща, затова patch-approve
; получава exps и approve и ламбдата, която връща, ги "запомня".
(define (patch-approve exps approve)
  (λ (e) (and (not (only-in? exps "Фичо" e)) (approve e)))
  )

(define exps '(("Хачо" ("хотел" . 120) ("бар" . 500))
               ("Фичо" ("хотел" . 120) ("такси" . 40))))
(define (approve e) (or (equal? (car e) "хотел") (< (cdr e) 100)))

(equal? (unapproved exps approve "Фичо") '())
(equal? (unapproved exps approve "Хачо") '(("бар" . 500)))
(equal? (unapproved exps approve "Пичо") '())                                  ; няма такъв служител
(equal? (unapproved exps (patch-approve exps approve) "Фичо") '(("такси" . 40)))
(equal? (unapproved exps (patch-approve exps approve) "Хачо") '(("бар" . 500))) ; за Хачо нищо не се променя
