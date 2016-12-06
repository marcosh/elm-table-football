module WriteModel exposing (..)

import Player exposing (..)
import Team exposing (..)
import Tournament exposing (..)


type alias Model =
    { players : List Player
    , teams : List Team
    , tournament : Maybe Tournament
    }


init : Model
init =
    Model [] [] Nothing
