module WriteModel exposing (..)

import Player exposing (..)
import Team exposing (..)
import Tournament exposing (..)
import AllDict exposing (AllDict, empty, get)
import Uuid exposing (toString)


type alias Players =
    AllDict PlayerId Player String


type alias Teams =
    AllDict TeamId Team String


type alias Model =
    { players : Players
    , teams : Teams
    , tournament : Maybe Tournament
    }


players : Model -> Players
players model =
    model.players


teams : Model -> Teams
teams model =
    model.teams


init : Model
init =
    Model (empty Uuid.toString) (empty Uuid.toString) Nothing


getPlayer : PlayerId -> Players -> Maybe Player
getPlayer playerId players =
    get playerId players


getTeam : TeamId -> Teams -> Maybe Team
getTeam teamId teams =
    get teamId teams
