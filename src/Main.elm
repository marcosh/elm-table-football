module Main exposing (..)

import Html exposing (program, Html, text)
import TableFootballApp exposing (..)


main : Program Never Model Msg
main =
    program
        { init = ( Model Nothing, Cmd.none )
        , update = update
        , view = (\model -> text "hello!")
        , subscriptions = (\model -> Sub.none)
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update =
    TableFootballApp.update >> ((<<) (Tuple.mapSecond (Cmd.map E)))
