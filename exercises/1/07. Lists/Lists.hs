module Lists where

-- Списъците в Haskell, подобно на Scheme,
-- също се имплементират чрез едносвързани списъци.
-- Следователно тук също ги разделяме на глава и на
-- опашка и правим структурна рекурсия по тях.

lst :: [Int]
lst = [1,2,3,4,5]

-- >>> head lst
-- 1

-- >>> tail lst
-- [2,3,4,5]

-- Горното [1,2,3,4,5] е просто синтактична захар за следното:
lst' :: [Int]
lst' = 1 : 2 : 3 : 4 : 5 : []

-- което е аналогично на следното в Scheme (: e cons, [] е '()):
-- (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 '())))))

-- Подобно на това, което сме правили в Scheme:

sumElements :: [Int] -> Int
sumElements lst
  | null lst  = 0
  | otherwise = head lst + sumElements (tail lst)

-- Само че горният синтаксис, както знаем от Scheme,
-- е сравнително тромав. Haskell ни позволява да правим
-- структурен pattern matching, за напишем по-горното
-- по по-приятен за нас начин:

sumElements' :: [Int] -> Int
sumElements' [] = 0 -- случай за празен списък
sumElements' (x:xs) = x + sumElements' xs -- x е главата, xs е опашката

-- Удобно е да си мислим и в типове: x :: Int,
-- а xs :: [Int], следователно може да подадем xs на sumElements'.

-- ВИНАГИ когато разделяме списък на глава и на опашка,
-- трябва първо да направим проверка (или да pattern match-нем)
-- за празен списък.

-- Можем да pattern match-ваме и по-сложни и вложени структури:

joinWith :: [String] -> String -> String
joinWith [] _ = ""
joinWith [str] _ = str -- списък с точно един елемент
joinWith (s:ss) delim = s ++ delim ++ joinWith ss delim

-- typedef/using
type Point = (Double, Double)

sumPoints :: [Point] -> Point
sumPoints [] = (0, 0)
sumPoints ((x, y):xs) =
  let (x', y') = sumPoints xs
    in (x + x', y + y')

-- първите елементи от всеки ред
firstColumn :: [[Int]] -> [Int]
firstColumn [] = []
firstColumn ([]:xs) = firstColumn xs -- този случай е важен!
firstColumn ((x:_):xs) = x : firstColumn xs

ll :: [[Int]]
ll =
  [ [1,2,3]
  , [4]
  , []
  , [5, 6]
  , []
  ]

-- >>> firstColumn []
-- []

-- >>> firstColumn [[]]
-- []

-- >>> firstColumn ll
-- [1,4,5]


-- Ето примери за някои вградени функции
-- и как могат да бъдат използвани:

-- >>> map (+ 1) [1,2,3]
-- [2,3,4]

-- >>> filter even [1,2,3]
-- [2]

-- >>> foldr (+) 0 [1,2,3]
-- 6

-- >>> foldl (+) 0 [1,2,3]
-- 6

-- >>> foldr1 (+) [1,2,3]
-- 6

-- >>> foldr1 (+) []
-- *** Exception: Prelude.foldr1: empty list

-- >>> foldl1 (+) [1,2,3]
-- 6

-- >>> scanr (+) 0 [1,2,3]
-- [6,5,3,0]

-- >>> scanl (+) 0 [1,2,3]
-- [0,1,3,6]

-- >>> elem 1 [1,2,3]
-- True

-- >>> 4 `elem` [1,2,3]
-- False

-- >>> take 4 [1..]
-- [1,2,3,4]

-- >>> drop 4 [1,2]
-- []

-- >>> [1,2,3] `zip` [4,5]
-- [(1,4),(2,5)]

-- >>> zipWith (+) [1,2,3] [4,5]
-- [5,7]

-- >>> all even [4,6,8]
-- True

-- >>> any even [1,2,3]
-- True
