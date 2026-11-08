main :: IO()
main = do
    print $ factorial 5     -- 120
    print $ isZero 0        -- True
    print $ isZero 7        -- False
    print $ sumDigits 1234  -- 10
    print $ describe 30     -- "big"
    print $ describe 7      -- "small"
    print $ average3 1 2 3  -- 2.0

-- Pattern matching по числа: уравненията се проверяват отгоре надолу и се
-- избира първото, чийто образец пасва. Литералът 0 пасва само на 0,
-- а променливата n - на всичко останало.
factorial :: Int -> Int
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- Редът има значение: ако общият случай беше пръв, уравнението за 0 никога
-- нямаше да се достигне (GHC предупреждава за "overlapping patterns").
-- С _ казваме, че стойността не ни трябва.
isZero :: Int -> Bool
isZero 0 = True
isZero _ = False

-- where: локални дефиниции, видими в цялото тяло на функцията.
-- Типичното място за помощна функция с акумулатор (итеративен процес).
sumDigits :: Int -> Int
sumDigits n = helper n 0
 where
    helper :: Int -> Int -> Int
    helper 0 result = result
    helper current result = helper (div current 10) (result + mod current 10)

-- where може да дефинира и обикновени стойности. Те виждат параметрите на
-- функцията и са достъпни във всички guards.
describe :: Int -> String
describe n
 | half > 10 = "big"
 | half > 5 = "medium"
 | otherwise = "small"
 where
    half = div n 2

-- let ... in прави същото, но е израз - може да стои навсякъде, където се очаква стойност.
average3 :: Double -> Double -> Double -> Double
average3 a b c =
    let total = a + b + c
        count = 3
    in total / count
