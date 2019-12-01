{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Pontos where

import Import
import Text.Lucius
import Text.Julius
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql

-- renderDivs
formPonto :: Form Ponto
formPonto = renderBootstrap $ Ponto
    <$> areq textField "Nome: " Nothing

getPontoR :: Handler Html
getPontoR = do 
    (widget,_) <- generateFormPost formPonto
    msg <- getMessage
    defaultLayout $ 
        [whamlet|
            $maybe mensa <- msg 
                <div>
                    ^{mensa}

            <h1>
                CADASTRO DE Pontos

            <form method=post action=@{PontosR}>
                ^{widget}
                <input type="submit" value="Cadastrar">
        |]