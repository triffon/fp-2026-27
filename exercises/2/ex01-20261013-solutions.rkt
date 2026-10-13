#lang racket

; Зад.1
(define (sum-interval a b)
  ; Инвариант: на всяка итерация sum = сбора на числата от a до i-1, вкл.
  (define (loop sum i)
    (if (> i b)
        sum
        (loop (+ sum i) (+ i 1))))
  (loop 0 a))

; Вж. колко подобна изглежда имплементацията на факториел с опашкова рекурсия
(define (fact n)
  ; Инвариант: res = произв. на числата от 1 до i-1, вкл.
  (define (loop res i)
    (if (> i n)
        res
        (loop (* res i) (+ i 1))))
  (loop 1 1))

; Зад.2
; while (n != 0) {
;   if (n % 10 == d) {
;     ++count;
;   }
;   n /= 10;
; }
(define (count-digit d n)
  ; Инвариант: на k-тата итерация count = броя срещания на d измежду последните k цифри
  ;  ("обработените"); n = оригиналното число без последните k цифри ("оставащата" част)
  (define (loop n count)
    (cond [(= n 0) count]
          [(= (remainder n 10) d) (loop (quotient n 10) (+ count 1))]
          [else (loop (quotient n 10) count)]))
  (loop n 0))

; Зад.3
(define (reverse-digits n)
  ; Инвариант: res съдържа обърнати последните k цифри от n,
  ; вътрешното n съдържа останалите цифри (необработени)
  (define (loop n res)
    (if (= n 0)
        res
        (loop (quotient n 10) (+ (* res 10) (remainder n 10)))))
  (loop n 0))

; Зад.4
(define (divisors-sum n)
  ; Инвариант: sum = сбора на делителите на n измежду 1 и i-1, вкл.
  (define (loop i sum)
    (cond [(> i n) sum]
          [(= (remainder n i) 0) (loop (+ i 1) (+ sum i))]
          [else (loop (+ i 1) sum)]))
  (loop 1 0))

; Зад.5
(define (perfect? n)
  (= (divisors-sum n) (* 2 n)))

; Зад.6
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

; Зад.7
(define (increasing? n)
  ; Самата increasing? е опашково-рекурсивна, няма нужда от помощна функция :)
  (or (< n 10)
      (and (>= (remainder n 10) (remainder (quotient n 10) 10))
           (increasing? (quotient n 10)))))

; Зад.8
; Развитие на стандартната идея, при която на всяка итерация
; делим числото на две и остатъкът ни казва дали поредният бит
; трябва да е вдигнат.
(define (toBinary n)
  ; Инвариант: на k-тата итерация pow==10^k;
  ; res съдържа долните k "бита" от резултата;
  ; n = "оригиналното" n, делено на 2^k
  (define (loop n res pow)
    (if (= n 0)
        res
        (loop (quotient n 2) (+ res (* (remainder n 2) pow)) (* pow 10))))
  (loop n 0 1))

; Зад.9
; Обратната трансформация се оказва аналогична :)
(define (toDecimal n)
  ; Аналогичен инвариант
  (define (loop n res pow)
    (if (= n 0)
        res
        (loop (quotient n 10) (+ res (* (remainder n 10) pow)) (* pow 2))))
  (loop n 0 1))

; За пълнота: "наивно"-рекурсивното решение изглежда доста по-чисто :(
(define (toDecimal* n)
  (if (= n 0)
      0
      (+ (* 2 (toDecimal* (quotient n 10))) (remainder n 10))))

; Зад.10
(define (sq x) (* x x)) ; това е, както се казва, load-bearing
(define (fast-exp x n)
  (cond [(= n 0) 1]
        [(even? n) (sq (fast-exp x (quotient n 2)))]
        [else (* x (sq (fast-exp x (quotient n 2))))]))
