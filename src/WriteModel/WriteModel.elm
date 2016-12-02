module WriteModel exposing (..)

import Player exposing (..)
import Tournament exposing (..)


type alias Model =
    { players : List Player
    , tournament : Maybe Tournament
    }
