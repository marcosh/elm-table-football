module Team exposing (..)

import Player exposing (..)
import Uuid exposing (Uuid)


type alias TeamId =
    Uuid


type alias TeamName =
    String


type Players
    = NoPlayers
    | OnePlayer PlayerId
    | TwoPlayers PlayerId PlayerId



-- our team can be without players, this is a domain decision


type alias Team =
    { id : TeamId
    , name : TeamName
    , players : Players
    }


hasBothPlayers : Team -> Bool
hasBothPlayers team =
    case team.players of
        TwoPlayers firstPlayer secondPlayer ->
            True

        _ ->
            False


createTeam : TeamId -> TeamName -> Team
createTeam teamId teamName =
    Team teamId teamName NoPlayers
