module Import
    ( module Prelude
    , module Yesod
    , module Foundation
    , (<>)
    , Text
    , module Data.Monoid
    , module Control.Applicative
    ) where

import Prelude hiding (writeFile, readFile, head, tail, init, last)
import Yesod   hiding (Route(..))
import Foundation
import Data.Monoid (Monoid (mappend, mempty, mconcat))
import Control.Applicative ((<$>), (<*>), pure)
import Data.Text (Text)
import Settings.StaticFiles

infixr 5 <>
(<>) :: Monoid m => m -> m -> m
(<>) = mappend
