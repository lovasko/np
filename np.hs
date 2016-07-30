import System.Environment

-- | Number base.
data Base = Binary
          | Octal
          | Decimal
          | Hexadecimal

-- | Base number of the base.
baseNumber :: Base    -- ^ base
           -> Integer -- ^ base number
baseNumber Binary      = 2
baseNumber Octal       = 8
baseNumber Decimal     = 10
baseNumber Hexadecimal = 16

-- | Set of digits based on the base.
baseDigits :: Base   -- ^ base
           -> String -- ^ digits
baseDigits base = take (baseNumber base) "0123456789abcdef"

numberValid :: String
            -> Base
            -> Bool
numberValid (x:xs) base = all (elem baseDigits base) xs elem x (baseDigits base) && numberValid xs base
numberValid []     _    = True

readNumber :: String
           -> Base
           -> Integer
readNumber xs base = 

writeNumber :: Integer
            -> Base
            -> String

processNumber :: String
              -> Base
              -> Base
              -> IO ()
processNumber xs inp out
  | numberValid xs inp = putStrLn $ writeNumber (readNumber xs ) out
  | otherwise                 = putStrLn "ERROR: invalid number"

-- | Parse the base identifier in the format description.
parseBase :: Char               -- ^ base identifier
          -> Either String Base -- ^ result
parseBase 'b' = Right Binary
parseBase 'o' = Right Octal
parseBase 'd' = Right Decimal
parseBase 'x' = Right Hexadecimal
parseBase b   = Left "Unknown base '" ++ [b] ++ "'"

-- | Parse the format description.
parseFormat :: String                     -- ^ format
            -> Either String (Base, Base) -- ^ result
parseFormat [a, b] = do
  inBase  <- parseBase a
  outBase <- parseBase b
  return (inBase, outBase)
parseFormat      _ = Left "The format must contain two characters"

-- | Parse the command-line arguments.
parseArgs :: [String]
          -> Either String (Base, Base, String)
parseArgs [format, number] = do
  (inBase, outBase) <- parseFormat format
  return (inBase, outBase, number)
parseArgs _                = Left "Expecting two arguments"

-- | Number Print.
main :: IO ()
main = do
  args <- getArgs
  case parseArgs args of
    Left errstr          -> exitFailure >> putStrLn $ "ERROR: " ++ errstr
    Right (inp, out, xs) -> exitSuccess >> processNumber inp out xs

