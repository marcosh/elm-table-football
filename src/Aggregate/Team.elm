module Team exposing (..)

import Player exposing (..)


type alias TeamId =
    Int


type alias TeamName =
    String



-- our team can be without players, this is a domain decision


type alias Team =
    { id : TeamId
    , name : TeamName
    , player1 : Maybe Player
    , player2 : Maybe Player
    }
