module Main where

import System.IO
import Control.Monad
import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Expr
import Text.ParserCombinators.Parsec.Language
import qualified Text.ParserCombinators.Parsec.Token as Token

-- grammer
-- n = (0-9)+ 
-- kakko = n | (addsub)
-- muldev = n ( (*|/) n)*
-- addsub = muldev ( (+|-) muldev)*

data AExpr =  IntConst Integer
              deriving (Show)
languageDef = 
    emptyDef{
        Token.identLetter = alphaNum
    }
lexer = Token.makeTokenParser languageDef

integer    = Token.integer  lexer

aTerm      = liftM IntConst integer


statementParser :: Parser AExpr

statementParser = do
    term <- aTerm
    
    return $ term

parseString :: String  -> AExpr
parseString str = 
    case parse statementParser "" str of
        Right e -> e
        Left e -> error $ show e
    
main :: IO ()
main = do
    putStrLn $ show $ parseString "123"
    

