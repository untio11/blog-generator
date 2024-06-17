module Html.Internal where

-- Type definitions
newtype Html = Html String

newtype Document = Document Structure

newtype Structure = Structure String

-- Html Page Outline

htmlPage :: Structure -> Document
htmlPage = Document . html_

htmlHead :: String -> Structure
htmlHead = head_ . title_

htmlBody :: Structure -> Structure
htmlBody = body_

-- Helper
append_ :: Structure -> Structure -> Structure
append_ (Structure a) (Structure b) = Structure (a <> b)

render :: Html -> String
render (Html str) = str

renderStructure :: Structure -> String
renderStructure (Structure str) = str

renderDocument :: Document -> String
renderDocument (Document document) = renderStructure document

emptyStruct :: Structure
emptyStruct = Structure ""

joinStructs :: [Structure] -> Structure
joinStructs = foldl append_ emptyStruct

-- Unit Tags

html_ :: Structure -> Structure
html_ = el "html"

body_ :: Structure -> Structure
body_ = el "body"

head_ :: Structure -> Structure
head_ = el "head"

title_ :: String -> Structure
title_ = el "title" . Structure . escape

p_ :: String -> Structure
p_ = el "p" . Structure . escape

code_ :: String -> Structure
code_ = el "pre" . Structure . escape

h1_ :: String -> Structure
h1_ = el "h1" . Structure . escape

li_ :: Structure -> Structure
li_ = el "li"

ul_ :: [Structure] -> Structure
ul_ = el "ul" . joinStructs . map li_

ol_ :: [Structure] -> Structure
ol_ = el "ol" . joinStructs . map li_

-- Base Tag Stuff

el :: String -> Structure -> Structure
el name content =
  Structure $
    render (tagOpen name)
      <> renderStructure content
      <> render (tagClose name)

tagOpen :: String -> Html
tagOpen name = Html $ "<" <> name <> ">"

tagClose :: String -> Html
tagClose name = Html $ "</" <> name <> ">"

escape :: String -> String
escape =
  let escapeChar c =
        case c of
          '<' -> "&lt;"
          '>' -> "&gt;"
          '&' -> "&amp;"
          '"' -> "&quot;"
          '\'' -> "&#39;"
          _ -> [c]
   in concatMap escapeChar