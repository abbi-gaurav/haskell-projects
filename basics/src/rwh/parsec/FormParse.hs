module FormParse where

import           Control.Monad
import           Numeric
import           Text.ParserCombinators.Parsec
import           Text.ParserCombinators.Parsec.Char

p_query :: CharParser () [(String, Maybe String)]
p_query = p_pair `sepBy` char '&'

p_pair :: CharParser () (String, Maybe String)
p_pair = liftM2 (,) (many1 p_char) (optionMaybe (char '=' >> many p_char))


p_char :: CharParser () Char
p_char = oneOf urlBaseChars
  <|> (char '+' >> return ' ')
  <|> p_hex

urlBaseChars = ['a'..'z'] ++ ['A'..'Z'] ++ ['0'..'9'] ++ "$-_.!*'(),"

p_hex :: CharParser () Char
p_hex = do
  char '%'
  a <- hexDigit
  b <- hexDigit
  let ((d,_):_) = readHex [a,b]
  return . toEnum $ d