module ReadModel exposing (..)

import Player exposing (PlayerId)
import Team exposing (TeamId)
import ReadPlayer exposing (..)
import ReadTeam exposing (..)
import AllDict exposing (AllDict, empty, get)
import Uuid exposing (toString)


type alias Players =
    AllDict PlayerId Player String


type alias Teams =
    AllDict TeamId Team String


type alias Model =
    { players : Players
    , teams : Teams
    }


init : Model
init =
    Model (empty Uuid.toString) (empty Uuid.toString)


players : Model -> Players
players model =
    model.players


teams : Model -> Teams
teams model =
    model.teams
