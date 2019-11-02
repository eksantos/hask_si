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
    defaultLayout $ do 
    -- addScriptRemote "url" -> CHAMA JS EXTERNO
    -- addScript (StaticR script_js) -> JS INTERNO
        addStylesheet (StaticR css_bootstrap_css)
        toWidgetHead [julius|
            function ola(){
                alert("PIKA !");
            }
        <script async src="https://www.googletagmanager.com/gtag/js?id=UA-72614868-2">
        <script>
              window.dataLayer = window.dataLayer || [];
              function gtag(){dataLayer.push(arguments);}
              gtag('js', new Date());
            
              gtag('config', 'UA-72614868-2');
        |]
        toWidgetHead [lucius|
            h1 {
                color : red;
            }
            li {
                display: inline;
            }
        |]
        [whamlet|
            <h1>
                BEM-VINDO A PAGINA DO PIKACHU !
            
            <ul>
                <li>
                    <a href=@{Page1R}>
                        PAGINA 1
                <li>
                    <a href=@{Page2R}>
                        PAGINA 2
                        
            <img src=@{StaticR pikachu_jpg}>
            <button class="btn btn-danger" onclick="ola()">
                PIKACHU !
        |]