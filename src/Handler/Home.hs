{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Home where

import Import
import Data.FileEmbed (embedFile)
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Text.Julius
import Text.Lucius

getAdsR :: Handler TypedContent
getAdsR = return $ TypedContent "text/plain"
    $ toContent $(embedFile "static/ads.txt")
    
getPage2R :: Handler Html
getPage2R = do
    defaultLayout $ do
        $(whamletFile "templates/page2.hamlet")
        toWidgetHead $(luciusFile "templates/page2.lucius")
        toWidgetHead $(juliusFile "templates/page2.julius")
    
getPage1R :: Handler Html
getPage1R = do
    defaultLayout $ do
        addScript (StaticR ola_js)
        [whamlet|
            <h1>
                PAGINA 1
                <a href=@{HomeR}>
                    Voltar
        |]

getHomeR :: Handler Html
getHomeR = do 
    sess <- lookupSession "_NOME"
    defaultLayout $ do 
    -- addScriptRemote "url" -> CHAMA JS EXTERNO
    -- addScript (StaticR script_js) -> JS INTERNO
        addStylesheet (StaticR css_bootstrap_css)
        toWidgetHead [julius|
        <!-- Global site tag (gtag.js) - Google Analytics -->
            <script async src="https://www.googletagmanager.com/gtag/js?id=UA-72614868-2"></script>
            <script>
                window.dataLayer = window.dataLayer || [];
                function gtag(){dataLayer.push(arguments);}
                gtag('js', new Date());
                gtag('config', 'UA-72614868-2');
        |]
        toWidgetHead [lucius|
        @import url('https://fonts.googleapis.com/css?family=Luckiest+Guy&display=swap');
        @import url('https://fonts.googleapis.com/css?family=Londrina+Solid&display=swap');
            main{
                background-color: #fbfbfb;
                display: flex;
                padding: 50px;
            }
             h1{
                font-size: 3em;
                color: black;
                font-family: 'Luckiest Guy', cursive;
                text-align: center;
            }
            .divFlexs{
                flex: 3;
                margin: 2%;
                height: 35rem;
                border: 2px solid #61f2f5;
                text-align: center;
                
            }
            a.btns{
                padding: 3% 5%;
                background-color: #851de0;
                display: inline-block;
                color: white;
                font-size: 1.5em;
                text-decoration: none;
                margin-top: 5%;
                box-shadow: 0 0 1em #f1f1f1;
                font-family: 'Londrina Solid', cursive;
            }

        |]
        [whamlet|
            <h1>
                REVIEW GAME FTNT
            
            <main>
                <div class="divFlexs">
                    <a href=@{HomeR} class="btns">learn more
                
                <div class="divFlexs">
                    <a href=@{HomeR} class="btns">learn more
    
                <div class="divFlexs">
                    <a href=@{HomeR} class="btns">learn more
            $maybe nome <- sess
                    <li>
                        <div>
                            Ola #{nome}
                        <form method=post action=@{SairR}>
                            <input type="submit" value="Sair">
            $nothing
                    <h1>
                        CONVIDADO
        |]