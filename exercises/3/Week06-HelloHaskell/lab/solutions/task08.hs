main :: IO()
main = do
    print $ isPrime 1 == False
    print $ isPrime 2 == True
    print $ isPrime 3 == True
    print $ isPrime 6 == False
    print $ isPrime 61 == True

    print $ isPrimeAll 1 == False
    print $ isPrimeAll 2 == True
    print $ isPrimeAll 3 == True
    print $ isPrimeAll 6 == False
    print $ isPrimeAll 61 == True

intSqrt :: Int -> Int
isPrime :: Int -> Bool

intSqrt = floor . sqrt . fromIntegral

-- Ако n има делител, по-голям от sqrt n, то има и такъв, по-малък от sqrt n,
-- затова е достатъчно да проверим само числата до intSqrt n.
isPrime n = n > 1 && length [ x | x <- [2 .. intSqrt n], mod n x == 0] == 0

-- Алтернативно решение: вместо да строим списъка на делителите и да броим
-- дължината му, с all проверяваме директно, че никое число до intSqrt n
-- не дели n - all спира още при първия намерен делител.
isPrimeAll :: Int -> Bool
isPrimeAll n = n > 1 && all (\ x -> mod n x /= 0) [2 .. intSqrt n]
