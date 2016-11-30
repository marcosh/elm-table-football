module Player exposing (..)


type alias PlayerId =
    Int


type alias PlayerName =
    String


type alias Player =
    { id : PlayerId
    , name : PlayerName
    }
