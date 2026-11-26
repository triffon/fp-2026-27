{- HLINT ignore "Eta reduce" -}

module Hof where

-- Можем да указваме типовете на функции
-- в Haskell по следния начин:

add :: Int -> Int -> Int
add x y = x + y

-- >>> add 1 2
-- 3

-- Стрелката -> е оператор над типове,
-- който е дясноасоциативен. Тоест,
-- горния тип е аналогичен на:

add' :: Int -> (Int -> Int)
add' x y = x + y

-- >>> add' 1 2
-- 3

-- Горното означава, че за да подадем
-- функция като параметър на друга такава,
-- трябва да сложим скоби около нейния тип:

-- приема едноместна функция f
-- и я прилага над x
apply :: (Int -> Int) -> Int -> Int
apply f x = f x

-- template<typename T>
-- map show [1,2,3]
-- a ~ Int
-- b ~ String

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

-- >>> map' show [1,2,3]

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' _ nv [] = nv
foldr' op nv (x:xs) = x `op` foldr op nv xs

-- Ламбда-функциите в Haskell също имат сравнително
-- прост синтаксис:

-- >>> (\x -> x + 1) 4
-- 5

-- >>> (\x y -> x - y) 5 4
-- 1

-- >>> (\(x1,y1) (x2,y2) -> (x1 + x2, y1 + y2)) (1,0) (0,1)
-- (1,1)

-- >>> map (\x -> x + 1) [1,2]
-- [2,3]

-- >>> map (+ 1) [1,2] -- синтактична захар
-- [2,3]

intersect :: Eq a => [a] -> [a] -> [a]
-- intersect l1 l2 = filter (\x -> x `elem` l2) l1
intersect l1 l2 = filter (`elem` l2) l1
