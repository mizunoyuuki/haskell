import System.Exit

answer :: Int
answer = 21 + 21

main :: IO()
main = exitWith (ExitFailure answer)
