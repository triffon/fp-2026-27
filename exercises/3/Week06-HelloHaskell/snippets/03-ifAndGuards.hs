-- if-then-else е израз и винаги има else клон - двата клона
-- трябва да са от един и същ тип.
f :: Int -> Int
f x = if x > 5 then 2 * x else x

-- Guards: условията се проверяват отгоре надолу и се избира първото вярно.
-- otherwise е просто True - "във всички останали случаи".
g :: Int -> Int
g x
 | x > 5 = 2 * x
 | x > 2 = 3 * x
 | otherwise = x

main :: IO()
main = do
    print $ f 10
    print $ f 1
    print $ g 10
    print $ g 3
    print $ g 1
