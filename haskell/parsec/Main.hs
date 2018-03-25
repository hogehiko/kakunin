module Main where

import System.IO
import Control.Monad
import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Expr
import Text.ParserCombinators.Parsec.Language
import Data.List
import qualified Text.ParserCombinators.Parsec.Token as Token

-- grammer
-- n = (0-9)+ 
-- kakko = n | (addsub)
-- muldev = n ( (*|/) n)*
-- addsub = muldev ( (+|-) muldev)*

data AExpr =  IntConst Integer
             | ABinary ABinOp AExpr AExpr   
              deriving (Show)

data ABinOp = Add
            | Subtract
              deriving (Show)
              
data IRExpre = IRExpre String String deriving (Show)

varPointer (IRExpre s p) = p
statementOf (IRExpre s p) = s

data Environment = Environment Integer deriving (Show)

varCount (Environment i) = i

data ParseResult = ParseResult [IRExpre] Environment deriving (Show)
envOf (ParseResult x env) = env
statementsOf (ParseResult x env) = x


languageDef = 
    emptyDef{
        Token.identLetter = alphaNum
        ,Token.reservedOpNames = ["+", "-"]
    }
lexer = Token.makeTokenParser languageDef

integer    = Token.integer  lexer
reservedOp = Token.reservedOp lexer

aTerm      = liftM IntConst integer

aOperators = [ 
               [Infix  (reservedOp "+"   >> return (ABinary Add     )) AssocLeft,
                Infix  (reservedOp "-"   >> return (ABinary Subtract)) AssocLeft]
             ]

aExpression :: Parser AExpr
aExpression = buildExpressionParser aOperators aTerm
statementParser :: Parser AExpr

statementParser = do
    exp <- aExpression
    return $ exp

parseString :: String  -> AExpr
parseString str = 
    case parse statementParser "" str of
        Right e -> e
        Left e -> error $ show e

showOp Add = "add"
showOp Subtract = "sub"


convertToIR :: AExpr -> Environment -> ParseResult
convertToIR (IntConst i) env = 
    ParseResult [(IRExpre "" (show i))]  env

convertToIR (ABinary op left right) env = 
    ParseResult (exp : ((statementsOf irRight) ++ (statementsOf irLeft)))  (Environment $ (varCount (envOf irRight) + 1))
    where 
        irLeft = convertToIR left env
        irRight = convertToIR right $ envOf irLeft
        varF = (varPointer . head . statementsOf)
        statementString ="%"++(show (varCount  (envOf irRight)))++" = "++(showOp op)++" nsw i32 "++(varF irLeft)++","++ (varF irRight)
        exp = IRExpre statementString $ "%"++(show (varCount  (envOf irRight)))

printIR :: [IRExpre] -> IO()
printIR [] = do
    putStrLn ""

printIR (head:tail) = do
    if statementOf head == "" then
        putStr ""
    else 
        (putStrLn.statementOf) head
    printIR tail



main :: IO ()
main = do
    printIR $ (reverse.statementsOf) $ result
    where result = convertToIR  (parseString  "0 +1-2+  4") $ Environment 1
          
    


