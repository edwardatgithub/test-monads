module Lib
    ( someFunc,
      f1
    ) where

import Control.Monad.Writer

someFunc :: IO ()
someFunc = putStrLn "someFunc"



f1 x = writer (x*3 ,1) :: Writer (Sum Int) Int