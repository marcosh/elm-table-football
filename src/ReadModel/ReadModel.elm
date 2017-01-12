module ReadModel exposing (..)

import Player exposing (PlayerId)
import Team exposing (TeamId)
import ReadPlayer exposing (..)
import ReadTeam exposing (..)
import AllDict exposing (AllDict, empty, get, foldl)
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


getPlayer : Players -> PlayerId -> Maybe Player
getPlayer players playerId =
    get playerId players


isThisThePlayerTeam : Player -> TeamId -> Team -> Maybe Team -> Maybe Team
isThisThePlayerTeam player teamId team maybeUpToNowTeam =
    case maybeUpToNowTeam of
        Just upToNowTeam ->
            Just upToNowTeam

        Nothing ->
            if (isPlayerInTeam player team) then
                Just team
            else
                Nothing


playerTeam : Model -> Player -> Maybe Team
playerTeam model player =
    foldl (isThisThePlayerTeam player) Nothing (teams model)


playerIsInTeam : Model -> PlayerId -> Bool
playerIsInTeam model playerId =
    case getPlayer model.players playerId of
        Nothing ->
            False

        Just player ->
            case playerTeam model player of
                Nothing ->
                    False

                Just _ ->
                    True
