> {-# OPTIONS_GHC -XViewPatterns #-}

*ExhaustiveParsing.lhs* - Perform an exhaustive parsing of a binary string.

> module ExhaustiveParsing(parse) where
> import qualified Data.ByteString.Lazy as B
> import qualified Data.Set as S


`terminalVocabulary` : Given a string s1s2...srsr+1 return the elements of v(s1s2...) in which sr+1 appears.

> terminalVocabulary :: B.ByteString -> S.Set B.ByteString
> terminalVocabulary (B.uncons -> Nothing) = S.empty
> terminalVocabulary (B.uncons -> Just (x,(==B.empty) -> True)) = S.singleton $ B.pack [x]
> terminalVocabulary s = S.fromList [i `B.snoc` e | i <- (B.tails (B.init s)), e <- [B.last s]] 

`parse` : Exhaustive parsing of the string. Returns the length of the history. If the parsing
is not exhaustive then add one ( *e.g.* 0 | 1 | 01010101 is not exhaustive)

> parse :: B.ByteString -> Int
> parse s =
>		let
>			parseNext (dict,current,voc) w = 
>				if S.member ext voc
>					then (dict,ext,extvoc)
>					else (dict ++ [ext],B.empty,extvoc)
>				where 
>					ext = B.snoc current w
>					extvoc = voc `S.union` (terminalVocabulary $ B.concat dict `B.append` ext)
>			buildDictionary = B.foldl parseNext ([],B.empty,S.empty) 
>		in
>			(\(x,r,_) -> length x + (if B.null r then 0 else 1)) $ buildDictionary s
