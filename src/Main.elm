module Main exposing (..)

import Html exposing (program, Html, text, div, input, button)
import TableFootballView as TF exposing (..)


main : Program Never Model Msg
main =
    program
        { init = TF.init
        , update = TF.update
        , view = TF.view
        , subscriptions = always Sub.none
        }
