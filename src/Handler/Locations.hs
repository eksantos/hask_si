{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Locations where

import Import
import Data.FileEmbed (embedFile)
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Text.Julius
import Text.Lucius

getLocationsR :: Handler Html
getLocationsR = do 
    defaultLayout $ do 
    -- addScriptRemote "url" -> CHAMA JS EXTERNO
    -- addScript (StaticR script_js) -> JS INTERNO
        toWidgetHead $(luciusFile "templates/locations.lucius")
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
            <h2>Map Regions
            <p>Find more about your favorite place in the map !
            <ul id="ulRegions">
                <li class="liFlexs">
                    <a href="@{LocationsR}">Sands
                <li class="liFlexs">
                    <a href="@{LocationsR}">Holly Hedges
                <li class="liFlexs">
                    <a href="@{LocationsR}">Weeping Woods
                <li class="liFlexs">
                    <a href="@{LocationsR}">Slurpy Swamp
                <li class="liFlexs">
                    <a href="@{LocationsR}">Misty Meadows
                <li class="liFlexs">
                    <a href="@{LocationsR}">Lazy Lake
                <li class="liFlexs">
                    <a href="@{LocationsR}">Dirty Docks
                <li class="liFlexs">
                    <a href="@{LocationsR}">Frenzy Farm
                <li class="liFlexs">
                    <a href="@{LocationsR}">Steamy Sacks
                <li class="liFlexs">
                    <a href="@{LocationsR}">Craggy Cliffs
                <li class="liFlexs">
                    <a href="@{LocationsR}">Salty Springs
                <li class="liFlexs">
                    <a href="@{LocationsR}">Retail Row
                <li class="liFlexs">
                    <a href="@{LocationsR}">Pleasant Park
            
                
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
                            <a href=@{Chapter2R}>Chapter 2
                        <li>
                            <a href="https://www.epicgames.com/fortnite/en-US/home" target="_blank">Buy Fortnite
                <div id="logoFooter" class="divFlexsFooter">
                    <img src=@{StaticR imgMapFtnt_png} alt="Logo do site" height="128px" width="203px">
            <p>© 2019 - Review Game FTNT
        |]