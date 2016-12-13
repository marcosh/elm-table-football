module WriteModel exposing (..)

import Player exposing (..)
import Team exposing (..)
import Tournament exposing (..)
import AllDict exposing (AllDict, empty, get)
import Uuid exposing (toString)


type alias Model =
    { players : AllDict PlayerId Player String
    , teams : AllDict TeamId Team String
    , tournament : Maybe Tournament
    }


init : Model
init =
    Model (empty Uuid.toString) (empty Uuid.toString) Nothing


getPlayer : PlayerId -> Model -> Maybe Player
getPlayer playerId model =
    get playerId model.players


getTeam : TeamId -> Model -> Maybe Team
getTeam teamId model =
    get teamId model.teams
