import Data.Char

-- String е просто [Char], затова всички функции за списъци работят и върху низове.

-- show: от стойност към низ (42 -> "42")
numberToString :: Int -> String
numberToString n = show n

-- read: от низ към стойност; типът на резултата се определя от сигнатурата
-- (или от контекста), затова без нея read "17" е нееднозначно.
stringToNumber :: String -> Int
stringToNumber str = read str

-- digitToInt (от Data.Char): от символ-цифра към числото, което представя ('7' -> 7)
charToDigit :: Char -> Int
charToDigit ch = digitToInt ch

-- Още от Data.Char: toLower/toUpper, isDigit/isAlpha/isUpper/isSpace,
-- ord/chr (кодът на символ и обратно).
-- words/unwords разделят/слепват низ по интервали, lines/unlines - по нови редове.
main :: IO()
main = do
    print $ numberToString 42         -- "42"
    print $ stringToNumber "17" + 1   -- 18
    print $ charToDigit '7'           -- 7
    print $ show 3.5                  -- "3.5"
    print (read "[1,2,3]" :: [Int])   -- [1,2,3] - read работи за всеки тип с инстанция Read
    print $ toUpper 'a'               -- 'A'
    print $ map toLower "HaSkElL"     -- "haskell"
    print $ isDigit '7'               -- True
    print $ isAlpha '7'               -- False
    print $ ord 'a'                   -- 97
    print $ chr 98                    -- 'b'
    print $ words "to be or not"      -- ["to","be","or","not"]
    print $ unwords ["to", "be"]      -- "to be"
    print $ lines "first\nsecond"     -- ["first","second"]
    -- Низът е списък, затова работят и обичайните функции за списъци.
    print $ reverse "abc"             -- "cba"
    print $ length "abc"              -- 3
    print $ 'a' : "bc"                -- "abc"
    print $ "ab" ++ "cd"              -- "abcd"
    print $ filter isDigit "a1b2c3"   -- "123"
