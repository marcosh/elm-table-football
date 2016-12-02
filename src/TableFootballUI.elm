module TableFootballUI exposing (..)

import TableFootballApp as App exposing (..)
import Html exposing (Html, div, input, button, text)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (value)
import Commands exposing (Command)
import Events exposing (Event)


type alias Model =
    { appModel : App.Model
    , inputPlayer : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model (App.Model [] Nothing) "", Cmd.none )


type Msg
    = AppCommand (Command)
    | AppEvent (Event)
    | PlayerInputReceived String
    | CreatePlayer


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AppCommand command ->
            ( model, Cmd.map AppEvent (handleCommand command model.appModel) )

        AppEvent event ->
            ( { model | appModel = handleEvent event model.appModel }, Cmd.none )

        PlayerInputReceived input ->
            ( { model | inputPlayer = input }, Cmd.none )

        CreatePlayer ->
            ( { model | inputPlayer = "" }, Cmd.map AppEvent (handleCommand (Commands.CreatePlayer model.inputPlayer) model.appModel) )


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput PlayerInputReceived, value model.inputPlayer ] []
        , button [ onClick CreatePlayer ] [ text "Create Player" ]
        ]
