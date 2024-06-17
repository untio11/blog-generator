module Main (main) where

import Html

main :: IO ()
main = putStrLn $ renderDocument $ htmlPage (append_ title body)
  where
    title =
      htmlHead "Title Card"
    body =
      htmlBody $
        joinStructs
          [ h1_ "Nice <programming language> bro",
            p_ "T-t-th.. Thanks....",
            p_ "Reasons to be cool:",
            ol_
              [ p_ "It's cool",
                p_ "Not being cool sucks "
              ],
            p_ "Reansons not to be cool:",
            ul_ [],
            code_ "Sum epic programmer shit"
          ]