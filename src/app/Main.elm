module Main exposing (main)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes as Attr
import Url



-- MAIN


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }



-- INIT


type alias Model =
    { message : String
    , key : Nav.Key
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model "Hello, Elm/Ionic!" key, Cmd.none )


view : Model -> Browser.Document Msg
view model =
    -- Replace inline styles with an actual css file
    { title = "Elm Ionic Starter"
    , body =
        [ h1 [ Attr.style "text-align" "center" ] [ text model.message ]
        ]
    }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



--UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( UrlRequested request, _ ) ->
            case request of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.key "/"
                    )

                Browser.External url ->
                    ( model, Nav.load url )

        ( UrlChanged url, _ ) ->
            ( model
            , Nav.pushUrl model.key "/"
            )
