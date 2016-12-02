module TableFootballUI exposing (..)

import TableFootballApp as App exposing (handleCommand, handleEvent, project)
import WriteModel as Write exposing (Model)
import ReadModel as Read exposing (Model, players)
import Html exposing (Html, div, input, button, text)
import Html.Events exposing (onInput, onClick)
import Html.Attributes exposing (value)
import Commands exposing (Command)
import Events exposing (Event)
import ReadPlayer as Read exposing (Player)


type alias Model =
    { writeModel : Write.Model
    , readModel : Read.Model
    , inputPlayer : String
    }


init : ( Model, Cmd Msg )
init =
    ( Model (Write.Model [] Nothing) (Read.Model []) "", Cmd.none )


type Msg
    = AppCommand (Command)
    | AppEvent (Event)
    | PlayerInputReceived String
    | CreatePlayer


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AppCommand command ->
            ( model, Cmd.map AppEvent (handleCommand command model.writeModel) )

        AppEvent event ->
            ( { model | writeModel = handleEvent event model.writeModel, readModel = project event model.readModel }, Cmd.none )

        PlayerInputReceived input ->
            ( { model | inputPlayer = input }, Cmd.none )

        CreatePlayer ->
            ( { model | inputPlayer = "" }, Cmd.map AppEvent (handleCommand (Commands.CreatePlayer model.inputPlayer) model.writeModel) )


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput PlayerInputReceived, value model.inputPlayer ] []
        , button [ onClick CreatePlayer ] [ text "Create Player" ]
        , div [] (List.map showPlayer (players model.readModel))
        ]


showPlayer : Read.Player -> Html Msg
showPlayer player =
    div [] [ text player.name ]
