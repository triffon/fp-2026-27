-- Частично прилагане (partial application): всяка функция в Haskell всъщност
-- приема по един аргумент, т.е. Int -> Int -> Int е Int -> (Int -> Int).
-- Ако подадем само първия аргумент, получаваме нова функция, която чака останалите.
add :: Int -> Int -> Int
add x y = x + y

add5 :: Int -> Int
add5 = add 5

take3 :: [Int] -> [Int]
take3 = take 3

power :: Int -> Int -> Int
power x y = x ^ y

-- Частичното прилагане фиксира ПЪРВИЯ аргумент: power 2 е функцията y -> 2 ^ y.
powersOfTwo :: Int -> Int
powersOfTwo = power 2

-- За да фиксираме втория аргумент, разменяме реда им с flip
-- (flip power е y -> x -> x ^ y) или ползваме секция на оператор: (^ 2).
square :: Int -> Int
square = flip power 2

cube :: Int -> Int
cube = (^ 3)

-- Секции на оператори: пропуснатият аргумент е този, който новата функция чака.
-- (x +) фиксира левия, (+ x) - десния. При некомутативни оператори редът е важен.
tenMinus :: Int -> Int
tenMinus = (10 -)        -- x -> 10 - x

minusTen :: Int -> Int
minusTen = subtract 10   -- x -> x - 10; (- 10) НЕ е секция, а числото минус десет, затова има subtract

halve :: Int -> Int
halve = (`div` 2)        -- всяка функция на два аргумента става оператор с обратни кавички

-- Частично приложените функции се комбинират с композиция - без да споменаваме аргумента.
doubleAfterAddOne :: Int -> Int
doubleAfterAddOne = (* 2) . (+ 1)

main :: IO()
main = do
    print $ add5 10                   -- 15
    print $ take3 [1 .. 10]           -- [1,2,3]
    print $ powersOfTwo 10            -- 1024
    print $ square 7                  -- 49
    print $ cube 2                    -- 8
    print $ tenMinus 15               -- -5
    print $ minusTen 15               -- 5
    print $ halve 9                   -- 4
    print $ doubleAfterAddOne 3       -- 8
    -- map/filter с частично приложена функция - най-честата употреба.
    print $ map (* 2) [1, 2, 3]       -- [2,4,6]
    print $ filter (> 2) [1, 2, 3, 4] -- [3,4]
    print $ map (2 ^) [0 .. 4]        -- [1,2,4,8,16]
    print $ map (`mod` 3) [3, 4, 5]   -- [0,1,2]
