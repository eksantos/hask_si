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
        @import url('https://fonts.googleapis.com/css?family=Londrina+Solid&display=swap');
        @import url('https://fonts.googleapis.com/css?family=Luckiest+Guy&display=swap');

        /**
        #f1fa3c amarelo
        #851de0 roxo
        #61f2f5 azul
        */
        
        body{
           
        }
        
        main{
            background-color: #fbfbfb;
            display: flex;
            padding: 50px;
            box-shadow: 0 0 1em #222831;
        }
        
        header h1{
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
            box-shadow: 0 0 1em #c8cfd9;
        }
        
        .divFlexs:hover{
            border: 2px dashed #61f2f5;
        }
        
        a.btns{
            padding: 3% 5%;
            display: inline-block;
            color: white;
            font-size: 1.5em;
            text-decoration: none;
            margin-top: 99%;
            background-color: #5c149b;
            box-shadow: 0 0 1em #222831;
            font-family: 'Londrina Solid', cursive;
        }
        
        a.btns:hover{
            /*transform: skew(-20deg);*/
            background-color: #17ecf0;
        }
        
        #divMap{
            background-image: url("static/imgMapFtnt.png");
            background-position: center;
        }
        
        #divPouso{
            background-image: url("static/imgpouso.jpeg");
            background-position: center;
        }
        
        #divPontosMap{
            background-image: url("static/imgpontosdomapa.jpeg");
            background-position: center;
        }
        
        div#container{
            margin: 5% 0;
        }
        
        
        p#pImg1{
            background-image: url("static/fundo2p.png");
            width: 100%;
            height: 600px;
        }
        
        .elementRight {
            text-align: right;
        }
        
        
        /*FOOTER*/
        
        footer{
            height: auto;
            background-color: #5c149b;
            box-shadow: 0 0 1em #222831;
            margin: 0;
            color: white; 
        }
        
        footer p{
            text-align: center;
            padding: 2% 0;
            font-size: 1.1em;
        }
        
        nav#menuFooter ul li{
            list-style: none;
            font-family: 'Londrina Solid', cursive;
            margin-bottom: 2px;
        }
        
        nav#menuFooter{
            font-family: 'Londrina Solid', cursive;
            display: flex;
            padding-top: 5%;
        }
        
        .divFlexsFooter{
            flex: 2;
            text-align: center;
        }
        
        nav#menuFooter ul li a{
            text-decoration: none;
            color: white;
            font-size: 1.2em;
        }
        
        nav#menuFooter ul li a:hover{
            color: #17ecf0;
            padding: 5px;
        }
        
        div#logoFooter{
           border-left: 1px solid #17ecf0;;
        }
        |]
        [whamlet|
           <header>
                <h1>Review Game FTNT

        <main>
            <div class="divFlexs" id="divMap">
                <a href=@{HomeR} class="btns">find your map

            <div class="divFlexs" id="divPouso">
                <a href=@{HomeR} class="btns">locations on the map
                <!--<input type="button" value="ok">-->

            <div class="divFlexs" id="divPontosMap">
                <a href=@{HomeR} class="btns">discover your world
            <div id="container">
            <h2>about Us
            <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
            <p id="pImg1"> oi
            <h2 class="elementRight">Lorem Ipsum
            <p class="elementRight">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
            

        <footer>
            <nav id="menuFooter">
                <ul class="divFlexsFooter">
                    <li><a href=@{HomeR}Home
                    <li><a href=@{HomeR}Map
                    <li><a href=@{HomeR}Combat
                    <li><a href=@{HomeR}Characters
                    <li><a href=@{HomeR}Chapter 2
                    <li><a href=@{HomeR}Buy Fortnite
                <div id="logoFooter" class="divFlexsFooter">
                        <img src="imgs/imgMapFtnt.png" alt="Logo do site" height="150px" width="150px"> 
    
            <p>© 2019 - Review Game FTNT</p>
        <!-
           $maybe nome <- sess
                    <li>
                        <div>
                            Ola #{nome}
                        <form method=post action=@{SairR}>
                            <input type="submit" value="Sair">
            $nothing
                    <h1>
                        CONVIDADO 
                        ->
        |]