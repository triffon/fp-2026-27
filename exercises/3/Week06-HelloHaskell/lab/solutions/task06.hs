main :: IO()
main = do
    print $ isPalindrome 6 == True
    print $ isPalindrome 1010 == False
    print $ isPalindrome 505 == True
    print $ isPalindrome 123321 == True
    print $ isPalindrome 654 == False

    print $ isPalindromeDigits 6 == True
    print $ isPalindromeDigits 1010 == False
    print $ isPalindromeDigits 505 == True
    print $ isPalindromeDigits 123321 == True
    print $ isPalindromeDigits 654 == False

getReversedNumber :: Int -> Int
isPalindrome :: Int -> Bool

-- result е вече обърнатата част: на всяка стъпка "залепяме" последната
-- цифра на current отдясно на result и скъсяваме current с една цифра.
getReversedNumber n = helper n 0
 where
    helper :: Int -> Int -> Int
    helper 0 result = result
    helper current result = helper (div current 10) (result * 10 + mod current 10)

isPalindrome n = n == getReversedNumber n

-- Алтернативно решение: разбиваме числото на списък от цифри с pattern matching
-- и ползваме вградената reverse - число е палиндром, когато списъкът от цифрите
-- му съвпада с обърнатия си, така че не ни трябва акумулатор.
digits :: Int -> [Int]
digits 0 = []
digits n = mod n 10 : digits (div n 10)

isPalindromeDigits :: Int -> Bool
isPalindromeDigits n = digits n == reverse (digits n)
