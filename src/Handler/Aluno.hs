{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Aluno where

import Import
import Database.Persist.Postgresql
import Text.Julius
import Text.Lucius

-- marcação de divs renderDivs
formAluno :: Form Aluno
formAluno = rederBootsrap $ Aluno
    <$> areq textField  "Nome: " Nothing
-- areq = required / apot = opcional
-- Tudo acompanha o models, campos e se é opcional ou não
    <*> areq textField  "RA: " Nothing
    <*> areq dayField   "Data: " Nothing


getAlunoR :: Handler Html
getAlunoR = do 
    (widget, enctype) <- generateFormPost formAluno
    msg <- getMessage
    defaultLayout $ do
    addStylesheet (Static css_bootstrap_css)
        [whamlet |
            $maybe mensa <- msg --é um if
                <div>
                    ^{mensa}
            --$nothing é o else
                        <h1>
                            CADASTRO DE ALUNO
                        <form method = post action=@{AlunoR}>
                            ^{widget}
                            <button>
                                Cadastrar
        |]

postAlunoR :: Handler Html
postAlunoR = do
    ((result, _), _) <- runFormPost formAluno
    case result of
        FormSuccess aluno -> do
            runDB $ insert aluno
            setMessage[shamlet| -- shamlet é para mensagem no servidor
                <h2>
                    REGISTRO INCLUIDO
            |]
            redirect AlunoR
        _ -> redirect HomeR