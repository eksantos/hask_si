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
    (widget,_) <- generateFormPost formNoticias
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
        [whamlet|
        <head>
            <title>Review Game FTNT
        
        <header>
            <h1>Review Game FTNT

        <main>
            <div class="divFlexs" id="divMap">
                <a href=@{MapR} class="btns">find your map

            <div class="divFlexs" id="divPouso">
                <a href=@{LocationsR} class="btns">locations on the map

            <div class="divFlexs" id="divPontosMap">
                <a href=@{HomeR} class="btns">discover your world

        <div id="container">
            <h2>about Us
            <p>This website is about the review of the game Fortinite Chapter 2. This idea came because we, just like you, are Gamers who wants to help other people with Tips and Knowledge. We share everything we know about the Map, Locations, Treasures, Better Ways to survive and a lot more to be #1. Let's help each other and make this the best experience of the game ever. Join us !
            <p id="pImg1">
            <h2 class="elementRight">Chapter 2
            <p class="elementRight">Welcome to Fortinite Chapter 2 ! Welcome to a new World where you can choose your landing spot and explore everything that the Island can give you. Now you can swim, fish, ride your motorboats and have an exciting experience. Remember your squad ? Now you can support them ! Healing your teammates with bandages, carrying them to safety and celebrates with lots of high fives ! Just don't be the one who Friendly Fire. Let's play together with more fun, level up your character with a new XP system and earn medals every match. Have fun !
            <p id="pImg3">
        <form method=post action=@{postNoticiasR}>
            ^{widget}
            <input type="submit" value="Cadastrar">
        |]
        $(whamletFile "templates/footer.hamlet")

formNoticias :: Form (Noticias)
formNoticias = renderBootstrap $ (,)
    <$> (Noticias 
        <$> areq textField "Nome: " Nothing
        <*> areq textField "E-mail: " Nothing
    <*>


postNoticiasR :: Handler Html
postNoticiasR = do 
    ((result,_),_) <- runFormPost formNoticias
    case result of 
        FormSuccess noticia -> do
            noticiaId <- insert $ Noticias noticia
            setMessage [shamlet|
                        <div>
                            noticia #{noticiaId} inserida
                       |]
            redirect HomeR 
        _ -> setMessage 
            [shamlet|
                <p>ERRO
            |]
             redirect HomeR 