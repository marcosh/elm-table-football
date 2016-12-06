module ReadModel exposing (..)

import ReadPlayer exposing (..)
import ReadTeam exposing (..)


type alias Model =
    { players : List ReadPlayer.Player
    , teams : List ReadTeam.Team
    }


init : Model
init =
    Model [] []


players : Model -> List ReadPlayer.Player
players model =
    model.players


teams : Model -> List ReadTeam.Team
teams model =
    model.teams
