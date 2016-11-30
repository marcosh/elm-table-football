module TableFootballApp exposing (..)

import Tournament exposing (..)
import Commands exposing (Command)
import Events exposing (Event)


type alias Model =
    { tournament : Maybe Tournament }


type Msg
    = C Command
    | E Event


update : Msg -> Model -> ( Model, Cmd Event )
update msg model =
    case msg of
        C command ->
            ( model, handleCommand command model )

        E event ->
            ( handleEvent event model, Cmd.none )


handleCommand : Command -> Model -> Cmd Event
handleCommand command model =
    Cmd.none


handleEvent : Event -> Model -> Model
handleEvent event model =
    model
