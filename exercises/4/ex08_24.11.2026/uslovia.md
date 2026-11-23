# Упражнение 8 - Кортежи и списъци
### Как да си пускаме функциите
#### Като подаваме файл на интерпретатора
- Слагаме си функцията във файл - напр. ex_08.hs
```haskell
add1 :: Num a => a -> a
add1 x = x + 1

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)
```
- В терминала пускаме ghci като му подаваме въпросния файл
```haskell
$ ghci ex_08.hs 
GHCi, version 9.6.7: https://www.haskell.org/ghc/  :? for help
[1 of 2] Compiling Main             ( ex_08.hs, interpreted )
Ok, one module loaded.
ghci> fib 10
55
ghci> add1 10
11
```
Ако променим файла и искаме да презаредим средата на ghci можем директно да направим:
```haskell
ghci> :reload
Ok, no modules loaded.
```

#### Директно работим в ghci
Работи, но става нечетимо и не може да се редактира лесно. Също има специфики при функции на няколко реда.
```haskell
$ ghci
GHCi, version 9.6.7: https://www.haskell.org/ghc/  :? for help
ghci> add1 x = x + 1
ghci> add1 10
11
ghci> fib 0 = 0
ghci> fib 1 = 1
ghci> fib 0
*** Exception: <interactive>:2:1-9: Non-exhaustive patterns in function fib
```
Интерпретаторът пази връзка към последната дефиниция на съответното име и в случая презаписва какво значи fib. Затова се ползва блок като по-долу.
```haskell
ghci> :{
ghci| fib 0 = 0
ghci| fib 1 = 1
ghci| fib n = fib (n-1) + fib (n-2)
ghci| :}
ghci> fib 10
55
```
#### Като компилираме програмата с ghc
- За да стане изпълним файл, програмата трябва да има функция `main` от тип `IO ()`. От нея започва изпълнението, както в C/Java.
```haskell
-- ex_08.hs
add1 :: Num a => a -> a
add1 x = x + 1

fib :: Int -> Int
fib 0 = 0
fib 1 = 1
fib n = fib (n-1) + fib (n-2)

main :: IO ()
main = do
  print (fib 10)
  print (add1 10)
```
- Компилираме с `ghc` и пускаме получения изпълним файл:
```haskell
$ ghc ex_08.hs
[1 of 2] Compiling Main             ( ex_08.hs, ex_08.o )
[2 of 2] Linking ex_08
$ ./ex_08
55
11
```

### Полезни функции:
```haskell
map, filter, foldr, reverse, length, null, elem, take, drop, zip, zipWith, all, any, takeWhile, dropWhile
```
##### Примери:
```haskell
ghci> map length [[1, 2], [3, 4, 5], [6, 2, 10, 11]]
[2,3,4]
ghci> filter even [1, 2, 3, 4, 8, 10, 32, 4, 3, 7, 8]
[2,4,8,10,32,4,8]
ghci> foldr (\ elem res -> res + elem) 0 [1, 2, 3, 4]
10
-- foldr работи както при scheme, в слуая имаме очаквани типове (a0 -> b0 -> b0) -> b0 -> [a0] -> b0)
ghci> reverse ["a", "asff", "vwg2"]
["vwg2","asff","a"]
ghci> null [1, 5, 3, 9]
False
ghci> elem 4 [1, 3, 6, 7, 4]
True
ghci> 4 `elem` [1, 7, 8, 23]
False
-- Можем да правим функциите инфиксни, ако ни е по-четливо чрез `ф-ция`.
```
Списъците в haskell работят и като безкрайни списъци, защото самото оценяване при haskell е мързеливо. Тоест ние можем да достъпим само 
първия елемент, а останалите още не са оценени.
```haskell
ghci> head [1, error "a"]
1
ghci> head (tail [1, error "a"])
*** Exception: a
CallStack (from HasCallStack):
  error, called at <interactive>:8:16 in interactive:Ghci5
ghci> take 4 [1, 6, 9, 10, 12, 45]
[1,6,9,10]
nats = 1 : map (+1) nats -- безкраен списък на естествените числа
ghci> take 4 nats
[1,2,3,4]
ghci> take 3(drop 4 nats)
[5,6,7]
ghci> zip [1, 2, 3] ["a", "b", "c"]
[(1,"a"),(2,"b"),(3,"c")]
```
Композиция на функции правим, като използваме операторът `(.)`. Резултатът на `f . g` е нова функция, която първо прилага `g`, а после `f` на аргумента. 
```haskell
(.) :: (b -> c) -> (a -> b) -> (a -> c)
(f . g) x = f (g x)
```

## Задача 1
Да се имплементират map, filter и foldr на Haskell.

## Задача 2
Да се напише функция dist, който намира разстоянието между две точки в двумерието (наредени двойки)
```haskell
ghci> dist (-2,3) (1,7) -> 5
ghci> dist (0,0) (1,1) -> 1.4142135623730951
```

## Задача 3
Да се напише функция len, която намира дължината на списък. Решете я с обикновена рекурсия и чрез foldr.
```haskell
ghci> len [1, 5, 6, 7, 8]
5
```

## Задача 4
Да се напише функция, която приема списък от символни низове и знак. Функцията да обединява всички низове в един, като в резултата отделните низовете да са отделени с подадения знак.

```haskell
ghci> join ["Hello", "World", "My", "Friend"] ' ' -- "Hello World My Friend"
```

## Задача 5 
Напишете функция, която проверява дали един списък е подсписък на друг.

```haskell
ghci> isInfixOf [3..5] [1..10] -- True
```

## Задача 6
Да се напише функция, която сортира списък чрез алгоритъма за бързо сортиране.

```haskell
ghci> quickSort [7, 2, 5, 3, 9] -- [2,3,5,7,9]
```
## Задача 7
Да се напише функция, която сортира списък чрез алгоритъма за сортиране чрез вмъкване.

```haskell
ghci> insertionSort [7, 2, 5, 3, 9] -- [2,3,5,7,9]
```

## Задача 8 
Да се напише функция, която приема предикат и списък и връща най-дългия префикс изпълняващ на предиката. 
```haskell
ghci> longestPrefix (\ xs -> last xs == 'a') "Hello, my name is Rali"
"Hello, my name is Ra"
ghci> longestPrefix (all even) [2, 4, 6, 7, 8, 0, 2, 4, 6, 1]
[2,4,6]
```
## Задача 9
Да се напише функция, която приема предикат и списък и връща най-дългия подсписък изпълняващ предиката

```haskell
ghci> longestSublist (all even) [2, 4, 6, 7, 8, 0, 2, 4, 6, 1]
[8,0,2,4,6]
```
