module ReadPlayer exposing (..)

import Player exposing (PlayerId, PlayerName)
import Team exposing (TeamId)


type alias Player =
    { id : PlayerId
    , name : PlayerName
    , team : Maybe TeamId
    , goalsScored : Int
    }


newPlayer : PlayerId -> PlayerName -> Player
newPlayer playerId playerName =
    Player playerId playerName Nothing 0


whenTeamAdded : TeamId -> Player -> Player
whenTeamAdded teamId player =
    case player.team of
        Nothing ->
            { player | team = Just teamId }

        _ ->
            player
