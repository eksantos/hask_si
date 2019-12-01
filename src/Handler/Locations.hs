{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Locations where

import Import
import Text.Lucius
import Text.Julius
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql

pontoCB = do
  rows <- runDB $ selectList [] [Asc PontoNome]
  optionsPairs $ 
      map (\r -> (pontoNome $ entityVal r, entityKey r)) rows

-- renderDivs
formLocations :: Form Locations 
formLocations = renderBootstrap $ Locations
    <$> areq (selectField pontoCB) "Location: " Nothing
    <*> areq textField "Comment: " Nothing

getLocationsR :: PontoId -> Handler Html
getLocationsR pontoid = do 
    let sql = "SELECT ?? FROM ponto \
          \ WHERE ponto.id = ?"
    ponto <- runDB $ rawSql sql [toPersistValue pontosid] :: Handler [(Entity Ponto, Entity Locations)]
    defaultLayout $ do 
        [whamlet|
            <h1>
                Local #{pontoNome ponto}
            <ul>
                $forall (Entity _ _, Entity _ ponto) <- pontos
                    <li>
                        #{pontoNome ponto}
        |]