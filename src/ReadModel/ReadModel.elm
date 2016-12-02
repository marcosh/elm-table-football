module ReadModel exposing (..)

import ReadPlayer exposing (..)


type alias Model =
    { players : List ReadPlayer.Player
    }


players : Model -> List ReadPlayer.Player
players model =
    model.players
