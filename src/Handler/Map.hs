{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE TypeFamilies #-}
module Handler.Map where

import Import
import Data.FileEmbed (embedFile)
--import Network.HTTP.Types.Status
import Database.Persist.Postgresql
import Text.Julius
import Text.Lucius

getMapR :: Handler Html
getMapR = do 
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
            <h2>Map
            <p>The setting has a completely refurbished battlefield with 13 locations. In order for players to explore this new territory, the game received missions called “New World”. In it, one of the goals requires the user to discover the ten new points of interest. Anyone who starts playing the new season will come across a gray map and question marks. When you arrive at each point of interest, gray is replaced by the normal map colors and the name of the location is shown.
            <p id="pImg1">
            <p class="elementRight">The new map has 13 points of interest. Of these, ten are unheard of: Sweaty Sands, Holly Hedges, Weeping Woods, Slurpy Swamp, Misty Meadows, Lazy Lake, Dirty Docks, Frenzy Farm, Steamy Sacks and Craggy Cliffs. Three other locations are reminiscent of past seasons: Salty Springs, Retail Row and Pleasant Park.
            <p class="elementRight">Fortnite's new world is dramatically different from past seasons. This is mainly due to the role that water will play in the game. Rivers and lakes center and meet at the center of the map, bringing new ways to explore paths and locomotion to the safe zone.
            <p class="elementRight">The biomes in the map regions are also very varied. Players will find places with coastal landscapes, mountains, lakes, farms, forests and swamps. There are many open and elevated spaces to explore, and this should have a direct impact on gameplay.
            <a href="@{MapR}" class="btns">find your map
            <a href="@{LocationsR}" class="btns">locations on the map
                
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