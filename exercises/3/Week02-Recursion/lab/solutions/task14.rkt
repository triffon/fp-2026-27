#lang racket

(define (count-occurrences n d)
  (define last-digit-count (if (= (remainder n 10) d) 1 0))
  (if (< n 10)
      last-digit-count
      (+ last-digit-count (count-occurrences (quotient n 10) d))
      )
  )

(define (sort-n n)
  ; Добавя цифрата digit в края на result times пъти.
  (define (append-digit result digit times)
    (if (zero? times)
        result
        (append-digit (+ (* result 10) digit) digit (sub1 times))
        )
    )
  ; Обхождаме цифрите от 9 до 0 и всяка я добавяме толкова пъти,
  ; колкото пъти се среща в n. Така резултатът е подреден в намаляващ ред
  ; и нулите не се губят (напр. 201 -> 210, а не 21).
  (define (helper digit result)
    (if (< digit 0)
        result
        (helper (sub1 digit) (append-digit result digit (count-occurrences n digit)))
        )
    )
  (helper 9 0)
  )

(= (sort-n 1714) 7411)
(= (sort-n 123450) 543210)
(= (sort-n 123405) 543210)
(= (sort-n 123045) 543210)
(= (sort-n 120345) 543210)
(= (sort-n 102345) 543210)
(= (sort-n 8910) 9810)
(= (sort-n 321) 321)
(= (sort-n 29210) 92210)
(= (sort-n 1230) 3210)
(= (sort-n 55345) 55543)
(= (sort-n 14752) 75421)
(= (sort-n 329450) 954320)
(= (sort-n 9125) 9521)
(= (sort-n 201) 210)
(= (sort-n 1000) 1000)
(= (sort-n 0) 0)
