main :: IO()
main = do
    print $ fibRec 11 == 89

    print $ fibIter 11 == 89
    print $ fibIter 110 == 43566776258854844738105

fibRec :: Int -> Int
-- F(110) не се побира в Int (64 бита), затова резултатът е Integer.
fibIter :: Int -> Integer

fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec (n - 1) + fibRec (n - 2)

-- Пазим двойка съседни числа на Фибоначи (n0, n1) и на всяка стъпка
-- я местим с една позиция напред: (F(k), F(k + 1)) -> (F(k + 1), F(k + 2)).
fibIter n = helper 0 1 n
 where
    helper :: Integer -> Integer -> Int -> Integer
    helper n0 _ 0 = n0
    helper _ n1 1 = n1
    helper n0 n1 current = helper n1 (n0 + n1) (current - 1)
