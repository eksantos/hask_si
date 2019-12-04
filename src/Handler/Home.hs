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
       -- $(whamletFile "templates/main.hamlet")
        [whamlet|
        <form method=post action=@{postNoticiasR}>
            ^{widget}
            <input type="submit" value="Cadastrar">
        |]
        $(whamletFile "templates/footer.hamlet")

formNoticias :: Form Noticias
formNoticias = renderBootstrap $ Noticias 
    <$> areq textField "Nome: " Nothing
    <*> areq textField "E-mail: " Nothing

postNoticiasR :: Handler ()
postNoticiasR = do 
    ((result,_),_) <- runFormPost formNoticias
    case result of 
        FormSuccess (noticia) -> do
            runDB $ insert $ noticia
            setMessage [shamlet|
                        <div>
                            noticia inserida
                       |]
        _ -> setMessage [shamlet|
                <p>ERRO
            |]