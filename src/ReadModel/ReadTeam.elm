module ReadTeam exposing (..)

import Team exposing (TeamId, TeamName)
import ReadPlayer exposing (Player)


type Players
    = NoPlayers
    | OnePlayer Player
    | TwoPlayers Player Player


type alias Team =
    { id : TeamId
    , name : TeamName
    , players : Players
    , goalsScored : Int
    , goalsConceded : Int
    , gamesWon : Int
    , gamesLost : Int
    }


newTeam : TeamId -> TeamName -> Team
newTeam id name =
    Team id name NoPlayers 0 0 0 0


whenPlayerAdded : Team -> Player -> Team
whenPlayerAdded team player =
    case team.players of
        NoPlayers ->
            { team | players = OnePlayer player }

        OnePlayer player1 ->
            if player == player1 then
                team
            else
                { team | players = TwoPlayers player1 player }

        TwoPlayers player1 player2 ->
            team


teamPlayers : Team -> List Player
teamPlayers team =
    case team.players of
        NoPlayers ->
            []

        OnePlayer player1 ->
            [ player1 ]

        TwoPlayers player1 player2 ->
            [ player1, player2 ]


isPlayerInTeam : Player -> Team -> Bool
isPlayerInTeam player team =
    case team.players of
        NoPlayers ->
            False

        OnePlayer player1 ->
            player1 == player

        TwoPlayers player1 player2 ->
            player1 == player || player2 == player
