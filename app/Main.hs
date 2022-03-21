module Main where

import           Asterius.Text  ( textFromJSString, textToJSString )
import           Asterius.ByteString (byteStringFromJSUint8Array)
import           Asterius.Types ( JSString(..), JSUint8Array(..), fromJSString )
import           Data.Maybe     ( fromMaybe )
import qualified Data.Text      as T
import qualified Data.ByteString.Lazy as BSL
import           Text.Pandoc
    ( Pandoc
    , PandocMonad
    , ReaderOptions
    , WriterOptions
    -- , Reader( TextReader, ByteStringReader )
    , Reader( ByteStringReader )
    , def
    , getReader
    -- , readHtml
    -- , readLaTeX
    -- , readMarkdown
    , runPure
    , writeHtml5String
    , writeLaTeX
    , writeMarkdown
    )

main :: IO ()
main = error "built with --no-main"

-- convertFromTo :: T.Text -> String -> T.Text -> Maybe T.Text
convertFromTo :: T.Text -> String -> BSL.ByteString -> Maybe T.Text
convertFromTo from to input =
    case runPure $ (getReader from) of
        Left err  -> error (show err)
        Right (ByteStringReader reader, es) -> case runPure $ reader def input of
            Left err  -> error (show err)
            Right doc -> case runPure $ (writerOf to) def doc of
                Left err     -> error (show err)
                Right output -> Just output

type PandocReader m = ReaderOptions -> T.Text -> m Pandoc

-- readerOf :: PandocMonad m => String -> PandocReader m
-- readerOf fromFormat = case runPure $ getReader fromFormat of
--                         Right (TextReader r, es) -> r def{
--                         readerExtensions = es }
--                         _ -> error $ "could not find reader for "
--                                   ++ fromFormat

-- readerOf "markdown" = readMarkdown
-- readerOf "html"     = readHtml
-- readerOf "latex"    = readLaTeX
-- readerOf _          = readMarkdown

-- let reader = case runPure $ getReader fromFormat of
--                     Right (TextReader r, es) -> r readerOpts{
--                        readerExtensions = es }
--                     _ -> error $ "could not find reader for " ++ T.unpack fromFormat

type PandocWriter m = WriterOptions -> Pandoc -> m T.Text

writerOf :: PandocMonad m => String -> PandocWriter m
writerOf "markdown" = writeMarkdown
writerOf "html"     = writeHtml5String
writerOf "latex"    = writeLaTeX
writerOf _          = writeMarkdown

-- convert :: JSString -> JSString -> JSString -> JSString
convert :: JSString -> JSString -> JSUint8Array -> JSString
convert from to =
      textToJSString
    . fromMaybe (T.pack "")
    . convertFromTo (textFromJSString from) (fromJSString to)
    . BSL.fromStrict
    . byteStringFromJSUint8Array

-- foreign export javascript "convert" convert :: JSString -> JSString -> JSString -> JSString
foreign export javascript "convert" convert :: JSString -> JSString -> JSUint8Array -> JSString
