> {-# LANGUAGE DeriveDataTypeable #-}

*LZ76.lhs* - Entry point. Parse the command line arguments and call ExhaustiveParsing

> -- Write the help
> import System.Console.CmdArgs
> import ExhaustiveParsing
> import qualified Data.ByteString.Lazy.Char8 as C
> import qualified Data.ByteString.Lazy as B
> import Data.List

> summaryStr = summary "LZ76 : Compute the Lempel-Ziv complexity of binary strings."
> data LZ76 = 
>		LZ {filename :: FilePath} 
>		| Kolmogorov {filename :: FilePath} 
>		| MeanKolmogorov {filename :: FilePath} deriving (Show, Data, Typeable)

> lz = LZ {filename = "strings" &= strFnHelp}
> kolmogorov = Kolmogorov {filename = "strings" &= strFnHelp}
> meanKolmogorov = MeanKolmogorov {filename = "strings" &= strFnHelp}

> strFlHelp = help "Flavour of the algorithm. Default is LZ76." --FIXME : This help is useless. Detail.
> strFnHelp = help "Path to the file containing the strings. One str/line."

> mode = cmdArgs $ modes [lz&=auto,kolmogorov,meanKolmogorov] &= summaryStr

> printDistribution :: [Float] -> String
> printDistribution = concat.(intersperse "\n").(map show)

> main = 
>	do
>		args <- mode
>		case args of 

	- If it is `lz` (default) then return the length of the history after the exhaustive parsing.

>			LZ {filename = fn} -> do 
>				str <- getStr fn
>				(putStrLn.printDistribution.(map (fromIntegral.parse))) str

	- If it is `kolmogorov` then return the same thing as `lz` but multiply by log2(string length).

>			Kolmogorov {filename = fn} -> do
>				str <- getStr fn
>				(putStrLn.printDistribution.(map k)) str

	- If it is `meankolmogorov` then return the mean `kolmogorov` of the string and its reverse.

>			MeanKolmogorov {filename = fn} -> do
>				str <- getStr fn
>				(putStrLn.printDistribution.(map meanK)) str
>	where 
>		getStr f = fmap C.lines (B.readFile f)	
>		k s = ((*(logBase 2 (fromIntegral $ B.length s))).fromIntegral.parse) s
>		meanK s = (k(s) + k(B.reverse s))*0.5
