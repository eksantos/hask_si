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
            <p>One of the biggest news of Chapter 2 is the presence of boats. In addition, players can fish and swim in the waters of the new map. With boats, you can move faster and shoot enemies. This will bring new game dynamics, with players being able to get around by air, soil and water.

            <p id="pImg1">

            <p class="elementRight">More aspects have been added to the gameplay. Now one player can carry the other down. This is for both friends to take them to safe places and enemies to do the opposite. The arsenal of weapons has been simplified, but it has also brought Bandage Bazooka, a weapon that fires a projectile capable of extending the life of its allies.

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
                            <a href=@{Chapter2R}>Chapter 2
                        <li>
                            <a href="https://www.epicgames.com/fortnite/en-US/home" target="_blank">Buy Fortnite
                <div id="logoFooter" class="divFlexsFooter">
                    <img src=@{StaticR imgMapFtnt_png} alt="Logo do site" height="150px" width="150px">
            <p>© 2019 - Review Game FTNT
        |]