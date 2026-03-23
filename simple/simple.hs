module Main where

-- xは42であるという定義(代入ではなく定義)
x :: Int
x = 42

main :: IO()
main = if x == 44
    then return ()    -- 正常終了
    else error "fail" -- 以上終了


