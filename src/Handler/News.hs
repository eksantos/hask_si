{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.News where

import Import
import Database.Persist.Postgresql
import Text.Julius
import Text.Lucius

getListNoticiasR :: Handler Html 
getListNoticiasR = do 
    -- select * from aluno order by aluno.nome
    noticias <- runDB $ selectList [] [Asc NoticiasNome]
    defaultLayout $ do 
        $(whamletFile "templates/noticias.hamlet")

postApagarNoticiasR :: NoticiasId -> Handler Html 
postApagarNoticiasR aid = do 
    _ <- runDB $ get404 aid
    runDB $ delete aid 
    redirect ListNoticiasR