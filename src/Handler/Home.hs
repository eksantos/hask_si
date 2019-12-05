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
                <a href=@{HomeR} id="linkH1">
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

        |]
        $(whamletFile "templates/main.hamlet")
        [whamlet|
            <h1 id="h1Form"> always be the first to receive our news. Sign up, it's free!
            <form method=post action=@{NoticiasR}>
                ^{widget}
                <input type="submit" value="REGISTER" id="btnRegister">
        |]
        $(whamletFile "templates/footer.hamlet")

formNoticias :: Form Noticias
formNoticias = renderBootstrap $ Noticias 
    <$> areq textField "Name: " Nothing
    <*> areq textField "E-mail: " Nothing

postNoticiasR :: Handler Html
postNoticiasR = do 
    ((result,_),_) <- runFormPost formNoticias
    case result of 
        FormSuccess (noticia) -> do
            runDB $ insert $ noticia
            setMessage [shamlet|
                        <h1 class="cadSucesso">
                            Register Success 
                       |]
            redirect HomeR
        _ -> redirect HomeR