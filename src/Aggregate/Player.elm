module Player exposing (..)

import Uuid exposing (Uuid)


type alias PlayerId =
    Uuid


type alias PlayerName =
    String


type alias Player =
    { id : PlayerId
    , name : PlayerName
    }
