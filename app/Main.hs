module Main where

main :: IO ()
main = putStrLn $ makeHtml "Title Card" body
  where 
    body = h1_ "Nice programming language bro" <> p_ "T-t-th.. Thanks...."


makeHtml :: String -> String -> String
makeHtml title content = htmlPage $ htmlHead title <> htmlBody content  


-- Type definitions
newtype Html = Html String
newtype HtmlDocument = HtmlDocument String
newtype HtmlStructure = HtmlStructure String


-- Html Page Outline

htmlPage :: HtmlStructure -> HtmlDocument
htmlPage = html_

htmlHead :: HtmlStructure -> HtmlStructure
htmlHead title = head_ $ title_ title

htmlBody :: HtmlStructure -> HtmlStructure
htmlBody = body_


-- Helper
append_ :: HtmlStructure -> HtmlStructure -> HtmlStructure
append_ (HtmlStructure a) (HtmlStructure b) = HtmlStructure (a <> b)

render :: Html -> String
render (Html str) = str

renderStructure :: HtmlStructure -> String
renderStructure (HtmlStructure str) = str

-- Unit Tags

html_ :: HtmlStructure -> HtmlStructure
html_ = tag "html"

body_ :: HtmlStructure -> HtmlStructure
body_  = tag "body"

head_ :: HtmlStructure -> HtmlStructure
head_ = tag "head"

title_ :: HtmlStructure -> HtmlStructure
title_ = tag "title"

p_ :: HtmlStructure -> HtmlStructure
p_ = tag "p"

h1_ :: HtmlStructure -> HtmlStructure
h1_ = tag "h1"


-- Base Tag Stuff

tag :: String -> HtmlStructure -> HtmlStructure
tag name content = HtmlStructure $ 
  render (tagOpen name) <> 
  renderStructure content <> 
  render (tagClose name)

tagOpen :: String -> Html
tagOpen name = Html $ "<" <> name <> ">"

tagClose :: String -> Html
tagClose name = Html $ "</" <> name <> ">"
