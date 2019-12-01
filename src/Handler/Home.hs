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
        toWidgetHead $(luciusFile "templates/home.lucius")
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
       
        
        |]
        
        [whamlet|
        
        <header><h1>Review Game FTNT

        <main>
            <div class="divFlexs" id="divMap"><a href=@{HomeR} class="btns">find your map

            <div class="divFlexs" id="divPouso"><a href=@{HomeR} class="btns">locations on the map
                <!--<input type="button" value="ok">-->

            <div class="divFlexs" id="divPontosMap"><a href=@{HomeR} class="btns">discover your world

            <div id="container">
                <h2>about Us
                <p>This site is about the review of the game Fortinite Chapter 2. This idea came because we, just like you, are Gamers who wants to help other people with Tips and Knowledge. We share everything we know about the Map, Locations, Treasures, Better Ways to survive and a lot more to be #1. Let's help each other and make this the best experience of the game ever. Join us !
                <p id="pImg1"> oi
                <h2 class="elementRight">Lorem Ipsum
                <p class="elementRight">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                
        <footer>
            <nav id="menuFooter">
                <ul class="divFlexsFooter">
                        <li>
                            <a href=@{HomeR}>Home
                        <li>
                            <a href=@{HomeR}>Map
                        <li>
                            <a href=@{HomeR}>Combat
                        <li>
                            <a href=@{HomeR}>Characters
                        <li>
                            <a href=@{HomeR}>Chapter 2
                        <li>
                            <a href=@{HomeR}>Buy Fortnite
                <div id="logoFooter" class="divFlexsFooter">
                    <img src=@{StaticR imgMapFtnt_png} alt="Logo do site" height="150px" width="150px">
            <p>© 2019 - Review Game FTNT
        |]