#lang racket

(sort '(1 3 2) >)

(apply + '(1 2 3 4 5))

(map (λ (x) (* x 2)) '(1 2 3 4 5))
(map add1 '(1 2 3 4 5))

(filter even? '(1 2 3 4 5))
(filter (λ (x) (zero? (remainder x 3))) '(0 1 2 3 4 5 6))

; Вградените в Racket foldl и foldr:
;
; (foldl op nv '(x1 x2 ... xn)) = (op xn (... (op x2 (op x1 nv))))
; (foldr op nv '(x1 x2 ... xn)) = (op x1 (op x2 (... (op xn nv))))
;
; И при двете op е бинарна процедура (λ (x acc) ...):
;  - първият аргумент x е текущият елемент на списъка;
;  - вторият аргумент acc е натрупаният досега резултат (акумулаторът);
;  - op връща новата стойност на акумулатора, а nv е началната му стойност.
; Разликата е в посоката на обхождане:
;  - foldl обхожда списъка отляво надясно - първо комбинира x1 с nv,
;    после x2 с получения резултат и т.н. до xn;
;  - foldr обхожда списъка отдясно наляво - първо комбинира xn с nv,
;    после x(n-1) с получения резултат и т.н. до x1.
; foldl генерира линеен итеративен процес, а foldr - линеен рекурсивен.

(foldl (λ (x acc) (* x acc)) 1 '(1 2 3 4 5))
(foldr (λ (x acc) (and x acc)) #t '(#t #t #t #t #t))

; Можем да видим в какъв ред се прилага op, като построим израза като низ.
(foldl (λ (x acc) (format "(op ~a ~a)" x acc)) "nv" '(1 2 3)) ; "(op 3 (op 2 (op 1 nv)))"
(foldr (λ (x acc) (format "(op ~a ~a)" x acc)) "nv" '(1 2 3)) ; "(op 1 (op 2 (op 3 nv)))"

; Внимание: foldl от лекциите НЕ е същата като вградената в Racket!
;
; foldl от лекциите:                  foldl в Racket:
; (define (foldl op nv l)             (define (foldl op nv l)
;   (if (null? l) nv                    (if (null? l) nv
;       (foldl op (op nv (car l))           (foldl op (op (car l) nv)
;              (cdr l))))                          (cdr l))))
;
; (op (... (op (op nv x1) x2) ...) xn)   (op xn (... (op x2 (op x1 nv))))
;
; И двете обхождат списъка отляво надясно, но в лекциите op е (λ (acc x) ...) -
; първо акумулаторът, после елементът (както е и foldl в Haskell),
; а в Racket е (λ (x acc) ...) - първо елементът, после акумулаторът.
; foldr е еднаква и в лекциите, и в Racket - op е (λ (x acc) ...).
;
; Двете се превръщат една в друга, като разменим аргументите на op:
; (lecture-foldl op nv l) = (foldl (λ (x acc) (op acc x)) nv l)

(define (lecture-foldl op nv l)
  (if (null? l) nv
      (lecture-foldl op (op nv (car l)) (cdr l))))

; При комутативна операция като + или * разликата не се вижда...
(lecture-foldl * 1 '(1 2 3 4 5)) ; 120
(foldl * 1 '(1 2 3 4 5))         ; 120

; ...но при некомутативна се вижда.
(lecture-foldl (λ (acc x) (format "(op ~a ~a)" acc x)) "nv" '(1 2 3)) ; "(op (op (op nv 1) 2) 3)"
(foldl (λ (x acc) (format "(op ~a ~a)" x acc)) "nv" '(1 2 3))         ; "(op 3 (op 2 (op 1 nv)))"

(lecture-foldl list '() '(1 5 10)) ; '(((() 1) 5) 10)
(foldl list '() '(1 5 10))         ; '(10 (5 (1 ())))
(lecture-foldl - 0 '(1 2 3))       ; (- (- (- 0 1) 2) 3) = -6
(foldl - 0 '(1 2 3))               ; (- 3 (- 2 (- 1 0))) = 2

(ormap even? '(1 2 3 4 5))

(andmap even? '(1 2 3 4 5))

(take '(1 2 3 4) 0)
(take '(1 2 3 4) 2)

(takef '(2 4 5 8) even?)
(takef '(2 4 6 8) odd?)

(drop '(1 2 3 4) 0)
(drop '(1 2 3 4) 2)

(dropf '(2 2 5 8 56) even?)
(dropf '(2 2 4 8 56) even?)