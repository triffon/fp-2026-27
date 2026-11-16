#lang racket

; Ако служителят го няма в exps, считаме, че няма разходи.
(define (expenses-of exps name)
  (define maybe-pair (assoc name exps))
  (if (pair? maybe-pair) (cdr maybe-pair) '())
  )

; а)
(define (reimburse exps approve name)
  (apply + (map cdr (filter approve (expenses-of exps name))))
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
; По самия разход не можем да разберем в чии списъци се среща, затова hack-approve
; получава exps и approve и ламбдата, която връща, ги "запомня".
(define (hack-approve exps approve)
  (λ (e) (or (only-in? exps "Хачо" e) (approve e)))
  )

(define exps '(("Хачо" ("хотел" . 80) ("масаж" . 50) ("бар" . 500))
               ("Фичо" ("хотел" . 80) ("масаж" . 50) ("такси" . 40))))
(define (approve e) (and (not (equal? (car e) "масаж")) (< (cdr e) 100)))

(= (reimburse exps approve "Фичо") 120)                     ; хотел + такси
(= (reimburse exps approve "Хачо") 80)                      ; само хотел
(= (reimburse exps approve "Пичо") 0)                       ; няма такъв служител
(= (reimburse exps (hack-approve exps approve) "Хачо") 580) ; хотел + бар
(= (reimburse exps (hack-approve exps approve) "Фичо") 120) ; за Фичо нищо не се променя
