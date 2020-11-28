import Data.Char
import Data.List
import Control.Monad

lookAndSay :: String -> String
lookAndSay s = join $ map (\a -> [intToDigit $ length a, head a]) $ group s

main = mapM_ putStrLn $ take 10 $ iterate lookAndSay "1"

{-

% runhaskell look-and-say.hs
1
11
21
1211
111221
312211
13112221
1113213211
31131211131221
13211311123113112211

-}
