module ReadTeam exposing (..)

import Team exposing (TeamId, TeamName)
import ReadPlayer exposing (Player)


-- here we are sloppy with the modelling, since we need this only to display things


type alias Team =
    { id : TeamId
    , name : TeamName
    , player1 : Maybe Player
    , player2 : Maybe Player
    , goalsScored : Int
    , goalsConceded : Int
    , gamesWon : Int
    , gamesLost : Int
    }


newTeam : TeamId -> TeamName -> Team
newTeam id name =
    Team id name Nothing Nothing 0 0 0 0


whenPlayerAdded : Team -> Player -> Team
whenPlayerAdded team player =
    case team.player1 of
        Nothing ->
            { team | player1 = Just player }

        Just player1 ->
            if player1 == player then
                team
            else
                case team.player2 of
                    Nothing ->
                        { team | player2 = Just player }

                    Just player2 ->
                        team
