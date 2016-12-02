module Tournament exposing (..)

import Team exposing (..)
import Game exposing (..)


type alias TournamentId =
    Int


type alias TournamentName =
    String


type alias Rounds =
    Int


type alias Tournament =
    { name : TournamentName
    , rounds : Rounds
    , teams : List Team
    , playedGames : List Game
    }
