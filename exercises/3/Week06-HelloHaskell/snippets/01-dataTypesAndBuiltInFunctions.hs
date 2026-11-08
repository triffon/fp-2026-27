-- Всяка дефиниция има сигнатура (име :: Тип) и стойност. В Haskell
-- типовете се проверяват при компилация и не могат да се променят.

-- Int е цяло число с фиксиран размер (64 бита) ...
a :: Int
a = 5

b :: Int
b = 7

-- ... а Integer е цяло число с произволна големина.
big :: Integer
big = 547349579438574375934345734

-- Int има горна граница (maxBound). При надхвърлянето ѝ резултатът
-- "превърта" до отрицателно число БЕЗ грешка! Integer няма такъв проблем -
-- затова за големи стойности (факториели, Фибоначи) използваме Integer.
intLimit :: Int
intLimit = maxBound

overflow :: Int
overflow = 2 ^ 63 -- -9223372036854775808

noOverflow :: Integer
noOverflow = 2 ^ 63 -- 9223372036854775808

-- Float е с единична точност, Double - с двойна (предпочитаме Double).
c :: Float
c = 2.34

d :: Double
d = 4.2254645786438768345645

-- Rational е точна дроб (числител % знаменател) - няма грешка от закръгляне.
e :: Rational
e = 43348983948934743749387439874.53445

-- Символите са в единични кавички, низовете - в двойни.
-- String е просто списък от символи ([Char]).
ch :: Char
ch = 'p'

str :: String
str = "Hello"

bool1 :: Bool
bool1 = True

-- Логически операции: &&, ||, not; сравнения: ==, /= (различно), <, >, <=, >=.
bool2 :: Bool
bool2 = (3 > 2) && ((5 < 3) || (10 /= 1) || (not (5 == 6)))

expr1 :: Int
expr1 = a * b

-- Функциите се извикват без скоби и запетаи: mod 1234 10, а не mod(1234, 10).
expr2 :: Int
expr2 = mod 1234 10 -- остатък при целочислено деление

expr3 :: Int
expr3 = div 1234 10 -- частно при целочислено деление

-- Операторът / работи само с реални числа - резултатът не може да е Int.
expr4 :: Double
expr4 = 1234 / 5

-- ^ е степенуване с цял показател, ** - с реален.
expr5 :: Int
expr5 = 2 ^ 3

expr6 :: Double
expr6 = 2 ** 3.5

expr7 :: Int
expr7 = max 3 5 -- min

expr8 :: Int
expr8 = min 3 5

expr9 :: Bool
expr9 = odd 7 -- even

-- sqrt gcd abs

-- fromIntegral преобразува цяло число към какъвто числов тип се очаква
-- (тук Double). Обратното - от реално към цяло - става с ceiling, floor,
-- round или truncate.
expr10 :: Double
expr10 = fromIntegral 5

expr11 :: Int
expr11 = ceiling 5.4 -- floor round truncate

main :: IO()
main = do
    print a
    print big
    print intLimit
    print overflow
    print noOverflow
    print c
    print d
    print e
    print ch
    print str
    print bool2
    print expr2
    print expr3
    print expr4
    print expr5
    print expr6
    print expr10
    print expr11
