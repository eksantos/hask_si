{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Combat where

import Import
import Data.FileEmbed (embedFile)
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Text.Julius
import Text.Lucius

getCombatR :: Handler Html
getCombatR = do 
    defaultLayout $ do 
    -- addScriptRemote "url" -> CHAMA JS EXTERNO
    -- addScript (StaticR script_js) -> JS INTERNO
        toWidgetHead $(luciusFile "templates/map.lucius")
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
            <title>Review Game FTNT
            
        <header><h1>Review Game FTNT </h1></header>
        
        <div id="container">
            <h2>Combat
            
                
        <footer>
            <nav id="menuFooter">
                <ul class="divFlexsFooter">
                        <li>
                            <a href=@{HomeR}>Home
                        <li>
                            <a href=@{MapR}>Map
                        <li>
                            <a href=@{CombatR}>Combat
                        <li>
                            <a href=@{CharactersR}>Characters
                        <li>
                            <a href=@{HomeR}>Chapter 2
                        <li>
                            <a href="https://www.epicgames.com/fortnite/en-US/home" target="_blank">Buy Fortnite
                <div id="logoFooter" class="divFlexsFooter">
                    <img src=@{StaticR imgMapFtnt_png} alt="Logo do site" height="150px" width="150px">
            <p>© 2019 - Review Game FTNT
        |]