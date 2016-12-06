module ReadPlayer exposing (..)

import Player exposing (PlayerId, PlayerName)


type alias Player =
    { id : PlayerId
    , name : PlayerName
    , goalsScored : Int
    }


newPlayer : PlayerId -> PlayerName -> Player
newPlayer playerId playerName =
    Player playerId playerName 0
