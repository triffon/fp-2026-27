import Data.Char

main :: IO()
main = do
    print $ isPalindromeMagic 123321 == True
    print $ isPalindromeMagic 1010 == False

    print $ digitSum 2024 == 8
    print $ numDigits 100000 == 6
    print $ reverseNum 1230 == 321

-- show превръща числото в низ ("123321"), а низът е просто списък от символи
-- ([Char]), затова върху него работят всички функции за списъци - reverse,
-- length, map, ...
isPalindromeMagic :: Int -> Bool
isPalindromeMagic n = show n == reverse (show n)

-- digitToInt (от Data.Char) превръща символа '7' в числото 7.
-- Композицията се чете отдясно наляво: show, после map digitToInt, после sum.
digitSum :: Int -> Int
digitSum = sum . map digitToInt . show

numDigits :: Int -> Int
numDigits = length . show

-- read е обратното на show - от низ към стойност. От сигнатурата компилаторът
-- разбира, че трябва да прочете Int; без нея read "0321" би бил нееднозначен.
-- Водещата нула се губи при четенето - точно каквото искаме.
reverseNum :: Int -> Int
reverseNum = read . reverse . show
