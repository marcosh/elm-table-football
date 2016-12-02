module Game exposing (..)

import Team exposing (..)
import Player exposing (..)


type alias GameId =
    Int


type alias Game =
    { id : GameId
    , team1 : Team
    , team2 : Team
    , goalsScoredBy : List Player
    }
