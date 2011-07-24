{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE OverloadedStrings #-}

module Handlers.NewLog
       (
         getNewLogR,
         postNewLogR
         ) where

import Homepage
import Model
import qualified Settings
import Yesod
import Yesod.Auth
import Control.Applicative
import Text.Hamlet
import Text.Cassius
import Data.Text (Text)
import Data.Time

data Params = Params
     { title :: Text
     , text :: Text
     }
     
paramsFormlet :: Maybe Params -> Form s m Params
paramsFormlet mparams = fieldsToTable $ Params
    <$> stringField "Title" (fmap title mparams)
    <*> stringField "Text" (fmap text mparams)

getNewLogR :: Handler RepHtml
getNewLogR = do
  requireAuth
  (_, form, enctype) <- runFormGet $ paramsFormlet Nothing
  defaultLayout $ do
    $(Settings.hamletFile "newlog")


postNewLogR :: Handler ()
postNewLogR = do
  (uid, _) <- requireAuth
  (res, _, _) <- runFormPostNoNonce $ paramsFormlet Nothing
  case res of
    FormSuccess (Params title text) -> do
      now <- liftIO getCurrentTime
      runDB $ insert $ Article title text "" now
      redirect RedirectTemporary LogR
      return ()
    _ -> do
      redirect RedirectTemporary NewLogR
      return ()
