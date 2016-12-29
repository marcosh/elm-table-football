module TableFootballApp exposing (CommandError, handleCommand, handleEvent, project)

import WriteModel as Write exposing (Model, getTeam)
import ReadModel as Read exposing (Model, Players)
import Player as Write exposing (Player, PlayerId)
import Team as Write exposing (Team, createTeam, hasBothPlayers, containsPlayer, addPlayer)
import ReadPlayer as Read exposing (Player, newPlayer)
import ReadTeam as Read exposing (Team, newTeam, addPlayer)
import Commands exposing (Command(..))
import Events exposing (Event(..))
import Uuid exposing (uuidGenerator)
import Random.Pcg exposing (generate)
import Task exposing (perform, succeed)
import AllDict exposing (insert, update)
import Result exposing (toMaybe)


type alias CommandError =
    String


handleCommand : Command -> Write.Model -> Result CommandError (Cmd Event)
handleCommand command model =
    case command of
        CreatePlayer playerName ->
            Ok (generate (PlayerWasCreated playerName) uuidGenerator)

        CreateTeam teamName ->
            Ok (generate (TeamWasCreated teamName) uuidGenerator)

        AddPlayerToTeam playerId teamId ->
            let
                maybeTeam =
                    getTeam teamId model.teams
            in
                case maybeTeam of
                    Nothing ->
                        Err "I am not able to retrieve the selected Team"

                    Just team ->
                        if hasBothPlayers team then
                            Err "The team has already two players"
                        else if containsPlayer team playerId then
                            Err "The player is already in the team"
                        else
                            Ok (perform (\a -> a) (succeed (PlayerWasAddedToTeam playerId teamId)))

        CreateTournament tournamentname rounds ->
            Ok Cmd.none


addPlayerToTeam : PlayerId -> Maybe Write.Team -> Maybe Write.Team
addPlayerToTeam playerId maybeTeam =
    case maybeTeam of
        Nothing ->
            Nothing

        Just team ->
            Just (Write.addPlayer team playerId)


handleEvent : Event -> Write.Model -> Write.Model
handleEvent event model =
    case event of
        PlayerWasCreated playerName playerId ->
            { model | players = insert playerId (Write.Player playerId playerName) model.players }

        TeamWasCreated teamName teamId ->
            { model | teams = insert teamId (createTeam teamId teamName) model.teams }

        PlayerWasAddedToTeam playerId teamId ->
            { model | teams = update teamId (addPlayerToTeam playerId) model.teams }

        TournamentWasCreated tournamentName rounds ->
            model

        GameStarted team1 team2 ->
            model

        GoalScored player ->
            model

        GameFinished ->
            model


addPlayerToReadTeam : Read.Player -> Maybe Read.Team -> Maybe Read.Team
addPlayerToReadTeam player maybeTeam =
    case maybeTeam of
        Nothing ->
            Nothing

        Just team ->
            Just (Read.addPlayer team player)


project : Event -> Read.Model -> Read.Model
project event model =
    case event of
        TeamWasCreated teamName teamId ->
            { model | teams = insert teamId (newTeam teamId teamName) model.teams }

        PlayerWasCreated playerName playerId ->
            { model | players = insert playerId (newPlayer playerId playerName) model.players }

        PlayerWasAddedToTeam playerId teamId ->
            let
                maybePlayer =
                    AllDict.get playerId model.players
            in
                case maybePlayer of
                    Nothing ->
                        model

                    Just player ->
                        { model | teams = update teamId (addPlayerToReadTeam player) model.teams }

        TournamentWasCreated tournamentName rounds ->
            model

        GameStarted team1 team2 ->
            model

        GoalScored player ->
            model

        GameFinished ->
            model
