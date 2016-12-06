module ReadTeam exposing (..)

import Team exposing (TeamId, TeamName)
import ReadPlayer exposing (Player)


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
