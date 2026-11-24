import Prelude hiding (length, minimum, maximum, all, any, reverse, replicate)

-- Дясно сгъване: първо се извикваме рекурсивно, и резултата насъбираме към главата
--foldr op nv [] = nv
--foldr op nv (x:xs) = op x (foldr op nv xs)

-- Ляво сгъване: първо насъбираме главата, и с резултата се извикваме рекурсивно
--foldl op nv [] = nv
--foldl op nv (x:xs) = foldl op (op nv x) xs

-- Зад.1
reverse lst = foldr (\el res -> res ++ [el]) [] lst
length lst = foldl (\res _ -> res + 1) 0 lst
-- Заб.: няма short circuit, винаги ще обходят целия списък :/
all p lst = foldl (\res el -> res && p el) True lst
any p lst = foldl (\res el -> res || p el) False lst

-- функцията (\el res -> min el res) е идентична на самата min
minimum lst = foldl min (head lst) (tail lst)
-- по-добре с pattern matching :)
maximum (x:xs) = foldl max x xs

-- Наивна имплементация: рекурсия по lst1, в дъното връщаме lst2
-- append [] lst2 = lst2
-- append (x:xs) lst2 = x : (append xs lst2)
-- Аналогично, (\el res -> el : res) е еквивалентно на самия оператор (:)
append lst1 lst2 = foldr (:) lst2 lst1

--replicate n x = foldr (\_ res -> x : res) [] [1..n]
replicate n x = [ x | i<-[1..n] ]

-- List comprehension надгражда както map, така и filter
map' f lst = [ f x | x<-lst ]
filter' p lst = [ x | x<-lst, p x ]

-- Зад.2
countDivisors n = length [ d | d<-[1..n], mod n d == 0 ]
sumDivisors n = sum [ d | d<-[1..n], mod n d == 0 ]

prime 1 = False
prime n = null [ d | d<-[2..sqn], mod n d == 0]
  where sqn = floor (sqrt (fromIntegral n))

descartes lst1 lst2 = [ (x,y) | x<-lst1, y<-lst2 ]

-- Зад.3
-- primes = filter prime [2..]
primes = [ n | n<-[2..], prime n ]

-- Зад.4
primes' = sieve [2..]
  where sieve (x:xs) = x : sieve [ y | y<-xs, mod y x /= 0 ]

-- Зад.5
-- Проблем: това _никога_ няма да "извърти" всички y за x=0
-- и да генерира наредени двойки с друга първа компонента
--  allPairs = [(x,y) | x<-[0..], y<-[0..]]
-- Решение: обхождаме по диагонали - т.к. всеки от тях е краен,
-- всяка наредена двойка ще се достигне за крайно време:
allPairs = [ (x,diag-x) | diag<-[0..], x<-[0..diag] ]
