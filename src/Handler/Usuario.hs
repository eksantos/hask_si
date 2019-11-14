{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Usuario where

import Import
import Database.Persist.Postgresql
import Text.Julius
import Text.Lucius
import Database.Persist.Postgresql

-- renderDivs
formUsu :: Form (Usuario, Text)
formUsu = renderBootstrap $ (,)
    <$> (Usuario 
        <$> areq textField "Nome: " Nothing
        <*> areq emailField "E-mail: " Nothing
        <*> areq passwordField "Senha: " Nothing)
    <*> areq passwordField "Digite Novamente: " Nothing

getUsuarioR :: Handler Html
getUsuarioR = do 
    (widget,_) <- generateFormPost formUsu
    msg <- getMessage
    defaultLayout $ 
        [whamlet|
            $maybe mensa <- msg 
                <div>
                    ^{mensa}
            
            <h1>
                CADASTRO DE USUARIO
            
            <form method=post action=@{UsuarioR}>
                ^{widget}
                <input type="submit" value="Cadastrar">
        |]
