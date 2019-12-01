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

-- marcação de divs renderDivs
formEmail :: Form Email
formEmail = renderBootstrap $ Email 
    <$> areq textField  "Nome: " Nothing
-- areq = required / apot = opcional
-- Tudo acompanha o models, campos e se é opcional ou não
    <*> areq textField  "Email: " Nothing

-- $maybe é um if 
-- $nothing é o else 

getEmailR :: Handler Html 
getEmailR = do 
    (widget, enctype) <- generateFormPost formEmail
    msg <- getMessage
    defaultLayout $ do 
        addStylesheet (StaticR css_bootstrap_css)
        [whamlet|
            $maybe mensa <- msg
                <div>
                    ^{mensa}
            
            <h1>
                CADASTRO DE EMAIL
            
            <form method=post action=@{EmailR}>
                ^{widget}
                <button>
                    Cadastrar
        |]

postEmailR :: Handler Html 
postEmailR = do 
    ((result,_),_) <- runFormPost formEmail
    case result of 
        FormSuccess email -> do 
            runDB $ insert email 
            setMessage [shamlet|
                <h2>
                    REGISTRO INCLUIDO
            |]
            redirect EmailR
        _ -> redirect HomeR

getListEmailR :: Handler Html 
getListEmailR = do 
    -- select * from aluno order by aluno.nome
    alunos <- runDB $ selectList [] [Asc EmailNome]
    defaultLayout $ do 
        $(whamletFile "templates/alunos.hamlet")

postApagarEmailR :: EmailId -> Handler Html 
postApagarEmailR aid = do 
    _ <- runDB $ get404 aid
    runDB $ delete aid 
    redirect ListEmailR