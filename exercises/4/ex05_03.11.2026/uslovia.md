# Упражнение 5 – Списъци и функции от по-висок ред върху тях, дървета

## `foldr` и `foldl` -  като `accumulate`, но за списъци

```scheme
(define (foldr operation null_value lst)
  (if (null? lst) null_value
      (operation (car lst)
          (foldr operation null_value (cdr lst)))))

(define (foldl operation null_value lst)
  (if (null? lst) null_value
      (foldl operation (operation null_value (car lst)) (cdr lst))))
```

### Задача 0
Да се напишат функциите `reverse` , `map`  и `filter` чрез **`foldr`** или **`foldl`**.

### Задача 1
Да се напише функция `least`, която намира най-малкото число в даден списък от числа.
```scheme
(least '(4 5 1 8 3 -9 -4 1 4)) ; -> -9
```

### Задача 2

Да се напише функция `unique l`, която връща уникалните елементи в даден списък. Няма значение реда на елементите. *Упътване: Напишете помощна функция `member? x l`, която проверява дали даден обект е елемнт на списък.* 
```scheme
(unique '(1 3 6 2 2 8 1)) ; -> ‘(3 6 2 8 1)
(unique '(0 "asd" 2 "asd" "1" 0 4)) ; ->  '(2 "asd" "1" 0 4)
```

### Задача 3

Да се напишaт функциите `union l1 l2` и `intersection l1 l2`, които намират съответно обединението и сечението на два списъка, като резултатите трябва да са множества 
(т.е. елементите да са уникални). Реда на елементите няма значение.

```scheme
(union '(1 2 3 4) '(5 2 3 1 7)) ; -> '(4 5 2 3 1 7)
(intersection '(1 2 3 4) '(5 2 3 1 7)) ; -> '(1 2 3)
```
### Задача 4

Да се напише функция `insert x l`, която вмъква x на правилното място в сортиран списък. *В случая е по-лесно с обикновена рекурсия.*
```scheme
(insert 5 '(1 2 4 6 7)) ; -> '(1 2 4 5 6 7)
(insert 5 '(1 2 4 5 5 6 7)) ; -> '(1 2 4 5 5 5 6 7)
(insert 5 '(1 2 4)) ; -> '(1 2 4 5)
(insert 5 '(6 7)) ; '(5 6 7)
```

### Задача 5
Да се напише функция `insertion-sort l`, която сортира списък чрез съответният алгоритъм. *Упътване: ползвайте`foldr` и `insert x l`*.
```scheme
(insertion-sort '(1 5 5 8 2 4 1 2 9 4 8)) ; -> '(1 1 2 2 4 4 5 5 8 8 9)
```

### Задача 6*
Да се напише функция `all-suffix l`, която връща списък със всички подсписъци на `l`, които са суфикси на `l`. 
```scheme
(all-suffix '("a" 2 3) ; -> '(("a" 2 3) (2 3) (3))
```

### Задача 7*
Да се напише функция `max-prefix p? l`, която връща най-дългия префикс на `l`, чиито елементи изпълняват `p?`.

```scheme
(max-prefix even? '(2 4 8 3 5 12 18)) ; -> '(2 4 8)
```

### Задача 8*
Да се напише функция `max-sub p? l`, която намира най-дългия подсписък на `l`, чиито елементи изпълняват `p?`. *Упътване: Използвайте функциите `max-prefix` и `all-suffix`.*

```scheme
(max-sub '(2 3 4 2 1 8 0 2 3)) ; -> '(8 0 2)
```

## Функцията `apply`	

```scheme
(apply + ‘( 1 2 3 4)) ; еквиваленто на (+ 1 2 3 4)

```
`apply` прилага многоместна функция върху елемните от подадения списък, тоест можем да работим с елементите на функции с произволен брой аргументи.
Чрез `apply` можем да осъществяваме рекурсия в тези случаи:

```scheme
(define (my-sum x . xs)
  (if (null? xs) x
      (+ x (apply my-sum xs))))


(my-sum 4 5 2 1 5 0 2 2) ; -> 21
```

### Задача 9
Да се напише функция `find-interval`, която приема произволен брой числа и намира разликата между най-голямото и най-малкото число. *Упътване: Припомнете си `min` и `max`.*

```scheme
(find-interval 2 5 8 -2) ; -> 10
(find-interval 4 6 2 4 1 3 9 12) ; -> 11
```
### Задача 10
Да се напише функция `min-lex`, която приема произволен брой стрингове и намира най-малкия лексикографски. 	
За сравняване на низове използвайте `string<?`.
```scheme
(min-lex "asd" "asdd" "azcesd")
```

### Задача 11 

Да се напише функция `compose-all`, която приема произволен брой едноместни функции и връща тяхната композиция като резултат.
```scheme
(define (^2 x) (* x x))
(define (succ x) (+ 1 x))

((compose-all2 ^2 succ succ) 5) ; -> 49
```

## Двоични дървета
Използваме следната имплементация на двоични дървета:
```scheme
(define (tree? t)
  (or (null? t)
      (and (list? t)
           (= (length t) 3))
           (tree? (cadr t))
           (tree? (caddr t))))
(define empty-tree '())
(define (make-tree root left right) (list root left right))      
(define (make-leaf root) (make-tree root empty-tree empty-tree))
(define root-tree car)
(define left-tree cadr)
(define right-tree caddr)
(define empty-tree? null?)

(define (atom? x)
  (and (not (pair? x))
       (not (null? x))))

(define (deep-foldr op term nv l)
  (cond ((null? l) nv)
        ((atom? l) (term l))
        (else (op (deep-foldr op term nv (car l))
                  (deep-foldr op term nv (cdr l))))))
```
Примерни дървета:
```scheme

(define t (make-tree 5
                     (make-tree 1
                                (make-tree 4
                                           '()
                                           (make-leaf 13))
                                (make-leaf 3))
                     (make-tree 8
                                (make-tree 0
                                           (make-leaf 10)
                                           (make-leaf 9))
                                (make-leaf 11))))

```


### Задача 12
Да се напише функция `tree-member? x t`, която проверява дали даден елемент се съдържа в дърво.
```scheme
(tree-member? 9 t); -> #t
(tree-member? 18 t); -> #f
```

### Задача 13

Да се напише функция `depth t`, която намира височината на дърво. Опитайте се да я решите с рекурсия, както и чрез `deep-foldr`.
```scheme
(depth t); -> 4
```

### Задача 14

Да се напише функция `count-leafs t`, която намира броя на листата на двоично дърво.
```scheme
(count-leafs t); -> 5
```

### Задача 15

Да се напише функция `traverse t`, която обхожда дървото ляво-корен-дясно и връща списък от елементите на дървото
```scheme
(traverse t) ; -> '(4 13 1 3 5 10 0 9 8 11)
```
### Задача 16

Да се напише функция `level k t`, която връща елементите на дървото на ниво `k`. Нека броенето започва от 0-ла, тоест коренът на дървото се намира на ниво 0.
 
```scheme
(level 1 t); -> (1 8)
(level 2 t) ; -> '(4 3 0 11)
(level 4 t2); -> ‘()
```




