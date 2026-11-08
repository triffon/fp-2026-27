import Data.List

-- Списъците са хомогенни - всички елементи са от един тип.
empty :: [Int]
empty = []

xs1 :: [Int]
xs1 = [1, 2, 3, 4]

-- Операторът : (cons) добавя елемент в началото на списък.
-- [1, 2, 3] е просто съкратен запис на 1 : 2 : 3 : [].
xs2 :: [Int]
xs2 = 1 : []

xs3 :: [Int]
xs3 = 1 : [2, 3]

isEmpty :: [Int] -> Bool
isEmpty xs = null xs

-- Pattern matching по структурата на списъка: отделен случай за празния
-- списък [] и за списък с глава x и опашка xs. С _ казваме, че дадена
-- част не ни трябва.
car :: [Int] -> Int -- head
car [] = error "Empty list"
car (x:_) = x

cdr :: [Int] -> [Int] -- tail
cdr [] = error "Empty list"
cdr (_:xs) = xs

-- Индексиране (от 0) с оператора !!.
at :: [Int] -> Int -> Int
at xs i = xs!!i

-- last

main :: IO()
main = do
    print $ elem 1 [1, 2, 3, 4]
    print $ elem 1 [5, 2, 3, 4]
    print $ [1, 2, 3] ++ [4, 5, 6] -- конкатенация
    print $ length [1, 2, 3]
    print $ reverse [1, 2, 3]
    print $ sum [1, 2, 3]
    print $ product [1, 2, 3]
    print $ minimum [1, 2, 3] -- maximum
    print $ take 2 [1, 2, 3]
    print $ take 5 [1, 2, 3] -- take/drop не гърмят при по-голям брой
    print $ drop 2 [1, 2, 3]
    print $ drop 5 [1, 2, 3]
    print $ nub [1, 2, 1, 2, 3, 3, 1, 1] -- маха повторенията (от Data.List)
    print $ sort [5, 3, 4, 1, 2] -- също от Data.List
    print $ isEmpty empty
    print $ car xs1
    print $ cdr xs3
    print $ at xs1 2
