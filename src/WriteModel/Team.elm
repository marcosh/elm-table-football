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


id : Team -> TeamId
id team =
    team.id


hasBothPlayers : Team -> Bool
hasBothPlayers team =
    case team.players of
        TwoPlayers firstPlayer secondPlayer ->
            True

        _ ->
            False


containsPlayer : Team -> PlayerId -> Bool
containsPlayer team playerId =
    case team.players of
        NoPlayers ->
            False

        OnePlayer existingPlayerId ->
            playerId == existingPlayerId

        TwoPlayers player1 player2 ->
            playerId == player1 || playerId == player2


createTeam : TeamId -> TeamName -> Team
createTeam teamId teamName =
    Team teamId teamName NoPlayers


whenPlayerAdded : Team -> PlayerId -> Team
whenPlayerAdded team playerId =
    case team.players of
        NoPlayers ->
            { team | players = OnePlayer playerId }

        OnePlayer existingPlayerId ->
            if existingPlayerId == playerId then
                team
            else
                { team | players = TwoPlayers existingPlayerId playerId }

        TwoPlayers player1 player2 ->
            team
