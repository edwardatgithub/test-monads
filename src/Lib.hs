module Lib
  where

import Control.Monad.Cont

someFunc :: IO ()
someFunc = putStrLn "someFunc"

-- Without callCC
square :: Int -> Cont r Int
square n = return (n ^ 2)

-- With callCC
squareCCC :: Int -> Cont r Int
squareCCC n = callCC $ \k -> k (n ^ 2)

quux2 :: Cont r Int
quux2 = callCC $ \k -> do
    let n = 5
    k n
    return 25

quux :: Cont r Int
quux = cont $ \h -> runCont (  (    do {when True ( (cont $ \_ -> h 5) ) ;   return 35})
                            ) h

quux3 :: Cont r Int
quux3 = cont $ \h -> runCont (  (    when True ( (cont $ \_ -> h 5) ) >>   return 35 )
                            ) h
quux4 :: (Int -> r) -> r
quux4 = \h -> runCont (  (    when True ( (cont $ \_ -> h 5) ) >>= \_ ->  return 35 )
                            ) h
            
   
   
{--   
(>>) :: m a -> m b -> m b  
    x >> y = x >>= \_ -> y 
    
s >>= f  = cont $ \c -> runCont s $ \x -> runCont (f x) c
-- callCC f = cont $ \h -> runCont (f (\a -> cont $ \_ -> h a)) h
--}