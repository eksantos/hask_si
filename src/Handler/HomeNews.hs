{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.HomeNews where

import Import
import Database.Persist.Postgresql
import Text.Julius
import Text.Lucius
import Database.Persist.Postgresql

-- renderDivs
formLogin :: Form (Text, Text)
formLogin = renderBootstrap $ (,)
    <$> areq emailField "E-mail: " Nothing
    <*> areq passwordField "Senha: " Nothing
    
getHomeNR :: Handler Html
getHomeNR = do 
    (widget,_) <- generateFormPost formLogin
    msg <- getMessage
    defaultLayout $ do
        $(whamletFile "templates/main.hamlet")
        toWidgetHead $(luciusFile "templates/home.lucius")
        toWidget
            [whamlet|
                $maybe mensa <- msg 
                    <div>
                        ^{mensa}
                
                <h1>
                    ENTRAR
                
                <form method=post action=@{HomeR}>
                    ^{widget}
                    <input type="submit" value="Entrar">
            |]
        $(whamletFile "templates/footer.hamlet")
    
    
postHomeNR :: Handler Html
postHomeNR = do 
    ((result,_),_) <- runFormPost formLogin
    case result of 
        FormSuccess ("root@root.com","root125") -> do 
            setSession "_NOME" "admin"
            redirect AdminR
        FormSuccess (email,senha) -> do 
           -- select * from usuario where email=digitado.email
           usuario <- runDB $ getBy (UniqueEmailIx email)
           case usuario of 
                Nothing -> do 
                    setMessage [shamlet|
                        <div>
                            E-mail NAO ENCONTRADO!
                    |]
                    redirect EntrarR
                Just (Entity _ usu) -> do 
                    if (usuarioSenha usu == senha) then do
                        setSession "_NOME" (usuarioNome usu)
                        redirect HomeR
                    else do 
                        setMessage [shamlet|
                            <div>
                                Senha INCORRETA!
                        |]
                        redirect EntrarR 
        _ -> redirect HomeR