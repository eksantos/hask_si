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
    <head>
        <meta charset="UTF-8"/>
        <title>Review Game FTNT</title>
    </head>

    <body>
        <header><h1>Review Game FTNT </h1></header>

        <main>
            <div class="divFlexs" id="divMap">
                <a href="#" class="btns">find your map</a>
            </div>

            <div class="divFlexs" id="divPouso">
                <a href="#" class="btns">locations on the map</a>
                <!--<input type="button" value="ok">-->
            </div>

            <div class="divFlexs" id="divPontosMap">
                <a href="#" class="btns">discover your world</a>
            </div>
        </main>

        <div id="container">
            <h2>about Us</h2>
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
            <p id="pImg1"> oi</p>
            <h2 class="elementRight">Lorem Ipsum</h2>
            <p class="elementRight">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</p>
            
        </div>

        <footer>
            <nav id="menuFooter">
                <ul class="divFlexsFooter">
                    <li><a href="#">Home</a></li>
                    <li><a href="#">Map</a></li>
                    <li><a href="#">Combat</a></li>
                    <li><a href="#">Characters</a></li>
                    <li><a href="#">Chapter 2</a></li>
                    <li><a href="#">Buy Fortnite</a></li>
                </ul>
                <div id="logoFooter" class="divFlexsFooter">
                        <img src={@StaticR imgMapFtnt_png} alt="Logo do site" height="150px" width="150px"> 
                </div>
            </nav>
            <p>© 2019 - Review Game FTNT</p>
        </footer>
    </body>
        |]